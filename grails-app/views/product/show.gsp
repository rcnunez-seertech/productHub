
<%@ page import="com.productHub.domain.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
            <h1><g:link controller="store" action="show" id="${productInstance.store.id}">${productInstance.store.storeName.encodeAsHTML()}</g:link> - ${fieldValue(bean: productInstance, field: "productName")}</h1>
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
				
                <table>
                    <tbody>
                    
                        <tr class="prop">
			    <td rowspan ="7" valign="top" class="value">
				<g:if test="${productInstance?.image}">
					<img src="${createLink(controller:'product', action:'image', id: params.id)}" width="250"/>
				</g:if>
				<g:else>
					<img src="${resource(dir:'images',file:'noimage.jpg')}" width="250"/>
				</g:else>
				</td>
                            <th valign="top" class="name"><g:message code="product.productName.label" default="Product Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "productName")}</td>
                            
                        </tr>
			
			<tr class="prop">
                            <th valign="top" class="name"><g:message code="product.description.label" default="Description" /></th>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <th valign="top" class="name"><g:message code="product.productCode.label" default="Product Code" /></th>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "productCode")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <th valign="top" class="name"><g:message code="product.quantity.label" default="Quantity" /></th>
                            <td valign="top" class="value">
							<g:if test="${productInstance.quantity > 0}">
								${fieldValue(bean: productInstance, field: "quantity")}
							</g:if>
							<g:else>
								Out of Stock
							</g:else>
							</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <th valign="top" class="name"><g:message code="product.price.label" default="Price" /></th>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "price")}</td>
                            
                        </tr>
                    	
                        
                            
                      
                    
                    </tbody>
                </table>
				<sec:ifAnyGranted roles="ROLE_CLIENT">
				<g:form>
					<table>
						<tr class="prop">
							<td>Quantity</td>
							<td><g:textField name="quantity" value="${fieldValue(bean: orderInstance, field: 'quantity')}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								Order Notes
								<br/><sub>Size, Colours, etc.</sub>
							</td>
							<td valign="top" class="value ${hasErrors(bean: orderInstance, field: 'customerNotes', 'errors')}">
								<g:textField name="clientNotes" value="${orderInstance?.clientNotes}" />
								<g:hiddenField name="id" value="${productInstance?.id}" />
							</td>
						</tr>
					</table>
					
						<g:actionSubmit class="btn" action="addToCart" value="${message(code: 'default.button.addToCart.label', default: 'Add To Cart')}" />
						<g:if test="${productInstance?.quantity <= 0 && !userInstance?.wishlist?.products?.contains(productInstance)}">
							<g:actionSubmit class="btn" action="addToWishlist" value="${message(code: 'default.button.addToWishlist.label', default: 'Add To Wishlist')}" />
						</g:if>
						<g:if test="${userInstance?.wishlist?.products?.contains(productInstance)}">
							<g:actionSubmit class="btn" action="removeFromWishlist" value="${message(code: 'default.button.removeFromWishlist.label', default: 'Remove From Wishlist')}" />
						</g:if>
				</g:form>
				</sec:ifAnyGranted>
				
				<g:set var="total" value="${0l}" />
				<g:set var="count" value="${0l}" />
				<g:if test="${productInstance?.comments}">
				<g:each in="${productInstance?.comments}" var="p">
					<g:set var="total" value="${total+(p.rating)}"/>
					<g:set var="count" value="${count+1}"/>
				</g:each>
				
				<g:set var="total" value="${total / count}" />
				</g:if>
				<h2>Rating : <g:if test="${productInstance?.comments}">${total}</g:if> <g:else>5</g:else></h2>
				
				
				<sec:ifAnyGranted roles="ROLE_CLIENT">
				<g:form>
					<g:hiddenField name="id" value="${productInstance?.id}" />
						<g:textField name="rating" maxlength="1" size="1" />
                    <g:textField name="remarks"/>
                    <g:actionSubmit class="btn" action="addComment" value="${message(code: 'default.button.addComment.label', default: 'Add Comment')}" />
                </g:form>
				</sec:ifAnyGranted>
				
					<g:each in="${productInstance?.comments}" var="p">
					<g:set var="total" value="${total+(p.rating)}"/>
					<g:set var="count" value="${count+1}"/>
					<table class="orders">
						<tr class="prop">
						<td colspan="2"><g:link controller="user" action="show" id="${p.author.id}">${p.author.username}</g:link></td> 
						</tr>
						<tr class="prop">
						<td colspan="2"><b>Rating: ${p.rating}</b> <br/>${p.remarks}</td>
						</tr>
					</table>
					</g:each>
					
				
			
			
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
