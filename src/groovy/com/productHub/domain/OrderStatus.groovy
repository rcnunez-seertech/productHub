package com.productHub.domain

public enum OrderStatus {

	WAITING_APPROVAL('Waiting Approval'),
	APPROVED('Approved'),
	DELIVERED('Delivered'),
	ACCEPTED('Accepted')

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