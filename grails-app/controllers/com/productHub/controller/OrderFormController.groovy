package com.productHub.controller
import com.productHub.domain.*

class OrderFormController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [orderFormInstanceList: OrderForm.list(params), orderFormInstanceTotal: OrderForm.count()]
    }

    

    def save = {
        def orderFormInstance = new OrderForm(params)
		def cartInstance = Cart.get(params.cartInstance)
		orderFormInstance.cart = cartInstance
		orderFormInstance.store = cartInstance.store
        if (orderFormInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), orderFormInstance.id])}"
            redirect(action: "show", id: orderFormInstance.id)
        }
        else {
            render(view: "checkout", model: [orderFormInstance: orderFormInstance])
        }
    }

    def show = {
        def orderFormInstance = OrderForm.get(params.id)
        if (!orderFormInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'orderForm.label', default: 'OrderForm'), params.id])}"
            redirect(action: "list")
        }
        else {
            [orderFormInstance: orderFormInstance]
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
                redirect(action: "show", id: orderFormInstance.id)
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
		
		orderFormInstance.payment = params.payment
		orderFormInstance.paymentNotes = params.paymentNotes
		orderFormInstance.cart = cartInstance
		orderFormInstance.store = cartInstance.store
		
		return [orderFormInstance: orderFormInstance, cartInstance: cartInstance]
	
	}
}
