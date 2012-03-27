package com.productHub.controller

import grails.plugins.springsecurity.Secured
import com.productHub.domain.*
import com.productHub.domain.RoleType

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        [userInstanceList: User.list(), userInstanceTotal: User.count()]
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params
		//userInstance.cart = new Cart(user: User.get(userInstance.id))
        return [userInstance: userInstance]
    }

    def save = {
        def userInstance = new User(params)
		Role role = Role.findByAuthority(userInstance?.userRole?.getKey())
		
		if(userInstance.userRole == RoleType.ROLE_CLIENT) {
			userInstance.wishlist = new Wishlist(user: userInstance)
		}
		
        if (userInstance.save(flush: true)) {
			UserRole.create userInstance, role, true
			println "Created instance for " + userInstance.username + " : " + role
			
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
            redirect(action: "show", id: userInstance.id)
        }
		
        else {
            render(view: "create", model: [userInstance: userInstance])
        }
    }

    def show = {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            [userInstance: userInstance]
        }
    }
	
	@Secured(['ROLE_VENDOR'])
	def dashboard = { 
		render 'Trolololol'
	}

    def edit = {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userInstance: userInstance]
        }
    }

    def update = {
        def userInstance = User.get(params.id)
		def oldPassword = userInstance.password
        if (userInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userInstance.version > version) {
                    
                    userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'user.label', default: 'User')] as Object[], "Another user has updated this User while you were editing")
                    render(view: "edit", model: [userInstance: userInstance])
                    return
                }
            }
            userInstance.properties = params
			userInstance.password = oldPassword
			userInstance.confirmPassword = oldPassword
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
                redirect(action: "show", id: userInstance.id)
            }
            else {
                render(view: "edit", model: [userInstance: userInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }
	
	
	@Secured(['ROLE_ADMINISTRATOR']) 
	def deactivate = {
		def userInstance = User.get(params.id)
		if(userInstance) {
			userInstance.enabled = false
			userInstance.confirmPassword = userInstance.password
			userInstance.save(flush:true, failOnError:true)
			flash.message = "${userInstance.username} has been deactivated."
			redirect(action: "list")
		}
	}
	
	@Secured(['ROLE_ADMINISTRATOR']) 
	def activate = {
		def userInstance = User.get(params.id)
		if(userInstance) {
			userInstance.enabled = true
			userInstance.confirmPassword = userInstance.password
			userInstance.save(flush:true, failOnError:true)
			flash.message = "${userInstance.username} has been activated."
			redirect(action: "list")
		}
	}
	
	@Secured(['ROLE_ADMINISTRATOR'])
    def delete = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            try {
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }
}
