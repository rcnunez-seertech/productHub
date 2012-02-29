package com.productHub.domain

class Product {

	String productName
	String productCode
	int quantity
	float price
	String description
	byte[] image
	
	static belongsTo = [store: Store]
	static hasMany = [comments: Comment]

    static constraints = {
		productName(unique:true, blank:false)
		productCode(unique:true, blank:false)
		quantity(blank:false)
		price(blank:false)
    }
}
