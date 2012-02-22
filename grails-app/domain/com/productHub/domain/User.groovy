package com.productHub.domain


class User {

	transient springSecurityService

	String firstName
    String lastName
    String username
    String password
    String contactNumber
    String emailAddress
    RoleType userRole
	
	Store store
	Cart cart
	
	String shippingAddress
	
	
	byte[] avatar
    boolean enabled = true
    boolean accountExpired = false
    boolean accountLocked = false
    boolean passwordExpired = false

    String confirmPassword

	static constraints = {
		firstName (blank:false)
        lastName  (blank:false)
        password (blank:false, validator: {
                      val, obj ->
                          if(obj.properties['confirmPassword'] != val){
                              return ['dontmatch']
                          }
                  }
            )
        username  (blank:false, size:5..15, matches:/[\S]+/, unique:true)
        emailAddress (email:true, blank:false, nullable:false, unique:true)
        contactNumber (matches:/[\d]+/)
        userRole (nullable:false)
		store (nullable:true)
		cart (nullable:true, validator: { val, obj ->
            switch(obj.userRole) {
			case RoleType.ROLE_ADMINISTRATOR:
            case RoleType.ROLE_VENDOR:
                return true
                break

            case RoleType.ROLE_CLIENT:
                boolean isValid=false
                if(val) {
                    isValid=true
                }

                if (isValid ==false) {
                    return ['nocart']
                }
				return isValid
                break
            }
        })
		
		shippingAddress (nullable:true, validator:
			{ val, obj ->
				switch(obj.userRole) {
				case RoleType.ROLE_ADMINISTRATOR:
				case RoleType.ROLE_VENDOR:
					return true
					break
				
				case RoleType.ROLE_CLIENT:
                boolean isValid=false
                if(val) {
                    isValid=true
                }

                if (isValid ==false) {
                    return ['noaddress']
                }
				return isValid
                break
				}
			}
		)
		
		avatar (nullable:true)
		
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def passwordsMatch(String sentPassword) {
        return sentPassword.equals(password)
    }
	
	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}
