

<%@ page import="com.productHub.domain.OrderForm" %>

<%@ page import="com.productHub.domain.OrderStatus" %>
<%@ page import="com.productHub.domain.PaymentType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orderForm.label', default: 'OrderForm')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${orderFormInstance}">
            <div class="alert-message block-message error">
				<h2>Errors found!</h2>
                <g:renderErrors bean="${orderFormInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post"  enctype="multipart/form-data">
                <g:hiddenField name="id" value="${orderFormInstance?.id}" />
                <g:hiddenField name="version" value="${orderFormInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="orderForm.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orderFormInstance, field: 'status', 'errors')}">
                                    <select name="status" id="status" class="value ${hasErrors(bean: orderFormInstance, field: 'status', 'errors')}">
										<sec:ifAnyGranted roles="ROLE_CLIENT">
											<option value="${OrderStatus.RECEIVED.name()}">${OrderStatus.RECEIVED}</option>
										</sec:ifAnyGranted>
										<sec:ifAnyGranted roles="ROLE_VENDOR">
											<g:if test="${orderFormInstance?.payment == PaymentType.MONEY_TRANSFER}">
												<option value="${OrderStatus.AWAITING_PAYMENT.name()}">${OrderStatus.AWAITING_PAYMENT}</option>
												<option value="${OrderStatus.PAYMENT_ACCEPTED.name()}">${OrderStatus.PAYMENT_ACCEPTED}</option>
												<option value="${OrderStatus.PAYMENT_REJECTED.name()}">${OrderStatus.PAYMENT_REJECTED}</option>
												<option value="${OrderStatus.DELIVERED.name()}">${OrderStatus.DELIVERED}</option>
											</g:if>
											<g:else>
												<option value="${OrderStatus.APPROVED.name()}">${OrderStatus.APPROVED}</option>
											</g:else>
										</sec:ifAnyGranted>
										
									</select>

							   </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <g:actionSubmit class="btn" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </div>
            </g:form>
        </div>
    </body>
</html>
