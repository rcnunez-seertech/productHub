package com.productHub.domain

class CartController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cartInstanceList: Cart.list(params), cartInstanceTotal: Cart.count()]
    }

    def create = {
        def cartInstance = new Cart()
        cartInstance.properties = params
        return [cartInstance: cartInstance]
    }

    def save = {
        def cartInstance = new Cart(params)
        if (cartInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'cart.label', default: 'Cart'), cartInstance.id])}"
            redirect(action: "show", id: cartInstance.id)
        }
        else {
            render(view: "create", model: [cartInstance: cartInstance])
        }
    }

    def show = {
        def cartInstance = Cart.get(params.id)
        if (!cartInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cart.label', default: 'Cart'), params.id])}"
            redirect(action: "list")
        }
        else {
            [cartInstance: cartInstance]
        }
    }

    def edit = {
        def cartInstance = Cart.get(params.id)
        if (!cartInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cart.label', default: 'Cart'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [cartInstance: cartInstance]
        }
    }

    def update = {
        def cartInstance = Cart.get(params.id)
        if (cartInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (cartInstance.version > version) {
                    
                    cartInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'cart.label', default: 'Cart')] as Object[], "Another user has updated this Cart while you were editing")
                    render(view: "edit", model: [cartInstance: cartInstance])
                    return
                }
            }
            cartInstance.properties = params
            if (!cartInstance.hasErrors() && cartInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cart.label', default: 'Cart'), cartInstance.id])}"
                redirect(action: "show", id: cartInstance.id)
            }
            else {
                render(view: "edit", model: [cartInstance: cartInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cart.label', default: 'Cart'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def cartInstance = Cart.get(params.id)
        if (cartInstance) {
            try {
                cartInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'cart.label', default: 'Cart'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'cart.label', default: 'Cart'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cart.label', default: 'Cart'), params.id])}"
            redirect(action: "list")
        }
    }
}
