
<%@ page import="com.productHub.domain.Cart" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cart.label', default: 'Cart')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
			<sec:ifAnyGranted roles="ROLE_ADMINISTRATOR">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cart.user.label" default="User" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${userInstance?.id}">${userInstance?.username.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cart.products.label" default="Products" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
            </sec:ifAnyGranted>  
                                <g:each in="${userInstance?.carts}" var="s" status="i">
									<g:if test="${!s.isCheckedOut}">
										<table>
											<tr><th colspan="3">${s.store.storeName}</th></tr>
											<tr><td>Product name</td><td>Quantity</td><td>Other Notes</td></tr>
											<g:each in="${ (s?.orders) }" var="p">
												<tr>
												<td>
													<g:link controller="productOrder" action="show" id="${p.id}">${p?.product.productName.encodeAsHTML()}</g:link>
												</td>
												<td>${p?.quantity.encodeAsHTML()}</td>
												<td>${p?.clientNotes?.encodeAsHTML()}</td>
												</tr>
											</g:each>
												<tr>
													<td></td>
													<td><g:link class="btn" controller="orderForm" action="checkout" id="${s?.id}">Checkout</g:link></td>
													<td><g:form>
															<g:actionSubmit class="btn" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" />
															<g:hiddenField name="id" value="${s.id}" />
														</g:form></td>
												</tr>
											
										</table>
										<hr/>
									</g:if>
											
										
									
                                </g:each>
            <sec:ifAnyGranted roles="ROLE_ADMINISTRATOR">                    
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
			</sec:ifAnyGranted>
            <div class="buttons">
                <g:form>
					<g:if test="${userInstance?.carts}">
						<g:actionSubmit class="btn" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
					</g:if>
                    <!--<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />-->
                </g:form>
            </div>
    </body>
</html>
