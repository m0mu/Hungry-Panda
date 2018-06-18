<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="Error.jsp" %>
<%@page import="process.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%
    String check = (String) session.getAttribute("sessionVendor");
    if (check != null) { %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/vendorHome.css" rel="stylesheet">
    <title>Home</title>
</head>
<body>
<center>
    <div class="jumbotron">

        <h1>
            <%
                String sessionVendorString = (String) session.getAttribute("sessionVendor");
                String vendorName = (String) session.getAttribute("sessionVendorName");
                String outletName = (String) session.getAttribute("sessionVendorOutletName");
                out.println("Hello " + outletName);
            %>
        </h1>

        <div class="container">
            <form action="AddToMenu.jsp" method="post">
                Item Name:<input type="text" name="item">
                Price:<input type="number" min="1" name="price">
                <input type="submit" value="Add">
            </form>
        </div>
        <br/>
        <h3>
            <%
                ArrayList menuItemNames = Vendor.getItemNames(outletName);
                Iterator<String> menuItr = menuItemNames.iterator();
                ArrayList menuPrices = Vendor.getItemPrices(outletName);
                Iterator<String> menuPriceItr = menuPrices.iterator();
                int i = 1;
                while (menuItr.hasNext() && menuPriceItr.hasNext()) {

                    String itemName = menuItr.next();
                    String itemPrice = menuPriceItr.next();
                    String item = itemName + " - " + "₹" + itemPrice;
            %>
            <br/>
            <%
                    out.println(i + " . " + item);
                    i++;
                }
            %>
            <br/>
            <br/>
        </h3>

        <h2 align="right">
            <a href="VendorOrders.jsp">Orders</a>
            <a href="Logout.jsp">Logout</a>
        </h2>
    </div>
</center>
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