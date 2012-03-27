package com.productHub.controller

import grails.plugins.springsecurity.Secured
import com.productHub.domain.*

class ProductController {
	def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
        [productInstanceList: Product.list(), productInstanceTotal: Product.count(), userInstance: userInstance]
    }
	
	def image = {
		def productImage = Product.get(params.id)
		byte[] prodImage 
		if(productImage?.image) {
			prodImage = productImage.image
		} else {
			String pathToImage = g.createLinkTo(dir:"images", file:"noimage.jpg").toString()
			//prodImage = pathToImage
			//println pathToImage
		}
		response.outputStream << prodImage
	}
	
	
	@Secured(['ROLE_CLIENT'])
	def addComment = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		def productInstance = Product.get(params.id)
		def commentInstance = new Comment()
		commentInstance.properties = params
		commentInstance.author = userInstance
		commentInstance.product = productInstance
		productInstance.addToComments(commentInstance)
		if (productInstance.save(flush:true, failOnError:true)) {
			flash.message = "Rating Added."
			redirect(action: "show", id: productInstance.id)
		}
		
		
	}

	@Secured(['ROLE_VENDOR'])
    def create = {
		
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		if(userInstance.store) {
			def productInstance = new Product()
			productInstance.properties = params
			return [productInstance: productInstance]
		} else {
			flash.message = "You can't add products if you don't have a store yet."
			redirect(action: "list")
		}
    }

    def save = {
        def productInstance = new Product(params)
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		productInstance.store = userInstance.store
        if (productInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'product.label', default: 'Product'), productInstance.id])}"
            redirect(action: "show", id: productInstance.id)
        }
        else {
            render(view: "create", model: [productInstance: productInstance])
        }
    }

    def show = {
        def productInstance = Product.get(params.id)
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		
        if (!productInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
            redirect(action: "list")
        }
        else {
            [productInstance: productInstance, userInstance:userInstance]
        }
    }

    def edit = {
        def productInstance = Product.get(params.id)
        if (!productInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [productInstance: productInstance]
        }
    }

    def update = {
        def productInstance = Product.get(params.id)
        if (productInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (productInstance.version > version) {
                    
                    productInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'product.label', default: 'Product')] as Object[], "Another user has updated this Product while you were editing")
                    render(view: "edit", model: [productInstance: productInstance])
                    return
                }
            }
            productInstance.properties = params
            if (!productInstance.hasErrors() && productInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'product.label', default: 'Product'), productInstance.id])}"
                redirect(action: "show", id: productInstance.id)
            }
            else {
                render(view: "edit", model: [productInstance: productInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
            redirect(action: "list")
        }
    }
	
	@Secured(['ROLE_CLIENT'])
	def addToWishlist = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		def productInstance = Product.get(params.id)
		
		userInstance.wishlist.addToProducts(productInstance)
		productInstance.save(flush:true, failOnError:true)
		
		flash.message = "Product has been added to your wishlist."
		redirect(action: "show", controller:"wishlist", id: userInstance.wishlist.id)
		
	}
	
	@Secured(['ROLE_CLIENT'])
	def removeFromWishlist = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		def productInstance = Product.get(params.id)
		
		userInstance.wishlist.removeFromProducts(productInstance)
		productInstance.save(flush:true, failOnError:true)
		
		flash.message = "Product has been removed from your wishlist."
		redirect(action: "show", controller:"wishlist", id: userInstance.wishlist.id)
		
	}

    def delete = {
		
        def productInstance = Product.get(params.id)
        if (productInstance) {
            try {
                productInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
            redirect(action: "list")
        }
    }
	
	
	@Secured(['ROLE_CLIENT'])
    def addToCart = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		def productInstance = Product.get(params.id)
		def cartInstance = new Cart()
		def orderInstance = new ProductOrder()
		def orderExists = false
		
		if(!userInstance.carts) {
			cartInstance.user = userInstance
			cartInstance.store = productInstance.store
			userInstance.addToCarts(cartInstance.save(flush:true, failOnError:true))
		} else if(userInstance?.carts && !(userInstance?.carts).find{it?.store == productInstance?.store && !it?.isCheckedOut}) {
			cartInstance.user = userInstance
			cartInstance.store = productInstance.store
			userInstance.addToCarts(cartInstance.save(flush:true, failOnError:true))
		} else {
			cartInstance = (userInstance?.carts).find{it?.store == productInstance?.store && !it.isCheckedOut}
			if(cartInstance.orders.find{it.product == productInstance}) {
				orderInstance = cartInstance.orders.find{it.product == productInstance}
				orderExists = true
			}
		}
		
		
		try {
			if(Integer.parseInt(params.quantity) <= productInstance.quantity) {
				orderInstance.quantity = Integer.parseInt(params.quantity)
				orderInstance.clientNotes = params.clientNotes
				orderInstance.product = productInstance
				
				orderInstance.save(flush:true, failOnError:true)
				
				cartInstance.user = userInstance
				cartInstance.store = productInstance.store
				cartInstance.addToOrders(orderInstance)
				cartInstance.save(flush:true, failOnError:true)
				userInstance.confirmPassword = userInstance.password
				userInstance.save(flush:true, failOnError:true)
				
				if(orderExists) {
					flash.message = productInstance.productName + "'s order details have been updated."
				} else {
					flash.message = productInstance.productName + " has been added to your cart."
				}
				redirect(action: "show", controller: "cart", id: userInstance.id)
			} else {
				flash.message = "Your quantity cannot be greater than the current amount in stock."
				redirect(action: "show", id: productInstance.id)
			}
			
			
		} catch (NumberFormatException e) {
			println "HI"
			flash.message = "Your quantity was not a number, please try again."
			redirect(action: "show", id: productInstance.id)			
		}
		
		
    }
	
	
	
		
}
