<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // 현재 세션을 가져옴
    HttpSession userSession = request.getSession();
    
    // 세션에 저장된 속성 출력
    java.util.Enumeration<String> sessionAttributes = userSession.getAttributeNames();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세션 정보</title>
</head>
<body>
    <h1>세션 정보</h1>
    <ul>
    <%
        while (sessionAttributes.hasMoreElements()) {
            String attributeName = sessionAttributes.nextElement();
            Object attributeValue = userSession.getAttribute(attributeName);
    %>
            <li><strong><%= attributeName %>:</strong> <%= attributeValue %></li>
    <%
        }
    %>
    </ul>
</body>
</html>
