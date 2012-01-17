
<%@ page import="com.productHub.domain.Store" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
       
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
           <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
			<div class="row">
				<div class="alignright">
				&nbsp;&nbsp;<g:link class="btn" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
				</div>
			</div>
            <div class="zebra-striped">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'store.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="storeName" title="${message(code: 'store.storeName.label', default: 'Store Name')}" />
                        
                            <g:sortableColumn property="storeCode" title="${message(code: 'store.storeCode.label', default: 'Store Code')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'store.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="rating" title="${message(code: 'store.rating.label', default: 'Rating')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${storeInstanceList}" status="i" var="storeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${storeInstance.id}">${fieldValue(bean: storeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: storeInstance, field: "storeName")}</td>
                        
                            <td>${fieldValue(bean: storeInstance, field: "storeCode")}</td>
                        
                            <td>${fieldValue(bean: storeInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: storeInstance, field: "rating")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${storeInstanceTotal}" />
            </div>
    </body>
</html>
