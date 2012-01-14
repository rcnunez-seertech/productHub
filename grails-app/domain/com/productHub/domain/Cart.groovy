package com.productHub.domain

class Cart {
	static belongsTo = [user: User]

	static hasMany = [products: Product]

    static constraints = {
		user(nullable:false)
    }
}
