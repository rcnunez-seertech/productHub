
<%@ page import="com.productHub.domain.ProductOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'productOrder.label', default: 'ProductOrder')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'productOrder.id.label', default: 'Id')}" />
                        
                            <th><g:message code="productOrder.product.label" default="Product" /></th>
                        
                            <g:sortableColumn property="clientNotes" title="${message(code: 'productOrder.clientNotes.label', default: 'Client Notes')}" />
                        
                            <g:sortableColumn property="vendorNotes" title="${message(code: 'productOrder.vendorNotes.label', default: 'Vendor Notes')}" />
                        
                            <g:sortableColumn property="quantity" title="${message(code: 'productOrder.quantity.label', default: 'Quantity')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${productOrderInstanceList}" status="i" var="productOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${productOrderInstance.id}">${fieldValue(bean: productOrderInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: productOrderInstance, field: "product")}</td>
                        
                            <td>${fieldValue(bean: productOrderInstance, field: "clientNotes")}</td>
                        
                            <td>${fieldValue(bean: productOrderInstance, field: "vendorNotes")}</td>
                        
                            <td>${fieldValue(bean: productOrderInstance, field: "quantity")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${productOrderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
