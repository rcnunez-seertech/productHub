import com.productHub.domain.*
import com.productHub.domain.RoleType

class BootStrap {

    def springSecurityService

    def init = { servletContext ->

        environments {
			production {
				setupData()
			}
			development {
				setupData()
			}
			test {
				setupData()
				//setupTestData()
			}
		}

    }
	
    def destroy = {
    }
	
	private setupData() {
		if(Role.count() == 0){
            RoleType.values().each{ eachType ->
                Role role = Role.findByAuthority(eachType.name()) ?: new Role(authority: eachType.name()).save(flush: true,failOnError:true)
				//println eachType.name() + " saved!"
            }
            //	println ("Roletype success")
        }
		
		if(User.count() == 0){
			User user = new User(firstName: "Ruth", lastName: "Nunez", username: "administrator", password: "password", contactNumber:"1293", confirmPassword: "password", emailAddress: "ruthieis@live.com", shippingAddress:"Yes", userRole: RoleType.ROLE_ADMINISTRATOR).save(flush:true, failOnError:true)
			Role role = Role.findByAuthority(user.userRole?.getKey())
			UserRole.create user, role, true
			user = new User(firstName: "Nina", lastName: "Castillo", username: "client", password: "password", contactNumber:"1293", confirmPassword: "password", emailAddress: "ninabeleen@live.com", shippingAddress:"Yes", userRole: RoleType.ROLE_CLIENT, wishlist: new Wishlist(user: user).save(flush:true, failOnError:true)).save(flush:true, failOnError:true)
			role = Role.findByAuthority(user.userRole?.getKey())
			UserRole.create user, role, true
			user = new User(firstName: "JS", lastName: "Virtusio", username: "vendor", password: "password", contactNumber:"1293", confirmPassword: "password", emailAddress: "icanhas@live.com", shippingAddress:"Wat", userRole: RoleType.ROLE_VENDOR).save(flush:true, failOnError:true)
			role = Role.findByAuthority(user.userRole?.getKey())
			UserRole.create user, role, true
		}
		def clientname
		def clientemail
		def vendorname
		def vendoremail
		def newUser1
		def newUser2
		def userRole
		def product1
		def product2
		def product3
		def store
		(1..500).each(){it ->
			clientname = "client" + it
			clientemail = clientname + "@gmail.com"
			vendorname = "vendor" + it
			vendoremail = vendorname + "@gmail.com"
		    newUser1 = new User(firstName: "Nina", lastName: "Castillo", username: clientname, password: "password", contactNumber:"1293", confirmPassword: "password", emailAddress: clientemail, shippingAddress:"Yes", userRole: RoleType.ROLE_CLIENT, wishlist: new Wishlist(user: newUser1).save(flush:true, failOnError:true)).save(flush:true, failOnError:true)
			userRole = Role.findByAuthority(newUser1.userRole?.getKey())
			UserRole.create newUser1, userRole, true
			newUser2 = new User(firstName: "JS", lastName: "Virtusio", username: vendorname, password: "password", contactNumber:"1293", confirmPassword: "password", emailAddress: vendoremail, shippingAddress:"Wat", userRole: RoleType.ROLE_VENDOR).save(flush:true, failOnError:true)
			userRole = Role.findByAuthority(newUser2.userRole?.getKey())
			UserRole.create newUser2, userRole, true
			
			store = new Store(storeName: vendorname + "'s Store", storeCode: vendorname+"store", description: "awesome", meetUpLocations: "Gateway, UPLB", 
			user: newUser2, accountDetails: "BDO, JS Virtusio", acceptsDirect:true, acceptsMoneyTransfer:true).save(flush:true, failOnError:true)
			
			newUser2.store = store
			newUser2.confirmPassword = newUser2.password
			newUser2.save(flush:true, failOnError:true)
			
			/*
			product1 = new Product(productName: vendorname + " product 1", productCode: vendorname + "prod1", quantity: 30, price: 10.50*it, description: "awesome", 
			store: store).save(flush:true, failOnError:true)
			store.addToProducts(product1)
			store.save(flush:true, failOnError:true)
			product2 = new Product(productName: vendorname + " product 2", productCode: vendorname + "prod2", quantity: 30, price: 20.23*it, description: "awesome", 
			store: store).save(flush:true, failOnError:true)
			store.addToProducts(product2)
			store.save(flush:true, failOnError:true)
			product3 = new Product(productName: vendorname + " product 3", productCode: vendorname + "prod3", quantity: 30, price: 21.23*it, description: "awesome", 
			store: store).save(flush:true, failOnError:true)
			store.addToProducts(product3)
			store.save(flush:true, failOnError:true)
			*/
			(1..20).each(){it2 ->
				product1 = new Product(productName: vendorname + " product " + it2, productCode: vendorname + "prod" + it2, quantity: 30, price: 10.50*it2, description: "awesome", 
				store: store).save(flush:true, failOnError:true)
				store.addToProducts(product1)
				store.save(flush:true, failOnError:true)
			}
			
			
		}
		
		println "Users " + User.count() + " Stores " + Store.count() + "Products " + Product.count()
	}
}
