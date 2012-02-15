

<%@ page import="com.productHub.domain.OrderForm" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orderForm.label', default: 'OrderForm')}" />
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
            <g:hasErrors bean="${orderFormInstance}">
            <div class="errors">
                <g:renderErrors bean="${orderFormInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${orderFormInstance?.id}" />
                <g:hiddenField name="version" value="${orderFormInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="customer"><g:message code="orderForm.customer.label" default="Customer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orderFormInstance, field: 'customer', 'errors')}">
                                    <g:select name="customer.id" from="${com.productHub.domain.User.list()}" optionKey="id" value="${orderFormInstance?.customer?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="products"><g:message code="orderForm.products.label" default="Products" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orderFormInstance, field: 'products', 'errors')}">
                                    <g:select name="products" from="${com.productHub.domain.Product.list()}" multiple="yes" optionKey="id" size="5" value="${orderFormInstance?.products*.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="orderForm.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orderFormInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${com.productHub.domain.OrderStatus?.values()}" keys="${com.productHub.domain.OrderStatus?.values()*.name()}" value="${orderFormInstance?.status?.name()}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="store"><g:message code="orderForm.store.label" default="Store" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orderFormInstance, field: 'store', 'errors')}">
                                    <g:select name="store.id" from="${com.productHub.domain.Store.list()}" optionKey="id" value="${orderFormInstance?.store?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="totalPrice"><g:message code="orderForm.totalPrice.label" default="Total Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orderFormInstance, field: 'totalPrice', 'errors')}">
                                    <g:textField name="totalPrice" value="${fieldValue(bean: orderFormInstance, field: 'totalPrice')}" />
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
