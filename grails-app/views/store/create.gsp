

<%@ page import="com.productHub.domain.Store" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
       
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${storeInstance}">
            <div class="errors">
                <g:renderErrors bean="${storeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="storeName"><g:message code="store.storeName.label" default="Store Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'storeName', 'errors')}">
                                    <g:textField name="storeName" maxlength="30" value="${storeInstance?.storeName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="storeCode"><g:message code="store.storeCode.label" default="Store Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'storeCode', 'errors')}">
                                    <g:textField name="storeCode" maxlength="15" value="${storeInstance?.storeCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="store.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${storeInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label>Payment Methods</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'acceptsDirect', 'errors')}">
								
									<table>
										<tr>
											<td>
												<g:checkBox name="acceptsDirect" value="${storeInstance?.acceptsDirect}" />
											</td>
											<td>Direct Payment</td>
										</tr>
										<tr><td><g:checkBox name="acceptsMoneyTransfer" value="${storeInstance?.acceptsMoneyTransfer}" />
										
										</td><td>Money Transfer</td>
										
										</tr>
									</table>
								</td>
                            </tr>
							
							<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountDetails">Account Details <br/>(if any)</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'accountDetails', 'errors')}">
                                    <g:textField name="accountDetails" value="${storeInstance?.accountDetails}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="meetUpLocations">Meet Up Locations </br>(if any)</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'meetUpLocations', 'errors')}">
                                    <g:textField name="meetUpLocations" value="${storeInstance?.meetUpLocations}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                <div class="buttons">
                    <g:submitButton name="create" class="btn" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
            </g:form>
        </div>
    </body>
</html>
