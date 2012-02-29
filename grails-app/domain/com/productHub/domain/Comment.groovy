package com.productHub.domain

class Comment {

	User author
	Product product
	Store store
	String remarks
	float rating

    static constraints = {
		product(nullable:true)
		author(nullable:false)
		store(nullable:true)
		remarks(nullable:false)
		rating(nullable:false, validator:
			{ val, obj ->
				if (val == 0) return ['cannotBeZero']
				else return true
			})
    }
}
