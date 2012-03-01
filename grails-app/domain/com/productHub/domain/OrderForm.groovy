package com.productHub.domain

class OrderForm {
	Cart cart
	Store store
	OrderStatus status = OrderStatus.SENT_TO_SHOP
	PaymentType payment
	byte[] paymentProof
	String paymentNotes

    static constraints = {
		cart(nullable:false)
		paymentProof(nullable:true)
		paymentNotes(nullable:true)
		
    }
}
