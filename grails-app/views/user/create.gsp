
<%@ page import="com.productHub.domain.RoleType" %>
<%@ page import="com.productHub.domain.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title>Create User</title>
    </head>
    <body>
            <h1>Register to ProductHub</h1>
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="alert-message block-message error">
				<h2>Errors found!</h2>
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
						
						<fieldset class="bordered">
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
                                    <!--<g:select name="userRole" from="${com.productHub.domain.RoleType?.values()}" value="${userInstance?.userRole?.name()}"  optionKey="key"/>-->
									<select name="userRole" id="userRole" class="value ${hasErrors(bean: userInstance, field: 'userRole', 'errors')}">
										<sec:ifAnyGranted roles="ROLE_ADMINISTRATOR">
											<option value="${RoleType.ROLE_ADMINISTRATOR.name()}">Administrator</option>
										</sec:ifAnyGranted>
										<option value="${RoleType.ROLE_CLIENT.name()}">Client</option>
										<option value="${RoleType.ROLE_VENDOR.name()}">Vendor</option>
									</select>
									<g:hiddenField name="givenUserRole" id="givenUserRole" value="${userInstance?.userRole}" />
                                </td>
                            </tr>
							
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="user.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
                                    <g:passwordField name="password" value="${userInstance?.password}" />
                                </td>
                            </tr>
							
							<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="confirmPassword"><g:message code="user.confirmPassword.label" default="Confirm Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'confirmPassword', 'errors')}">
                                    <g:passwordField name="confirmPassword" value="${userInstance?.confirmPassword}" />
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
                        </fieldset>
                            
                        <tr><td colspan="2"><hr/></td></tr>
                        <fieldset class="bordered">
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
                        </fieldset>    
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <g:submitButton name="create" class="btn" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
            </g:form>
        
    </body>
</html>
