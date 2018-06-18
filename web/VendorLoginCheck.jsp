<%@page import="authenticate.*" %>
<%@ page import="process.Vendor" %>
<%@page contentType="text/html" language="java" pageEncoding="UTF-8" %>
<%
    String usernameCheck = request.getParameter("username");
    String passwordCheck = request.getParameter("password");

    boolean pass = LoginCheck.checkVendorLogin(usernameCheck, passwordCheck);

    if (pass) {
        session.setAttribute("sessionVendor", usernameCheck);
        String vendorName = Vendor.getVendorName(usernameCheck);
        String outletName = Vendor.getOutletName(usernameCheck);
        session.setAttribute("sessionVendorName", vendorName);
        session.setAttribute("sessionVendorOutletName", outletName);
        response.sendRedirect("VendorHome.jsp");
    } else { %>
<script>
    alert("Username of Password that you've entered is incorrect");
    window.location = 'VendorLogin.jsp';
</script>
<%
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign In</title>
</head>
<body>
<h1>Hungry Panda</h1>
<center><h2><a href="VendorLogin.jsp"> Click here to Sign In </a></h2>
</center>
</body>
</html>