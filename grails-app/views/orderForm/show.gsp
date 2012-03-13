
<%@ page import="com.productHub.domain.OrderForm" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orderForm.label', default: 'OrderForm')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                
			
					<table>
						<tbody>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="orderForm.id.label" default="Id" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: s, field: "id")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="orderForm.cart.label" default="Cart" /></td>
								
								<td valign="top" class="value"><g:link controller="cart" action="show" id="${orderFormInstance?.cart?.id}">${orderFormInstance?.cart?.encodeAsHTML()}</g:link></td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="orderForm.payment.label" default="Payment" /></td>
								
								<td valign="top" class="value">${orderFormInstance?.payment?.encodeAsHTML()}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="orderForm.paymentNotes.label" default="Payment Notes" /></td>
								
								<td valign="top" class="value">${fieldValue(bean: orderFormInstance, field: "paymentNotes")}</td>
								
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="orderForm.paymentProof.label" default="Payment Proof" /></td>
								<td><img src="${createLink(controller:'orderForm', action:'image', id: params.id)}" width="250"/></td>
							</tr>
						
							<tr class="prop">
								<td valign="top" class="name"><g:message code="orderForm.status.label" default="Status" /></td>
								
								<td valign="top" class="value">${orderFormInstance?.status?.encodeAsHTML()}</td>
								
							</tr>
						
						</tbody>
					</table>
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
