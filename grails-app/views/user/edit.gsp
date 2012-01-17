

<%@ page import="com.productHub.domain.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${userInstance?.id}" />
                <g:hiddenField name="version" value="${userInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
							<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="username"><g:message code="user.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" maxlength="15" value="${userInstance?.username}" />
                                </td>
                            </tr>
							
							<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="userRole"><g:message code="user.userRole.label" default="User Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'userRole', 'errors')}">
                                    <g:select name="userRole" from="${com.productHub.domain.RoleType?.values()}" keys="${com.productHub.domain.RoleType?.values()*.name()}" value="${userInstance?.userRole?.name()}"  />
                                </td>
                            </tr>
							
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="emailAddress"><g:message code="user.emailAddress.label" default="Email Address" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'emailAddress', 'errors')}">
                                    <g:textField name="emailAddress" value="${userInstance?.emailAddress}" />
                                </td>
                            </tr>
							
							<tr><td colspan="2"><hr/></td></tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="firstName"><g:message code="user.firstName.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${userInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lastName"><g:message code="user.lastName.label" default="Last Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${userInstance?.lastName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="contactNumber"><g:message code="user.contactNumber.label" default="Contact Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'contactNumber', 'errors')}">
                                    <g:textField name="contactNumber" value="${userInstance?.contactNumber}" />
                                </td>
                            </tr>
                        
                            
                        
                          
                        
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <g:actionSubmit class="btn" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    <!--<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />-->
                </div>
            </g:form>
        
    </body>
</html>
