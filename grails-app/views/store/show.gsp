
<%@ page import="com.productHub.domain.Store" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
        <title>${fieldValue(bean: storeInstance, field: "storeName")}</title>
    </head>
    <body>
        
        <div class="body">
            <h1>${fieldValue(bean: storeInstance, field: "storeName")} <g:if test="${storeInstance?.isValidated}">
			<img src="${resource(dir:'images',file:'validated.png')}" />
			</g:if></h1>
			
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
			<div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${storeInstance?.id}" />
                    <sec:ifAnyGranted roles="ROLE_VENDOR">
						<g:if test="{userInstance?.store == storeInstance}">
							<g:actionSubmit class="btn" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
						</g:if>
					</sec:ifAnyGranted>
					 <sec:ifAnyGranted roles="ROLE_ADMINISTRATOR">
						<g:if test="${!storeInstance?.isValidated}">
						<g:actionSubmit class="btn" action="validate" value="Validate" />
						</g:if>
					 </sec:ifAnyGranted>
                </g:form>
            </div>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.storeCode.label" default="Store Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: storeInstance, field: "storeCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.user.label" default="Owner" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${storeInstance?.user?.id}">${storeInstance?.user?.username?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
						
                        <tr class="prop">
                            <td valign="top" class="name">Payment Forms Accepted</td>
                            
                            <td valign="top" class="value">
							<ul>
								<g:if test="${storeInstance?.acceptsDirect}"><li>Direct Payment</li></g:if> 
								<g:if test="${storeInstance?.acceptsMoneyTransfer}"><li>Money Transfer</li></g:if>
							</ul>
							</td>
                            
                        </tr>
						<g:if test="{storeInstance?.acceptsDirect}">
						<tr class="prop">
                            <td valign="top" class="name"><g:message code="store.meetUpLocations.label" default="Meet Up Locations" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: storeInstance, field: "meetUpLocations")}</td>
                            
                        </tr>
						</g:if>
                    
						<g:if test="{storeInstance?.acceptsMoneyTransfer}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.accountDetails.label" default="Bank Account Details" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: storeInstance, field: "accountDetails")}</td>
                        </tr>
						</g:if>
						
						
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: storeInstance, field: "description")}</td>
                            
                        </tr>
                    
                        
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.products.label" default="Products" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${storeInstance.products}" var="p">
                                    <li><g:link controller="product" action="show" id="${p.id}">${p?.productName.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    </tbody>
                </table>
				<g:set var="total" value="${0l}" />
				<g:set var="count" value="${0l}" />
				<g:if test="${storeInstance?.comments}">
					<g:each in="${storeInstance?.comments}" var="p">
						<g:set var="total" value="${total+(p.rating)}"/>
						<g:set var="count" value="${count+1}"/>
					</g:each>
				<g:set var="total" value="${total / count}" />
				</g:if>
				<h2>Rating : <g:if test="${storeInstance?.comments}">${total}</g:if> <g:else>5</g:else></h2>
				
				<sec:ifAnyGranted roles="ROLE_CLIENT">
				<g:form>
                    <g:hiddenField name="id" value="${storeInstance?.id}" />
					<g:textField name="rating" maxlength="1" />
                    <g:textField name="remarks"/>
                    <g:actionSubmit class="btn" action="addComment" value="${message(code: 'default.button.addComment.label', default: 'Add Comment')}" />
                </g:form>
				</sec:ifAnyGranted>
					<g:each in="${storeInstance.comments}" var="p">
					<table class="orders">
						<tr class="prop">
						<td><g:link controller="user" action="show" id="${p.id}">${p.author.username}</g:link></td>
						<td>${p.rating}</td>
						</tr>
						
						<tr class="prop">
						<td colspan="2">${p.remarks}</td>
						</tr>
					</table>
					</g:each>
				
				
				
            </div>
            
        </div>
    </body>
</html>
