package com.productHub.domain

class OrderForm {
	
	OrderStatus status
	User customer
	double totalPrice
	
	static hasMany = [products: Product]
	static belongsTo = [store: Store]
	
	
    static constraints = {
    }
}
