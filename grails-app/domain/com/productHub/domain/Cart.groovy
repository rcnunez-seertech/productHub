package com.productHub.domain

class Cart {
	static belongsTo = [user: User]
	Store store
	static hasMany = [orders: ProductOrder]

    static constraints = {
		user(nullable:false)
    }
}
