
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
				&nbsp;&nbsp;<g:link class="btn" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
				</div>
			</div>
                <table class="zebra-striped">
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'product.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="productName" title="${message(code: 'product.productName.label', default: 'Product Name')}" />
                        
                            <g:sortableColumn property="productCode" title="${message(code: 'product.productCode.label', default: 'Product Code')}" />
                        
                            <g:sortableColumn property="quantity" title="${message(code: 'product.quantity.label', default: 'Quantity')}" />
                        
                            <g:sortableColumn property="price" title="${message(code: 'product.price.label', default: 'Price')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'product.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${productInstanceList}" status="i" var="productInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${productInstance.id}">${fieldValue(bean: productInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: productInstance, field: "productName")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "productCode")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "quantity")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "price")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            <div class="paginateButtons">
                <g:paginate total="${productInstanceTotal}" />
            </div>
        </div>
</html>
