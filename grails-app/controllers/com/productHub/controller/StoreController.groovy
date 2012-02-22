package com.productHub.controller

import grails.plugins.springsecurity.Secured
import com.productHub.domain.*

@Secured(['IS_AUTHENTICATED_FULLY'])
class StoreController {

	def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
        redirect(action: "list", params: params)
    }

	
    def list = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [storeInstanceList: Store.list(params), storeInstanceTotal: Store.count(), userInstance: userInstance]
    }

	@Secured(['ROLE_VENDOR'])
    def create = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
        def storeInstance = new Store()
        storeInstance.properties = params
		//storeInstance.user = userInstance
        return [storeInstance: storeInstance]
    }

	@Secured(['ROLE_VENDOR'])
    def save = {
        def storeInstance = new Store(params)
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		storeInstance.user = userInstance
        if (storeInstance.save(flush: true)) {
			userInstance.store = storeInstance
			userInstance.confirmPassword = userInstance.password
			userInstance.save(flush: true, failOnError:true)
			println "USERSAVED" + userInstance.store
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'store.label', default: 'Store'), storeInstance.id])}"
            redirect(action: "show", id: storeInstance.id)
        }
        else {
            render(view: "create", model: [storeInstance: storeInstance])
        }
    }

	def myStore = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
		def storeInstance = userInstance.store
		if(userInstance.store) {
			redirect(action: "show", id: storeInstance.id)
		} else {
			redirect(action: "create")
		}
	}
	
    def show = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
        def storeInstance = Store.get(params.id)
        if (!storeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'store.label', default: 'Store'), params.id])}"
            redirect(action: "list")
        }
        else {
            [storeInstance: storeInstance, userInstance: userInstance]
        }
    }

	@Secured(['ROLE_VENDOR'])
    def edit = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
        def storeInstance = Store.get(params.id)
		
		if(userInstance.store == storeInstance) {
			if (!storeInstance) {
				flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'store.label', default: 'Store'), params.id])}"
				redirect(action: "list")
			}
			else if (storeInstance.user == userInstance) {
				return [storeInstance: storeInstance]
			} else {
				// *** Error message.
			}
		} else {	
			flash.message = "You cannot edit a store that is not yours."
			redirect(action: "list")
		}
    }

	@Secured(['ROLE_VENDOR'])
    def update = {
        def storeInstance = Store.get(params.id)
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
        if (storeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (storeInstance.version > version) {
                    storeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'store.label', default: 'Store')] as Object[], "Another user has updated this Store while you were editing")
                    render(view: "edit", model: [storeInstance: storeInstance])
                    return
                }
            }
            storeInstance.properties = params
            if (!storeInstance.hasErrors() && storeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'store.label', default: 'Store'), storeInstance.id])}"
                redirect(action: "show", id: storeInstance.id)
            }
            else {
                render(view: "edit", model: [storeInstance: storeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'store.label', default: 'Store'), params.id])}"
            redirect(action: "list")
        }
    }
	@Secured(['ROLE_VENDOR'])
    def delete = {
		def userInstance = User.findByUsername(springSecurityService.authentication.name)
        def storeInstance = Store.get(params.id)
        if (storeInstance) {
            try {
                storeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'store.label', default: 'Store'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'store.label', default: 'Store'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'store.label', default: 'Store'), params.id])}"
            redirect(action: "list")
        }
    }
}
