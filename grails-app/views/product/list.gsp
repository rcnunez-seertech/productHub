
<%@ page import="com.productHub.domain.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
		
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
			<div class="row">
				<div class="alignright">
				
				<sec:ifAnyGranted roles="ROLE_VENDOR">
					<g:if test="${userInstance?.store}">
						<g:link class="btn" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
					</g:if>
				</sec:ifAnyGranted>
				</div>
			</div>
                <table class="zebra-striped">
                    <thead>
                        <tr>
				<th>Product Name</th>
                            
				<th>Quantity</th>
                        
				<th>Price</th>
			    
				<th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${productInstanceList}" status="i" var="productInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                        
                            <td><g:link action="show" id="${productInstance.id}">${fieldValue(bean: productInstance, field: "productName")}</g:link></td>
                        
                            <td>${fieldValue(bean: productInstance, field: "quantity")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "price")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
        </div>
</html>
