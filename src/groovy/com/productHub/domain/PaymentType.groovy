package com.productHub.domain

public enum PaymentType {

	MONEY_TRANSFER('Money Transfer'),
	DIRECT_PAYMENT('Direct Payment'),
	PAYPAL('PayPal')

	String description

	PaymentType(String description) {
		this.description = description
	}
   
	def toMap() {
		def map = [:]
		map.name = name()
		map.description = description
		return map
	}
	
	static list(){
		return PaymentType.values()
	}
	
	String toString() { description }
	String getKey() { name() }
}