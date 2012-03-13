<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'demo_table.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
		<link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
        <g:layoutHead />
		<g:javascript src="jQuery.js" />
        <g:javascript library="application" />
		<g:javascript src="bootstrap-dropdown.js" />
		<g:javascript src="jquery.dataTables.min.js" />
    </head>
    <body>
		
		<div class="topbar">
			<div class="fill">
				<div class="container">
					<a class="brand" href="/productHub">Product Hub</a>
					<ul class="nav">
						<!--<li class="active"><a href="#">LINK</a></li>-->
						<li><a href="/productHub/store/list">Stores</a></li>
						<li><a href="/productHub/product/list">Products</a></li>
						<li><a href="/productHub/user/list">Users</a></li>
						
					</ul>
					
				
					
					
					
					<ul class="nav secondary-nav">
						<sec:ifLoggedIn>
								<li class="dropdown" data-dropdown="dropdown">
								  <a href="/productHub/logout/index" class="dropdown-toggle"><sec:loggedInUserInfo
							field="username" /></a>
								  <ul class="dropdown-menu">
									<li><a href="#">Secondary link</a></li>
									<li><a href="#">Something else here</a></li>
									<li class="divider"></li>
									<li><a href="/productHub/logout/index">Logout</a></li>
								  </ul>
								</li>
					  </sec:ifLoggedIn>
					  <sec:ifNotLoggedIn>
							<li><a href="/productHub/login/index">Login</a></li>
					  </sec:ifNotLoggedIn>
				  </ul>
				  
				  
				  
				  
				  
				</div>
			</div>
		</div>
		
		
		<div class="container">
			<div class="row">
				<div class="row"><br/></br><br/></div>
				<div class="hero-unit">
					<img src="${resource(dir:'images',file:'image.jpg')}" />
				</div>
			</div>
			
			<div class="row">
				<div class="container-fluid">
					<div class="sidebar">
						<div class="background">
						<div class="background2">
						<h2>Navigation</h2>
						<sec:ifAnyGranted roles="ROLE_CLIENT">
							<a href="/productHub/cart/index">My Cart</a>
							<br/><a href="/productHub/orderForm/myOrders">My Orders</a>
							<br/><a href="/productHub/wishlist/index">My Wishlist</a>
						</sec:ifAnyGranted>

						<sec:ifAnyGranted roles="ROLE_ADMINISTRATOR">
							<a href="/productHub/cart/list">View Carts</a>
						</sec:ifAnyGranted>
						
						<sec:ifAnyGranted roles="ROLE_VENDOR">
							<a href="/productHub/store/myStore/" class="link">My Store</a>
							<br/><a href="/productHub/orderForm/myOrders" class="link">My Orders</a>
						</sec:ifAnyGranted>
						
						<sec:ifNotLoggedIn>
							<a href="/productHub/user/create">Register</a>
						</sec:ifNotLoggedIn>
						</div>
						</div>
					</div>
					
					<div class="content">
						<g:layoutBody />
					</div>
				</div>
				
			</div>
		</div>
	
        <g:javascript>
			$('.dropdown-toggle').dropdown();
			$('.zebra-striped').dataTable();
		</g:javascript>
    </body>
</html>