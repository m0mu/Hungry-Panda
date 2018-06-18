<%@ page import="process.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="process.Vendor" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="Error.jsp" %>
<%
    String check = (String) session.getAttribute("sessionCustomer");
    if (check != null) { %>
<html>
<head>
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/customerOrderConfirm.css" rel="stylesheet">
    <title></title>
</head>
<body>
<div class="jumbotron" align="center">
    <h1>
        Your Order:
    </h1>
    <div class="container">
        <%
            String sessionSelectedOutlet = (String) session.getAttribute("sessionSelectedOutlet");
            String sessionCustomerUsername = (String) session.getAttribute("sessionCustomer");
            String sessionCustomerName = (String) session.getAttribute("sessionCustomerName");
            String sessionCustomerMobile = (String) session.getAttribute("sessionCustomerMobile");
            String userDetails = sessionCustomerName + ", " + sessionCustomerMobile;

            String[] values = request.getParameterValues("items");
            int totalBill = 0;
            ArrayList<String> itemNamesOrder = new ArrayList();
            ArrayList<Integer> itemPricesOrder = new ArrayList();
            ArrayList<Integer> qty = new ArrayList();
            ArrayList<Integer> itemTotal = new ArrayList();

            if (values != null) {
                for (String val : values) {
                    String[] splitNamePrice = val.split(",");
                    String itemName = splitNamePrice[0];
                    String itemPriceString = splitNamePrice[1];
                    String quantityString = request.getParameter(itemName);
                    int quantity = Integer.parseInt(quantityString);
                    int itemPrice = Integer.parseInt(itemPriceString);
                    int eachItemTotal = Customer.getEachItemTotal(itemPrice, quantity);
                    itemNamesOrder.add(itemName);
                    itemPricesOrder.add(itemPrice);
                    qty.add(quantity);
                    itemTotal.add(eachItemTotal);
        %>
        <br/>
        <%
                    out.println(itemName + " - " + "₹" + itemPrice);
                    out.println("Quantity ordered = " + quantity);
                    out.println(" Total amount for " + itemName + " = ₹" + eachItemTotal);

                    totalBill = Customer.getTotalBill(itemTotal);
                }

                Customer.addToCustomerOrders(sessionCustomerUsername, sessionSelectedOutlet, itemNamesOrder, itemPricesOrder, qty, itemTotal, totalBill);
                String customerOrderID = Customer.getLastOrderID(sessionCustomerUsername);

                Vendor.addToVendorOrders(sessionSelectedOutlet, sessionCustomerUsername, customerOrderID, userDetails, itemNamesOrder, itemPricesOrder, qty, itemTotal, totalBill);
                String vendorOrderID = Customer.getVendorOrderID(sessionSelectedOutlet, customerOrderID);

                Customer.addVendorOrderIDToMyCollection(sessionCustomerUsername, customerOrderID, vendorOrderID);

            }
        %>
        <br/>
        <%
            out.println("Your total bill is: ₹" + totalBill);
        %>
        <br/>
        <br/>
        <br/>
        <br/>
    </div>
    <h2>Order Successfully placed!
    </h2>
    <h3>
        <a href="CustomerHome.jsp">Home</a>
        <a href="CustomerOrders.jsp">My Orders</a>
        <a href="Logout.jsp">Logout</a>
    </h3>
</div>
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