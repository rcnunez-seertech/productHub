package com.productHub.domain

public enum RoleType {
	ROLE_ADMINISTRATOR('Administrator'),
	ROLE_VENDOR('Vendor'),
	ROLE_CLIENT('Client')

	String description

	RoleType(String description) {
		this.description = description
	}
   
	def toMap() {
		def map = [:]
		map.name = name()
		map.description = description
		return map
	}
	
	static list(){
		return RoleType.values()
	}
	
	String toString() { description }
	String getKey() { name() }
}