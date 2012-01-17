<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
		<script type="text/javascript" src="${resource(dir:'js',file:'bootstrap-dropdown.js')}"></script>
		<g:javascript src="bootstrap-dropdown.js" />
    </head>
    <body>
		<g:javascript>
			$('#topbar').dropdown();
		</g:javascript>
	
		<div class="topbar">
			<div class="fill">
				<div class="container">
					<a class="brand" href="/productHub">Product Hub</a>
					<ul class="nav">
						<li class="active"><a href="/productHub/store/list">Stores</a></li>
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
					<h1>HEADER </h1>
				</div>
			</div>
			
			<div class="row">
				<div class="container-fluid">
					<div class="sidebar">
						<h2>Navigation</h2>
						<hr />
						<sec:ifAnyGranted roles="ROLE_CLIENT">
							<a href="/productHub/cart/index">View Carts</a>
						</sec:ifAnyGranted>
					
					<sec:ifNotLoggedIn>
						<a href="/productHub/user/create">Register</a>
					</sec:ifNotLoggedIn>
					</div>
					
					<div class="content">
						<g:layoutBody />
					</div>
				</div>
				
			</div>
		</div>
	
        
    </body>
</html>