
<%@ page import="com.productHub.domain.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
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
            <div class="list">
                <table class="zebra-striped">
                    <thead>
                        <tr>
							<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn property="emailAddress" title="${message(code: 'user.emailAddress.label', default: 'Email Address')}" />
							
							
                            <g:sortableColumn property="firstName" title="${message(code: 'user.firstName.label', default: 'First Name')}" />
                        
                            <g:sortableColumn property="lastName" title="${message(code: 'user.lastName.label', default: 'Last Name')}" />
                        
                        
                            
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userInstanceList}" status="i" var="userInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
						
							 <td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
                        
                            <td>${fieldValue(bean: userInstance, field: "emailAddress")}</td>
                        
                            <td>${fieldValue(bean: userInstance, field: "firstName")}</td>
                        
                            <td>${fieldValue(bean: userInstance, field: "lastName")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${userInstanceTotal}" />
            </div>
    </body>
</html>
