package com.productHub.domain

public enum OrderStatus {

	SENT_TO_SHOP('Sent to Shop'),
	AWAITING_PAYMENT('Awaiting Payment'),
	APPROVED('Approved'),
	DELIVERED('Delivered'),
	RECEIVED('Received')

	String description

	OrderStatus(String description) {
		this.description = description
	}
   
	def toMap() {
		def map = [:]
		map.name = name()
		map.description = description
		return map
	}
	
	static list(){
		return OrderStatus.values()
	}
	
	String toString() { description }
	String getKey() { name() }
}