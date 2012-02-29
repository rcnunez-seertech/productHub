
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
            <div class="message">${flash.message}</div>
            </g:if>
			<sec:ifAnyGranted roles="ROLE_ADMINISTRATOR">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cart.user.label" default="User" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${cartInstance?.user?.id}">${cartInstance?.user?.username.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cart.products.label" default="Products" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
            </sec:ifAnyGranted>  
                                <g:each in="${userInstance?.carts}" var="s" status="i">
										<table class="zebra-striped">
											<tr><th>${s.store.storeName}</th></tr>
											<tr><td><g:each in="${ (s?.orders) }" var="p">
												<li><g:link controller="product" action="show" id="${p.id}">${p?.productName.encodeAsHTML()}</g:link></li>
											</g:each></td></tr>
										</table>
									</ul>
                                </g:each>
            <sec:ifAnyGranted roles="ROLE_ADMINISTRATOR">                    
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
			</sec:ifAnyGranted>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${cartInstance?.id}" />
					<g:if test="${userInstance?.carts}">
						<g:actionSubmit class="btn" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
					</g:if>
                    <!--<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />-->
                </g:form>
            </div>
    </body>
</html>
