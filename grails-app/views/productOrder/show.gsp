
<%@ page import="com.productHub.domain.ProductOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'productOrder.label', default: 'ProductOrder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="productOrder.product.label" default="Product" /></td>
                            
                            <td valign="top" class="value"><g:link controller="product" action="show" id="${productOrderInstance?.product?.id}">${productOrderInstance?.product?.productName?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="productOrder.quantity.label" default="Quantity" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productOrderInstance, field: "quantity")}</td>
                            
                        </tr>
						<tr>
						<td colspan="2"><g:link class="btn" controller="orderForm" action="myOrders">Back to my orders</g:link></td>
						<td colspan="2"><g:link class="btn" controller="cart" action="show">Back to my cart</g:link></td>
						</tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
