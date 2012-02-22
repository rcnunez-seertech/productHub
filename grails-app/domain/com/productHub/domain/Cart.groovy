package com.productHub.domain

class Cart {
	static belongsTo = [user: User]

	static hasMany = [products: Product, stores: Store]

    static constraints = {
		user(nullable:false)
    }
}
