<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="Error.jsp" %>
<%@page import="authenticate.*" %>
<%@ page import="process.Customer" %>
<html>
<%
    String usernameCheck = request.getParameter("username");
    String passwordCheck = request.getParameter("password");

    boolean pass = LoginCheck.checkCustomerLogin(usernameCheck, passwordCheck);

    if (pass) {

        session.setAttribute("sessionCustomer", usernameCheck);
        String customerName = Customer.getName(usernameCheck);
        session.setAttribute("sessionCustomerName", customerName);
        String customerMobile = Customer.getMobile(usernameCheck);
        session.setAttribute("sessionCustomerMobile", customerMobile);

        response.sendRedirect("CustomerHome.jsp");
    } else { %>
<script>
    alert("Username of Password that you've entered is incorrect");
    window.location = 'CustomerLogin.jsp';
</script>
<%
    }
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign In</title>
</head>
<body>
<h1>Hungry Panda</h1>
<center><h2><a href="CustomerLogin.jsp"> Click here to Sign In </a></h2>
</center>
</body>
</html>
