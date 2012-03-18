package com.productHub.domain

class Comment {

	User author
	Product product
	Store store
	String remarks
	int rating

    static constraints = {
		product(nullable:true)
		author(nullable:false)
		store(nullable:true)
		remarks(nullable:false)
		rating(nullable:false, range:1..5)
    }
}
