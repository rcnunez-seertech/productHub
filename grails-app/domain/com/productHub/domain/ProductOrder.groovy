package com.productHub.domain

class ProductOrder {
	
	int quantity
	String clientNotes
	String vendorNotes
	
	static belongsTo = [product: Product]
	

    static constraints = {
		product(nullable:false)
		clientNotes(nullable:true)
		vendorNotes(nullable:true)
		quantity(blank:false, min:1)
    }
}
