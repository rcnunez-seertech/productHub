<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
    </head>
    <body>
	
		<div class="topbar">
			<div class="fill">
				<div class="container">
					<a class="brand" href="/productHub">Product Hub</a>
					<ul class="nav">
						<li class="active"><a href="#">Trololol</a></li>
						<li><a href="#">Trololol</a></li>
						<li><a href="#">Trololol</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		
			<div class="container">
				<div class="row">
					<div class="hero-unit">
						<h1>HEADER </h1>
					</div>
				</div>
				<div class="row">
					
					<g:layoutBody />
				</div>
			</div>
		
        
    </body>
</html>