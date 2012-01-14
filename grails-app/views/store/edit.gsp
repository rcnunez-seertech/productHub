

<%@ page import="com.productHub.domain.Store" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${storeInstance}">
            <div class="errors">
                <g:renderErrors bean="${storeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${storeInstance?.id}" />
                <g:hiddenField name="version" value="${storeInstance?.version}" />
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
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="products"><g:message code="store.products.label" default="Products" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'products', 'errors')}">
                                    <g:select name="products" from="${com.productHub.domain.Product.list()}" multiple="yes" optionKey="id" size="5" value="${storeInstance?.products*.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="rating"><g:message code="store.rating.label" default="Rating" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'rating', 'errors')}">
                                    <g:textField name="rating" value="${fieldValue(bean: storeInstance, field: 'rating')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
