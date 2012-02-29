package com.productHub.domain

class Wishlist {
	static belongsTo = [user: User]
	static hasMany = [products: Product]
    static constraints = {
		user(nullable:true)
    }
}
