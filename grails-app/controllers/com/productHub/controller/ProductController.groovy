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
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [productInstanceList: Product.list(params), productInstanceTotal: Product.count(), userInstance: userInstance]
    }
	
	def image = {
		def productImage = Product.get(params.id)
		byte[] prodImage = productImage.image
		response.outputStream << prodImage
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
		def productInstance = Product.get(params.id)
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		
		if(!userInstance.cart.stores.contains(productInstance.store)) {
			userInstance.cart.addToStores(productInstance.store)
			println "LOL PASOK PLZ."
		}
		
		println userInstance.cart.stores
		userInstance.cart.addToProducts(productInstance)
		userInstance.confirmPassword = userInstance.password
		userInstance.save(flush:true, failOnError:true)
        flash.message = "Product has been added to your cart."
		redirect(action: "show", id: productInstance.id)
    }
	
	@Secured(['ROLE_CLIENT'])
	def removeFromCart = {
		def productInstance = Product.get(params.id)
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		userInstance.cart.removeFromProducts(productInstance)
		def products = (userInstance.cart.products).findAll{it.store == productInstance.store}
		
		if(!products) {
			userInstance.cart.removeFromStores(productInstance.store)
			println "removed " + productInstance.store + "from stores"
		}
		
		userInstance.confirmPassword = userInstance.password
		userInstance.save(flush:true, failOnError:true)
		
		println "Stores in cart: " + userInstance.cart.stores
		flash.message = "Product has been removed from your cart."
		redirect(action: "show", id: productInstance.id)
	}
	
}
