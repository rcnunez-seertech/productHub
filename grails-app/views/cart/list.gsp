
<%@ page import="com.productHub.domain.Cart" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cart.label', default: 'Cart')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
           <h1><g:message code="default.list.label" args="[entityName]" /></h1>
           <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
			<!--<div class="row">
				<div class="alignright">
				&nbsp;&nbsp;<g:link class="btn" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
				</div>
			</div>-->
                <table class="zebra-striped">
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="user" title="${message(code: 'cart.user.label', default: 'User')}" />
                        
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${cartInstanceList}" status="i" var="cartInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${cartInstance.id}">${fieldValue(bean: cartInstance, field: "user.username")}</g:link></td>
                        
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            <div class="paginateButtons">
                <g:paginate total="${cartInstanceTotal}" />
            </div>
    </body>
</html>
