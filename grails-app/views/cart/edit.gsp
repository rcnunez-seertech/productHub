

<%@ page import="com.productHub.domain.Cart" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cart.label', default: 'Cart')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
           <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${storeInstance}">
            <div class="alert-message block-message error">
                <g:renderErrors bean="${storeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${cartInstance?.id}" />
                <g:hiddenField name="version" value="${cartInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="cart.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cartInstance, field: 'user', 'errors')}">
                                    <!--<g:select name="user.id" from="${com.productHub.domain.User.list()}" optionKey="id" value="${cartInstance?.user?.id}"  />-->
									<g:hiddenField name="user.id" value="${cartInstance?.user?.id}" />
									${cartInstance?.user?.username}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="products"><g:message code="cart.products.label" default="Products" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cartInstance, field: 'products', 'errors')}">
                                    <g:select name="products" from="${com.productHub.domain.Product.list()}" multiple="yes" optionKey="id" size="5" value="${cartInstance?.products*.id}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <g:actionSubmit class="btn" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    <!--<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>-->
                </div>
            </g:form>
        </div>
    </body>
</html>
