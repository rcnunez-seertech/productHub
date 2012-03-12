
<%@ page import="com.productHub.domain.OrderForm" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orderForm.label', default: 'OrderForm')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
            <h1>MY ORDERS</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                
				<g:each in="${orderForms}" var="s" status="i">
					<table class="orders">
						<tbody>
							
								<tr class="prop">
									
									<th valign="top" class="value"><g:link controller="user" action="show" id="${s?.customer?.id}">${s?.customer?.username.encodeAsHTML()}</g:link></th>
									<td></td>
								</tr>
								
							
								<tr class="details">
									<th>Product</th>
									<th>Quantity</th>
									<th colspan="2">Notes</th>
								</tr>
								<g:each in="${s?.cart?.orders}" var="p" status="q">
									<tr class="details">
									<td>
										<g:link controller="productOrder" action="show" id="${p.id}">${p?.product.productName.encodeAsHTML()}</g:link>
									</td>
									<td>${p?.quantity.encodeAsHTML()}</td>
									<td colspan="2">${p?.clientNotes?.encodeAsHTML()}</td>
									</tr>
								</g:each>
								
								<tr class="prop">
									<th>Status:</th>
									<td valign="top" class="value">${s?.status?.encodeAsHTML()}</td>
									<th valign="top" class="name"><g:message code="orderForm.payment.label" default="Payment:" /></th>
									
									<td valign="top" class="value">${s?.payment?.encodeAsHTML()} - ${s.paymentNotes}</td>
									
								</tr>
						</tbody>
					</table>
				</g:each>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${orderFormInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
