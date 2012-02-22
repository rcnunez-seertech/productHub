
<%@ page import="com.productHub.domain.Store" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
			<div class="row">	
				<div class="alignright">
				<g:link class="btn" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
				<sec:ifAnyGranted roles="ROLE_VENDOR">
					 <g:if test="${userInstance.store == NULL}">
						<g:link class="btn" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
					</g:if>
				</sec:ifAnyGranted>
				</div>
			</div>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: storeInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.storeName.label" default="Store Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: storeInstance, field: "storeName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.storeCode.label" default="Store Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: storeInstance, field: "storeCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: storeInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.products.label" default="Products" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${storeInstance.products}" var="p">
                                    <li><g:link controller="product" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="store.rating.label" default="Rating" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: storeInstance, field: "rating")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${storeInstance?.id}" />
					
					<sec:ifAnyGranted roles="ROLE_VENDOR">
						<g:if test="${userInstance.store == Store.get(params.id)}">
							<g:actionSubmit class="btn" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
						</g:if>
					</sec:ifAnyGranted>
                    <!--<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />-->
                </g:form>
            </div>
    </body>
</html>
