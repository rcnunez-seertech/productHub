
<%@ page import="com.productHub.domain.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
			<div class="row">	
				<div class="alignright">
				<g:link class="btn" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
				<sec:ifAnyGranted roles="ROLE_VENDOR">
					<g:link class="btn" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
				</sec:ifAnyGranted>
				</div>
			</div>
				<g:form action="addToCart" >
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.productName.label" default="Product Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "productName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.productCode.label" default="Product Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "productCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.quantity.label" default="Quantity" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "quantity")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.price.label" default="Price" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "price")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "description")}</td>
                            
                        </tr>
						
						<tr class="prop">
                            <td valign="top" class="name"><g:message code="store.description.label" default="Store" /></td>
                            
                            <td valign="top" class="value">
							<g:link controller="store" action="show" id="${productInstance.store.id}">${productInstance.store.storeName.encodeAsHTML()}</g:link></td>
                            
                        </tr>
						
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.image.label" default="Image" /></td>
                            <td valign="top" class="value"><img src="${createLink(controller:'product', action:'image', id: params.id)}" width="400"/></td>
                        </tr>
                    
                    </tbody>
                </table>
				<sec:ifAnyGranted roles="ROLE_CLIENT">
				
				<!--
					<table>
						<tr class="prop">
							<td>Quantity</td>
							<td><g:textField name="quantity" value="${fieldValue(bean: orderInstance, field: 'quantity')}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="customerNotes"><g:message code="order.customerNotes.label" default="Order Notes" /></label>
								<br/><sub>Size, Colours, etc.</sub>
							</td>
							<td valign="top" class="value ${hasErrors(bean: orderInstance, field: 'customerNotes', 'errors')}">
								<g:textField name="customerNotes" value="${orderInstance?.customerNotes}" />
							</td>
						</tr>
					</table>
				-->
					<g:if test="${!(userInstance.cart.products).contains(productInstance)}">
						<g:actionSubmit class="btn" action="addToCart" value="${message(code: 'default.button.addToCart.label', default: 'Add To Cart')}" />
					</g:if>
					<g:else>
						<g:actionSubmit class="btn" action="removeFromCart" value="${message(code: 'default.button.removeFromCart.label', default: 'Remove From Cart')}" />
					</g:else>
				</sec:ifAnyGranted>
				</g:form>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${productInstance?.id}" />
					<sec:ifAnyGranted roles="ROLE_VENDOR, ROLE_ADMINISTRATOR">	
						<g:if test="${userInstance.store.id == productInstance.store.id}">
							<g:actionSubmit class="btn" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
						</g:if>
					</sec:ifAnyGranted>
					
					
                    <!--<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>-->
                </g:form>
            </div>
    </body>
</html>
