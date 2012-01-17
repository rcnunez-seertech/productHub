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
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${storeInstance}">
            <div class="alert-message block-message error">
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
                                    <g:textField name="storeName" maxlength="20" value="${storeInstance?.storeName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="storeCode"><g:message code="store.storeCode.label" default="Store Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'storeCode', 'errors')}">
                                    <g:textField name="storeCode" maxlength="8" value="${storeInstance?.storeCode}" />
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
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                   <g:submitButton name="create" class="btn" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
            </g:form>
        
    </body>
</html>
