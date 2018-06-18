<%@ page import="process.Customer" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="Error.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>

<%
    String check = (String) session.getAttribute("sessionCustomer");
    if (check != null) { %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/customerHome.css" rel="stylesheet">
    <title>Home</title>
</head>
<body>
<center>
    <div class="jumbotron">
        <form action="CustomerOrder.jsp" method="post">
            <h1>
                <%
                    String sessionCustomerString = (String) session.getAttribute("sessionCustomer");
                    String customerName = (String) session.getAttribute("sessionCustomerName");
                    String customerMobile = (String) session.getAttribute("sessionCustomerMobile");

                    out.println("Hello " + customerName);
                %>
            </h1>
            <br/>
            <h2>
                Please select the outlet:
            </h2>

            <br/>
            <%
                ArrayList outlets = Customer.getOutlets();
                outlets.add("SugarJar");
                Iterator<String> outletItr = outlets.iterator();
                while (outletItr.hasNext()) {
                    String outlet = outletItr.next();
            %>
            <h4>
                <br/> <input type="submit" name="selectedOutlet" value="<%=outlet%>">
                <br/>
                <%
                    }
                %>
            </h4>
            <h3>
                <br/>
                <a href="CustomerOrders.jsp">My Orders</a>
                <a href="Logout.jsp">Logout</a>
            </h3>
        </form>
    </div>
</center>
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
