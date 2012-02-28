
<%@ page import="com.productHub.domain.Store" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'store.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="storeName" title="${message(code: 'store.storeName.label', default: 'Store Name')}" />
                        
                            <g:sortableColumn property="storeCode" title="${message(code: 'store.storeCode.label', default: 'Store Code')}" />
                        
                            <th><g:message code="store.user.label" default="User" /></th>
                        
                            <g:sortableColumn property="accountDetails" title="${message(code: 'store.accountDetails.label', default: 'Account Details')}" />
                        
                            <g:sortableColumn property="acceptsDirect" title="${message(code: 'store.acceptsDirect.label', default: 'Accepts Direct')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${storeInstanceList}" status="i" var="storeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${storeInstance.id}">${fieldValue(bean: storeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: storeInstance, field: "storeName")}</td>
                        
                            <td>${fieldValue(bean: storeInstance, field: "storeCode")}</td>
                        
                            <td>${fieldValue(bean: storeInstance, field: "user")}</td>
                        
                            <td>${fieldValue(bean: storeInstance, field: "accountDetails")}</td>
                        
                            <td><g:formatBoolean boolean="${storeInstance.acceptsDirect}" /></td>
                        
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
