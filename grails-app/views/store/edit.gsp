

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
                                  <label for="user"><g:message code="store.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${com.productHub.domain.User.list()}" optionKey="id" value="${storeInstance?.user?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="accountDetails"><g:message code="store.accountDetails.label" default="Account Details" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'accountDetails', 'errors')}">
                                    <g:textField name="accountDetails" value="${storeInstance?.accountDetails}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="acceptsDirect"><g:message code="store.acceptsDirect.label" default="Accepts Direct" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'acceptsDirect', 'errors')}">
                                    <g:checkBox name="acceptsDirect" value="${storeInstance?.acceptsDirect}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="acceptsMoneyTransfer"><g:message code="store.acceptsMoneyTransfer.label" default="Accepts Money Transfer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'acceptsMoneyTransfer', 'errors')}">
                                    <g:checkBox name="acceptsMoneyTransfer" value="${storeInstance?.acceptsMoneyTransfer}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="acceptsPayPal"><g:message code="store.acceptsPayPal.label" default="Accepts Pay Pal" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'acceptsPayPal', 'errors')}">
                                    <g:checkBox name="acceptsPayPal" value="${storeInstance?.acceptsPayPal}" />
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
                                  <label for="meetUpLocations"><g:message code="store.meetUpLocations.label" default="Meet Up Locations" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'meetUpLocations', 'errors')}">
                                    <g:textField name="meetUpLocations" value="${storeInstance?.meetUpLocations}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="orderforms"><g:message code="store.orderforms.label" default="Orderforms" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'orderforms', 'errors')}">
                                    
<ul>
<g:each in="${storeInstance?.orderforms?}" var="o">
    <li><g:link controller="orderForm" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="orderForm" action="create" params="['store.id': storeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'orderForm.label', default: 'OrderForm')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="products"><g:message code="store.products.label" default="Products" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: storeInstance, field: 'products', 'errors')}">
                                    
<ul>
<g:each in="${storeInstance?.products?}" var="p">
    <li><g:link controller="product" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="product" action="create" params="['store.id': storeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'product.label', default: 'Product')])}</g:link>

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
