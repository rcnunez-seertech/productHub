
<%@ page import="com.productHub.domain.Wishlist" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'wishlist.label', default: 'Wishlist')}" />
        <title>${wishlistInstance?.user?.username?.encodeAsHTML()}'s Wishlist</title>
    </head>
    <body>
        
        <div class="body">
            <h1>${wishlistInstance?.user?.username?.encodeAsHTML()}'s Wishlist</h1>
            <g:if test="${flash.message}">
            <div class="alert-message block-message warning">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                    
                        <tr class="prop">
                          
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${wishlistInstance.products}" var="p">
                                    <li><g:link controller="product" action="show" id="${p.id}">${p?.productName?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
