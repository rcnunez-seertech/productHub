

<%@ page import="com.productHub.domain.OrderForm" %>
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
                                  <label for="paymentProof"><g:message code="orderForm.paymentProof.label" default="Payment Proof" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orderFormInstance, field: 'paymentProof', 'errors')}">
                                    <input type="file" id="paymentProof" name="paymentProof" />
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                   <g:actionSubmit class="btn" action="update2" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </div>
            </g:form>
        </div>
    </body>
</html>
