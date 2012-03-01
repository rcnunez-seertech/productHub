package com.productHub.domain

class OrderForm {

	Cart cart
	OrderStatus status
	PaymentType payment
	byte[] paymentProof
	String paymentNotes

    static constraints = {
		cart(nullable:false)
		
    }
}
