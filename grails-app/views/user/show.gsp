
<%@ page import="com.productHub.domain.User" %>
<%@ page import="com.productHub.domain.RoleType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title>${fieldValue(bean: userInstance, field: "username")}'s Profile</title>
    </head>
    <body>
            <h1>${fieldValue(bean: userInstance, field: "username")}</h1>
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
			
            <div class="row">	
				<div class="alignright">
				<g:link class="btn" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
				
				</div>
			</div>
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.firstName.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "firstName")} ${fieldValue(bean: userInstance, field: "lastName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.emailAddress.label" default="Email Address" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "emailAddress")}</td>
                            
                        </tr>
                    
						
						<tr class="prop">
                            <td valign="top" class="name">User Role</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "userRole")}</td>
                            
						<g:if test="${userInstance?.userRole == RoleType.ROLE_VENDOR}">
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.store" default="Store" /></td>
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "store")}</td>
							</tr>
						</g:if>
						
						<g:if test="${userInstance?.userRole == RoleType.ROLE_CLIENT}">
							<tr class="prop">
								<td valign="top" class="name"><g:message code="user.shippingAddress" default="Shipping Address" /></td>
								<td valign="top" class="value">${fieldValue(bean: userInstance, field: "shippingAddress")}</td>
							</tr>
						</g:if>
						
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.contactNumber.label" default="Contact Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "contactNumber")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
           
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${userInstance?.id}" />
                    <g:actionSubmit class="btn" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
                    <sec:ifAnyGranted roles="ROLE_ADMINISTRATOR">
						<g:if test="${userInstance.enabled}">
							<g:actionSubmit class="btn" action="deactivate" value="${message(code: 'default.button.deactivate.label', default: 'Deactivate')}" />
						</g:if>
						<g:else>
							<g:actionSubmit class="btn" action="activate" value="${message(code: 'default.button.deactivate.label', default: 'Activate')}" />
						</g:else>
					</sec:ifAnyGranted>
                    <!--<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>-->
                </g:form>
            </div>
    </body>
</html>
