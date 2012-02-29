

<%@ page import="com.productHub.domain.ProductOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'productOrder.label', default: 'ProductOrder')}" />
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
            <g:hasErrors bean="${productOrderInstance}">
            <div class="errors">
                <g:renderErrors bean="${productOrderInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${productOrderInstance?.id}" />
                <g:hiddenField name="version" value="${productOrderInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="product"><g:message code="productOrder.product.label" default="Product" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productOrderInstance, field: 'product', 'errors')}">
                                    <g:select name="product.id" from="${com.productHub.domain.Product.list()}" optionKey="id" value="${productOrderInstance?.product?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="clientNotes"><g:message code="productOrder.clientNotes.label" default="Client Notes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productOrderInstance, field: 'clientNotes', 'errors')}">
                                    <g:textField name="clientNotes" value="${productOrderInstance?.clientNotes}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vendorNotes"><g:message code="productOrder.vendorNotes.label" default="Vendor Notes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productOrderInstance, field: 'vendorNotes', 'errors')}">
                                    <g:textField name="vendorNotes" value="${productOrderInstance?.vendorNotes}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="quantity"><g:message code="productOrder.quantity.label" default="Quantity" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productOrderInstance, field: 'quantity', 'errors')}">
                                    <g:textField name="quantity" value="${fieldValue(bean: productOrderInstance, field: 'quantity')}" />
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
