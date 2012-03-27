
<%@ page import="com.productHub.domain.OrderForm" %>
<%@ page import="com.productHub.domain.OrderStatus" %>
<%@ page import="com.productHub.domain.PaymentType" %>
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
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
            <div class="dialog">
                
				<g:each in="${orderForms}" var="s" status="i">
					<g:if test="${s.status != OrderStatus.RECEIVED}">
					<table class="orders">
						<tbody>
							
								<tr class="prop">
									
									<th valign="top" class="value"><g:link controller="user" action="show" id="${s?.customer?.id}">${s?.customer?.username.encodeAsHTML()}</g:link></th>
									<td></td>
								<g:form>
									<g:hiddenField name="id" value="${s?.id}" />
									<td>
										
										<sec:ifAnyGranted roles="ROLE_VENDOR">
											<g:actionSubmit class="btn"  action="changeStatus" value="${message(code: 'default.button.upload.label', default: 'Change Status')}" />
										</sec:ifAnyGranted>
										<sec:ifAnyGranted roles="ROLE_CLIENT">
											<g:if test="${s.payment == PaymentType.MONEY_TRANSFER && (!s.paymentProof || s.status == OrderStatus.PAYMENT_REJECTED)}">
												<g:actionSubmit class="btn" action="uploadForm" value="${message(code: 'default.button.upload.label', default: 'Upload Proof of Payment')}" />
											</g:if>
											<g:if test="${s.status == OrderStatus.DELIVERED || (s.payment == PaymentType.DIRECT_PAYMENT && s.status == OrderStatus.APPROVED)}">
												<g:actionSubmit  class="btn"  action="changeStatus" value="${message(code: 'default.button.upload.label', default: 'Mark as Received')}" />
											</g:if>
										</sec:ifAnyGranted>
									</td>
								</g:form>
								</tr>
								
								<tr class="prop">
									<td><b>Contact Number:</b> ${s?.customer?.contactNumber}</td>
									 <td>
									 <g:if test="${s.payment == PaymentType.MONEY_TRANSFER}">
										<b>Shipping Address:</b> ${s?.customer?.shippingAddress}
									</g:if>
									 </td>
								</tr>
							
								<tr class="details">
									<th>Product</th>
									<th>Quantity</th>
									<th colspan="2">Notes</th>
								</tr>
								<g:set var="total" value="${0l}" />
								<g:each in="${s?.cart?.orders}" var="p" status="q">
									<tr class="details">
									<td>
										<g:link controller="productOrder" action="show" id="${p.id}">${p?.product.productName.encodeAsHTML()}</g:link>
									</td>
									<td>${p?.quantity.encodeAsHTML()}</td>
									<td colspan="2">${p?.clientNotes?.encodeAsHTML()}</td>
									</tr>
									<g:set var="total" value="${total+(p.product.price*p.quantity)}"/>
								</g:each>
								
								<tr class="prop">
									<th>Total Price:</th>
									<td valign="top" class="value"><g:formatNumber number="${total}" type="currency" currencyCode="PHP" /></td>
									<g:if test="${s.payment == PaymentType.MONEY_TRANSFER && s.status == OrderStatus.SENT_TO_SHOP}">
									<td><paypal:button itemName="Order From ${s?.store?.storeName}"
										itemNumber="${s?.cart?.id}"
										transactionId="${payment?.transId}"
										amount="${total}"
										discountAmount="0"
										buyerId="${userInstance?.id}"
										/></td>
									</g:if>
								</tr>
										
								<tr class="prop">
									<th>Status:</th>
									<td valign="top" class="value">${s?.status?.encodeAsHTML()}</td>
									<th valign="top" class="name"><g:message code="orderForm.payment.label" default="Payment:" /></th>
									
									<td valign="top" class="value">${s?.payment?.encodeAsHTML()} - ${s.paymentNotes}</td>
									
								</tr>
								
								<g:if test="${s?.payment == PaymentType.MONEY_TRANSFER}">
									<tr>
										<th>Proof of Payment:</th>
										<td colspan="3" valign="center">
											<g:if test="${s?.paymentProof}">
												<img src="${createLink(controller:'orderForm', action:'image', id: s.id)}" height="200"/>
											</g:if>
											<g:else>
												Still waiting for the photo of the deposit slip.
											</g:else>
										</td>
									</tr>
								</g:if>
						</tbody>
					</table>
					</g:if>
				</g:each>
       
        </div>
    </body>
</html>
