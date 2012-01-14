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
	}
}
