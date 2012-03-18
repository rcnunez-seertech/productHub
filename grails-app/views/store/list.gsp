
<%@ page import="com.productHub.domain.Store" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="zebra-striped">
                    <thead>
                        <tr>
                        
                           
                        
                            <th>Store Name</th>
                        
                            <th>Store Code</th>
                        
                            <th>Owner</th>
                        
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${storeInstanceList}" status="i" var="storeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                         
                        
                            <td><g:link action="show" id="${storeInstance.id}">${fieldValue(bean: storeInstance, field: "storeName")}</g:link></td>
                        
                            <td>${fieldValue(bean: storeInstance, field: "storeCode")}</td>
                        
                            <td><g:link controller="user" action="show" id="${storeInstance.user.id}">${fieldValue(bean: storeInstance, field: "user")}</g:link></td>
                        
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${storeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
