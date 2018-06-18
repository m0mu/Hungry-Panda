<%@ page import="java.util.ArrayList" %>
<%@ page import="process.Vendor" %>
<%@ page import="java.util.Iterator" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="Error.jsp" %>
<%
    String check = (String) session.getAttribute("sessionVendor");
    if (check != null) { %>
<html>
<head>
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/vendorOrders.css" rel="stylesheet">
    <title>Orders</title>
</head>
<body>

<div class="jumbotron">
    <div class="container" align="center">
        <h1>ORDERS</h1>
        <br/>

        <%

            String sessionVendorString = (String) session.getAttribute("sessionVendor");
            String sessionOutletName = (String) session.getAttribute("sessionVendorOutletName");

            ArrayList<String> customerUsernames = Vendor.getVendorOrdersCustomerUsername(sessionOutletName);
            ArrayList<String> customerOrderIDs = Vendor.getVendorOrdersCustomerOrderID(sessionOutletName);

            ArrayList<String> customerDetails = Vendor.getVendorOrdersCustomers(sessionOutletName);
            ArrayList<ArrayList<?>> itemNames = Vendor.getVendorOrdersItemNames(sessionOutletName);
            ArrayList<ArrayList<?>> itemPrices = Vendor.getVendorOrdersItemPrices(sessionOutletName);
            ArrayList<ArrayList<?>> quantity = Vendor.getVendorOrdersQuantity(sessionOutletName);
            ArrayList<ArrayList<?>> itemTotals = Vendor.getVendorOrdersItemTotal(sessionOutletName);
            ArrayList<String> totalBills = Vendor.getVendorOrdersTotalBill(sessionOutletName);
            ArrayList<String> deliveryStatus = Vendor.getVendorOrdersDeliveryStatus(sessionOutletName);


            Iterator<String> customerUsernamesItr = customerUsernames.iterator();
            Iterator<String> customerOrderIDsItr = customerOrderIDs.iterator();

            Iterator<String> customerDetailsItr = customerDetails.iterator();
            Iterator itemNamesItr = itemNames.iterator();
            Iterator itemPricesItr = itemPrices.iterator();
            Iterator quantityItr = quantity.iterator();
            Iterator itemTotalsItr = itemTotals.iterator();
            Iterator<String> totalBillsItr = totalBills.iterator();
            Iterator<String> deliveryStatusItr = deliveryStatus.iterator();


            int orderNumber = 1;

            while (customerDetailsItr.hasNext() && itemNamesItr.hasNext() && itemPricesItr.hasNext() && quantityItr.hasNext()
                    && itemTotalsItr.hasNext() && totalBillsItr.hasNext() && customerUsernamesItr.hasNext() && customerOrderIDsItr.hasNext() && deliveryStatusItr.hasNext()) {
                out.println(orderNumber + "."); %>
        <%
            String customer = customerDetailsItr.next();
            out.println("Ordered by: " + customer); %>
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
            out.println("Total Bill = ₹" + totalBill);

            String customerUsername = customerUsernamesItr.next();
            String customerOrderID = customerOrderIDsItr.next();

        %>
        <br/>
        <%
            String customerDeliveryStatus = deliveryStatusItr.next();
            out.println("Delivery Status: " + customerDeliveryStatus);
        %>
        <br/>

        <form method="post" action="VendorChangeStatus.jsp">
            <input type="hidden" name="customerUsername" value="<%=customerUsername%>">
            <input type="hidden" name="customerOrderID" value="<%=customerOrderID%>">
            <input type="submit" value="Order Ready">
        </form>
        <br/>
        <br/>
        <%
                orderNumber++;
            }

        %>
    </div>
    <h2>
        <a href="VendorHome.jsp">Menu</a>
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
    window.location = 'VendorLogin.jsp';
</script>
<%
    }
%>