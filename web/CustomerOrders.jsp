<%@ page import="java.util.ArrayList" %>
<%@ page import="process.Customer" %>
<%@ page import="java.util.Iterator" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="Error.jsp" %>
<%
    String check = (String) session.getAttribute("sessionCustomer");
    if (check != null) { %>
<html>
<head>
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/vendorOrders.css" rel="stylesheet">
    <title>My Orders</title>

</head>
<body>
<div class="jumbotron">
    <div class="container" align="center">
        <h1>Your Orders</h1>
        <br/>
        <%

            String sessionCustomerUsername = (String) session.getAttribute("sessionCustomer");

            ArrayList<String> outlets = Customer.getCustomersOrdersOutlets(sessionCustomerUsername);
            ArrayList<String> vendorOrderIDs = Customer.getCustomerOrdersVendorOrderIDs(sessionCustomerUsername);
            ArrayList<ArrayList<?>> itemNames = Customer.getCustomerOrdersItemNames(sessionCustomerUsername);
            ArrayList<ArrayList<?>> itemPrices = Customer.getCustomerOrdersItemPrices(sessionCustomerUsername);
            ArrayList<ArrayList<?>> quantity = Customer.getCustomerOrdersQuantity(sessionCustomerUsername);
            ArrayList<ArrayList<?>> itemTotals = Customer.getCustomerOrdersItemTotal(sessionCustomerUsername);
            ArrayList<String> totalBills = Customer.getCustomerOrdersTotalBill(sessionCustomerUsername);
            ArrayList<String> status = Customer.getOrderStatus(sessionCustomerUsername);


            Iterator<String> outletsItr = outlets.iterator();
            Iterator<String> vendorOrderIDsItr = vendorOrderIDs.iterator();
            Iterator itemNamesItr = itemNames.iterator();
            Iterator itemPricesItr = itemPrices.iterator();
            Iterator quantityItr = quantity.iterator();
            Iterator itemTotalsItr = itemTotals.iterator();
            Iterator<String> totalBillsItr = totalBills.iterator();
            Iterator<String> statusItr = status.iterator();


            int orderNumber = 1;

            while (outletsItr.hasNext() && itemNamesItr.hasNext() && itemPricesItr.hasNext() && quantityItr.hasNext()
                    && itemTotalsItr.hasNext() && totalBillsItr.hasNext() && statusItr.hasNext()) {
                out.println(orderNumber + "."); %>
        <%
            String outlet = outletsItr.next();
            out.println("Ordered from Outlet: " + outlet); %>
        <br/>
        <%

            ArrayList<?> namesInEachOrder = (ArrayList<?>) itemNamesItr.next();
            Iterator namesInEachOrderItr = namesInEachOrder.iterator();

            ArrayList<?> pricesInEachOrder = (ArrayList<?>) itemPricesItr.next();
            Iterator pricesInEachOrderItr = pricesInEachOrder.iterator();

            ArrayList<?> quantityInEachOrder = (ArrayList<?>) quantityItr.next();
            Iterator quantityInEachOrderItr = quantityInEachOrder.iterator();

            ArrayList<?> itemTotalInEachOrder = (ArrayList<?>) itemTotalsItr.next();
            Iterator itemTotalInEachOrderItr = itemTotalInEachOrder.iterator();

            while (namesInEachOrderItr.hasNext() && pricesInEachOrderItr.hasNext() && quantityInEachOrderItr.hasNext()
                    && itemTotalInEachOrderItr.hasNext()) {
                String name = namesInEachOrderItr.next().toString();
                String price = pricesInEachOrderItr.next().toString();
                String qty = quantityInEachOrderItr.next().toString();
                String totalForItem = itemTotalInEachOrderItr.next().toString();

                out.println(name + " - ₹" + price + " :: Quantity = " + qty + " :: Total for " + name + " = ₹" + totalForItem); %>
        <br/>
        <%
            }
            String totalBill = totalBillsItr.next();
            out.println("Total Bill = ₹" + totalBill); %>
        <br/>
        <%
            String orderStatus = statusItr.next();
            out.println("Order Status: " + orderStatus);
            String vendorOrderID = vendorOrderIDsItr.next();
        %>

        <br/>
        <form method="post" action="CustomerChangeStatus.jsp">
            <input type="hidden" name="outletName" value="<%=outlet%>">
            <input type="hidden" name="vendorOrderID" value="<%=vendorOrderID%>">
            <%
                if (orderStatus.equals("Ready")) { %>
            <input type="submit" id="mySubmit" value="Received">
            <%
            } else { %>
            <input type="submit" id="mySubmit" value="Received" disabled>
            <%

                }
            %>
        </form>
        <br/>
        <br/>
        <%
                orderNumber++;
            }
        %>

        <h2>
            <a href="CustomerHome.jsp">Home</a>
            <a href="Logout.jsp">Logout</a>
        </h2>
    </div>
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