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
				println eachType.name() + " saved!"
            }
            println ("Roletype success")
        }
		
		if(User.count() == 0){
			User user = new User(firstName: "Ruth", lastName: "Nunez", username: "administrator", password: "password", contactNumber:"1293", confirmPassword: "password", emailAddress: "ruthieis@live.com", userRole: RoleType.ROLE_ADMINISTRATOR).save(flush:true, failOnError:true)
			Role role = Role.findByAuthority(user.userRole?.getKey())
			UserRole.create user, role, true
		}
		
		if(User.count() == 1) {
			println "ADMIN SAVED!"
		} else {
			println "Error saving admin"
		}
	}
}
