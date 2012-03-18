package com.productHub.controller
import com.productHub.domain.*
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class OrderFormController {
	def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def userInstance = User.findByUsername(springSecurityService.authentication.name)
		if(userInstance?.userRole == RoleType.ROLE_CLIENT || userInstance?.userRole == RoleType.ROLE_VENDOR) {
				redirect(action: "show")
		} else {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			[cartInstanceList: Cart.list(params), cartInstanceTotal: Cart.count()]
		}
    }
    
    @Secured(['ROLE_CLIENT'])
    def uploadForm = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		def orderFormInstance = OrderForm.get(params.id)
		orderFormInstance.properties = params
		orderFormInstance.save(flush:true, failOnError:true)
		[orderFormInstance : orderFormInstance]
    
    }
	
	def changeStatus = {
		def orderFormInstance = OrderForm.get(params.id)
		[orderFormInstance : orderFormInstance]
	}
    
    def update2 = {
	def orderFormInstance = OrderForm.get(params.id)
        if (orderFormInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (orderFormInstance.version > version) {
                    
                    orderFormInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'orderForm.label', default: 'OrderForm')] as Object[], "Another user has updated this OrderForm while you were editing")
                    render(view: "edit", model: [orderFormInstance: orderFormInstance])
                    return
                }
            }
            orderFormInstance.properties = params
	    orderFormInstance.status = OrderStatus.PAYMENT_SENT
            if (!orderFormInstance.hasErrors() && orderFormInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), orderFormInstance.id])}"
                redirect(action: "myOrders", id: orderFormInstance.id)
            }
            else {
                render(view: "edit", model: [orderFormInstance: orderFormInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), params.id])}"
            redirect(action: "list")
        }
    }
    
    
    
    
    def image = {
	def orderFormInstance = OrderForm.get(params.id)
	byte[] orderImage
	if(orderFormInstance?.paymentProof) {
		orderImage = orderFormInstance.paymentProof
	} 
	response.outputStream << orderImage
}
    

	@Secured(['ROLE_CLIENT'])
    def save = {
	def userInstance = User.findByUsername(springSecurityService.authentication.name)
        def orderFormInstance = new OrderForm(params)
	def cartInstance = Cart.get(params.cartInstance)
	orderFormInstance.cart = cartInstance
	orderFormInstance.store = cartInstance.store
	orderFormInstance.customer = userInstance
	
	if(orderFormInstance.paymentProof) {
		orderFormInstance.status = OrderStatus.PAYMENT_SENT
	}
		
        if (orderFormInstance.save(flush: true)) {
			orderFormInstance.cart.isCheckedOut = true
			orderFormInstance.cart.save(flush:true, failOnError:true)
			
			orderFormInstance.store.addToOrders(orderFormInstance)
			orderFormInstance.store.save(flush:true, failOnError:true)
			
			orderFormInstance.cart.orders.each(){
				println it.product.productName + " = " + it.quantity
				it.product.quantity -= it.quantity
				println it.product.productName + " = " + it.quantity
				it.product.save(flush:true, failOnError:true)
			}
			
			
			userInstance.addToOrders(orderFormInstance)
			userInstance.confirmPassword = userInstance.password
			userInstance.save(flush:true, failOnError:true)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), orderFormInstance.id])}"
            redirect(action: "myOrders")
        }
        else {
            render(view: "checkout", model: [orderFormInstance: orderFormInstance])
        }
    }
	
	def myOrders = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		def orderForms
		if(userInstance?.userRole == RoleType.ROLE_CLIENT) {
			orderForms = OrderForm.findAllByCustomer(userInstance)
		} else if(userInstance?.userRole == RoleType.ROLE_VENDOR) {
			if(userInstance?.store?.orders) {
				orderForms = userInstance?.store?.orders
			} else {
				flash.message = "You can't have orders if you don't have a store. Please make your store first."
				redirect(action: "create", controller: "store")
			}
		}
		
		[orderForms: orderForms]
	}
	
	
	def processedOrders = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		def orderForms
		if(userInstance?.userRole == RoleType.ROLE_CLIENT) {
			orderForms = OrderForm.findAllByCustomer(userInstance)
		} else if(userInstance?.userRole == RoleType.ROLE_VENDOR) {
			if(userInstance?.store?.orders) {
				orderForms = userInstance?.store?.orders
			} else {
				flash.message = "You can't have orders if you don't have a store. Please make your store first."
				redirect(action: "create", controller: "store")
			}
		}
		
		[orderForms: orderForms]
	}

    def show = {
	def orderFormInstance = OrderForm.get(params.id)
	def userInstance = User.findByUsername(springSecurityService.authentication.name)
		
        if (!orderFormInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), params.id])}"
            redirect(action: "list")
        }
        else {
            [orderFormInstance: orderFormInstance, userInstance:userInstance]
        }
    }

    def edit = {
        def orderFormInstance = OrderForm.get(params.id)
        if (!orderFormInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [orderFormInstance: orderFormInstance]
        }
    }

    def update = {
        def orderFormInstance = OrderForm.get(params.id)
        if (orderFormInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (orderFormInstance.version > version) {
                    
                    orderFormInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'orderForm.label', default: 'OrderForm')] as Object[], "Another user has updated this OrderForm while you were editing")
                    render(view: "edit", model: [orderFormInstance: orderFormInstance])
                    return
                }
            }
            orderFormInstance.properties = params
            if (!orderFormInstance.hasErrors() && orderFormInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), orderFormInstance.id])}"
                redirect(action: "myOrders")
            }
            else {
                render(view: "edit", model: [orderFormInstance: orderFormInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def orderFormInstance = OrderForm.get(params.id)
        if (orderFormInstance) {
            try {
                orderFormInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def checkout = {
		def cartInstance = Cart.get(params.id)
		def orderFormInstance = new OrderForm()
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		
		orderFormInstance.payment = params.payment
		orderFormInstance.paymentNotes = params.paymentNotes
		orderFormInstance.cart = cartInstance
		orderFormInstance.store = cartInstance.store
		orderFormInstance.customer = userInstance
		
		return [orderFormInstance: orderFormInstance, cartInstance: cartInstance]
	
	}
}
