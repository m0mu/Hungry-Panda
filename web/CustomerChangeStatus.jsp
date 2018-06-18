<%@ page import="process.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String check = (String) session.getAttribute("sessionCustomer");
    if (check != null) { %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String outletName = request.getParameter("outletName");
    //out.println(outletName);

    String vendorOrderID = request.getParameter("vendorOrderID");
    //out.println(vendorOrderID);


    Customer.changeStatusInVendorOrdersPage(outletName, vendorOrderID);

    response.sendRedirect("CustomerOrders.jsp");
%>
</body>
</html>
<%
} else { %>
<script>
    alert("Please Login");
    window.location = 'CustomerLogin.jsp';
</script>
<%
    }
%>