package com.productHub.controller
import com.productHub.domain.*
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMINISTRATOR', 'ROLE_CLIENT'])
class WishlistController {
	def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

	
    def list = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		if(userInstance?.userRole == RoleType.ROLE_CLIENT) {
			redirect(action: "show", id: userInstance?.wishlist?.id)
		}
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [wishlistInstanceList: Wishlist.list(params), wishlistInstanceTotal: Wishlist.count()]
    }

    def create = {
        def wishlistInstance = new Wishlist()
        wishlistInstance.properties = params
        return [wishlistInstance: wishlistInstance]
    }

    def save = {
        def wishlistInstance = new Wishlist(params)
        if (wishlistInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'wishlist.label', default: 'Wishlist'), wishlistInstance.id])}"
            redirect(action: "show", id: wishlistInstance.id)
        }
        else {
            render(view: "create", model: [wishlistInstance: wishlistInstance])
        }
    }

    def show = {
        def wishlistInstance = Wishlist.get(params.id)
        if (!wishlistInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'wishlist.label', default: 'Wishlist'), params.id])}"
            redirect(action: "list")
        }
        else {
            [wishlistInstance: wishlistInstance]
        }
    }

    def edit = {
        def wishlistInstance = Wishlist.get(params.id)
        if (!wishlistInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'wishlist.label', default: 'Wishlist'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [wishlistInstance: wishlistInstance]
        }
    }

    def update = {
        def wishlistInstance = Wishlist.get(params.id)
        if (wishlistInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (wishlistInstance.version > version) {
                    
                    wishlistInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'wishlist.label', default: 'Wishlist')] as Object[], "Another user has updated this Wishlist while you were editing")
                    render(view: "edit", model: [wishlistInstance: wishlistInstance])
                    return
                }
            }
            wishlistInstance.properties = params
            if (!wishlistInstance.hasErrors() && wishlistInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'wishlist.label', default: 'Wishlist'), wishlistInstance.id])}"
                redirect(action: "show", id: wishlistInstance.id)
            }
            else {
                render(view: "edit", model: [wishlistInstance: wishlistInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'wishlist.label', default: 'Wishlist'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def wishlistInstance = Wishlist.get(params.id)
        if (wishlistInstance) {
            try {
                wishlistInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'wishlist.label', default: 'Wishlist'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'wishlist.label', default: 'Wishlist'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'wishlist.label', default: 'Wishlist'), params.id])}"
            redirect(action: "list")
        }
    }
}
