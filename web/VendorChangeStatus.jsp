<%@ page import="process.Vendor" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="Error.jsp" %>
<%
    String check = (String) session.getAttribute("sessionVendor");
    if (check != null) { %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String customerUsername = request.getParameter("customerUsername");
    String customerOrderID = request.getParameter("customerOrderID");

    Vendor.changeStatusInCustomerMyOrdersPage(customerUsername, customerOrderID);

    response.sendRedirect("VendorOrders.jsp");
%>
</body>
</html>
<%
} else { %>
<script>
    alert("Please Login");
    window.location = 'VendorLogin.jsp';
</script>
<%
    }
%>