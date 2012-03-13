package com.productHub.domain

class Store {
	String storeName
	String storeCode
	String description
	String meetUpLocations
	
	static hasMany = [products: Product, comments:Comment, orders: OrderForm]
	static belongsTo = [user: User]
	
	byte[] logo
	
	String accountDetails
	
	boolean isValidated = false
	boolean acceptsDirect = false
	boolean acceptsMoneyTransfer = false

    static constraints = {
		storeName (unique:true, blank:false, size: 5..30)
		storeCode (unique:true, blank:false, size: 5..15)
		user (validator: { val, obj -> 
			switch(obj.user.userRole) {
				case RoleType.ROLE_ADMINISTRATOR:
				case RoleType.ROLE_CLIENT:
					return ['invalidaccount']
					break
				
				case RoleType.ROLE_VENDOR:
					boolean isValid=false
					if(val) {
						isValid=true
					}

					if (isValid ==false) {
						return ['nodepot']
					} 
					
					return isValid
					
					break
			}
		})
		orders(nullable:true)
		logo(nullable:true)
		
	accountDetails(nullable:true, validator: {val, obj ->
		if(obj.acceptsMoneyTransfer && !val) {
			return ['nodetails']
		} else {
			return true
		}
	})
		
    }
}
