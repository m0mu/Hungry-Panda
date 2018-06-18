package process;

import com.mongodb.*;
import org.bson.types.ObjectId;

import java.util.ArrayList;

public class Vendor {

    static Mongo client = new Mongo();
    static DB database = client.getDB("global");
    static DB databaseLogin = client.getDB("Login");

    /**
     * Method to change the status of an order in Customer's collection.
     * Used when the vendor clicks the 'Order Ready' button in Vendor's Orders Page
     */
    public static void changeStatusInCustomerMyOrdersPage(String customerUsername, String customerOrderID) {

        DBCollection Orders = database.getCollection(customerUsername + "MyOrders");

        DBObject query = new BasicDBObject("_id", new ObjectId(customerOrderID));
        DBObject update = new BasicDBObject();
        update.put("$set", new BasicDBObject("Status","Ready"));

        Orders.update(query, update);
    }

    /**
     * Method to get the Delivery Status of each order from the Vendor's Orders Collection.
     * Return a list containing each order's delivery status.
     */
    public static ArrayList<String> getVendorOrdersDeliveryStatus(String sessionOutletName) {

        DBCollection Orders = database.getCollection(sessionOutletName + "Orders");
        DBCursor cursorStatus = Orders.find();

        ArrayList<String> deliveryStatusArr = new ArrayList<>();

        while (cursorStatus.hasNext()) {
            String customer = (String) cursorStatus.next().get("Delivery Status");
            deliveryStatusArr.add(customer);
        }
        return deliveryStatusArr;
    }

    /**
     * Method to get the Customer's username of each order from the Vendor's Orders Collection.
     * Return a list containing each order's Customer Username.
     */
    public static ArrayList<String> getVendorOrdersCustomerUsername(String sessionOutletName) {

        DBCollection Orders = database.getCollection(sessionOutletName + "Orders");
        DBCursor cursorCustomerUsername = Orders.find();

        ArrayList<String> customerUsernameArr = new ArrayList<>();

        while (cursorCustomerUsername.hasNext()) {
            String customer = (String) cursorCustomerUsername.next().get("Customer Username");
            customerUsernameArr.add(customer);
        }
        return customerUsernameArr;
    }

    /**
     * Method to get the Customer's ObjectID of each order from the Vendor's Orders Collection.
     * Return a list containing each order's Customer's ObjectID
     */
    public static ArrayList<String> getVendorOrdersCustomerOrderID(String sessionOutletName) {

        DBCollection Orders = database.getCollection(sessionOutletName + "Orders");
        DBCursor cursorOrderID = Orders.find();

        ArrayList<String> orderIDArr = new ArrayList<>();

        while (cursorOrderID.hasNext()) {
            String customer = (String) cursorOrderID.next().get("Customer Order ID");
            orderIDArr.add(customer);
        }
        return orderIDArr;
    }

    /**
     * Method to get the Customer Details of each order from the Vendor's Orders Collection.
     * Return a list containing each order's Customer Details.
     */
    public static ArrayList<String> getVendorOrdersCustomers(String sessionOutletName) {

        DBCollection Orders = database.getCollection(sessionOutletName + "Orders");
        DBCursor cursorCustomer = Orders.find();

        ArrayList<String> customerArr = new ArrayList<>();

        while (cursorCustomer.hasNext()) {
            String customer = (String) cursorCustomer.next().get("Customer Details");
            customerArr.add(customer);
        }
        return customerArr;
    }

    /**
     * Method to get the Item Names of each order from the Vendor's Orders Collection.
     * Return a list of lists containing each order's Item Names.
     * Each order may have more than one item. Hence it is a list of lists.
     */
    public static ArrayList<ArrayList<?>> getVendorOrdersItemNames(String sessionOutletName) {

        DBCollection Orders = database.getCollection(sessionOutletName + "Orders");
        DBCursor cursorNames = Orders.find();

        ArrayList<ArrayList<?>> itemNamesArr = new ArrayList<>();

        while (cursorNames.hasNext()) {
            ArrayList<?> itemNames = (BasicDBList) cursorNames.next().get("Item Name");
            itemNamesArr.add(itemNames);
        }
        return itemNamesArr;
    }

    /**
     * Method to get the Item Prices of each order from the Vendor's Orders Collection.
     * Return a list of lists containing each order's Item Price.
     * Each order may have more than one item. Hence it is a list of lists.
     */
    public static ArrayList<ArrayList<?>> getVendorOrdersItemPrices(String sessionOutletName) {

        DBCollection Orders = database.getCollection(sessionOutletName + "Orders");
        DBCursor cursorPrices = Orders.find();

        ArrayList<ArrayList<?>> itemPricesArr = new ArrayList<>();

        while (cursorPrices.hasNext()) {
            ArrayList<?> itemPrices = (BasicDBList) cursorPrices.next().get("Item Price");
            itemPricesArr.add(itemPrices);
        }
        return itemPricesArr;
    }

    /**
     * Method to get the Quantity of each order from the Vendor's Orders Collection.
     * Return a list of lists containing each order's Quantity.
     * Each order may have more than one item. Hence it is a list of lists.
     */
    public static ArrayList<ArrayList<?>> getVendorOrdersQuantity(String sessionOutletName) {

        DBCollection Orders = database.getCollection(sessionOutletName + "Orders");
        DBCursor cursorQuantity = Orders.find();

        ArrayList<ArrayList<?>> quantityArr = new ArrayList<>();

        while (cursorQuantity.hasNext()) {
            ArrayList<?> quantity = (BasicDBList) cursorQuantity.next().get("Quantity");
            quantityArr.add(quantity);
        }
        return quantityArr;
    }

    /**
     * Method to get each item's total of each order from the Vendor's Orders Collection.
     * Return a list of lists containing each order's item totals.
     * Each order may have more than one item. Hence it is a list of lists.
     */
    public static ArrayList<ArrayList<?>> getVendorOrdersItemTotal(String sessionOutletName) {

        DBCollection Orders = database.getCollection(sessionOutletName + "Orders");
        DBCursor cursorItemTotal = Orders.find();

        ArrayList<ArrayList<?>> itemTotalArr = new ArrayList<>();

        while (cursorItemTotal.hasNext()) {
            ArrayList<?> itemTotal = (BasicDBList) cursorItemTotal.next().get("Item Total");
            itemTotalArr.add(itemTotal);
        }
        return itemTotalArr;
    }

    /**
     * Method to get total bill of each order from the Vendor's Orders Collection.
     * Return a list containing each order's total bill.
     */
    public static ArrayList<String> getVendorOrdersTotalBill(String sessionOutletName) {

        DBCollection Orders = database.getCollection(sessionOutletName + "Orders");
        DBCursor cursorTotalBill = Orders.find();

        ArrayList<String> totalBillArr = new ArrayList<>();

        while (cursorTotalBill.hasNext()) {
            String totalBill = cursorTotalBill.next().get("Total Bill").toString();
            totalBillArr.add(totalBill);
        }
        return totalBillArr;
    }

    /**
     * Method to add an order to Vendor's Orders Collection.
     * Used when the customer click on place order.
     * Stores all the details in the collection.
     */
    public static void addToVendorOrders(String selectedOutlet, String customerUsername, String customerOrderID, String customer, ArrayList<String> itemName, ArrayList<Integer> itemPrice, ArrayList<Integer> quantity, ArrayList<Integer> itemTotal, int totalBill) {

        DBCollection vendorOrderCollection = database.getCollection(selectedOutlet + "Orders");

        BasicDBObject presentOrder = new BasicDBObject("Customer Username", customerUsername).append("Customer Order ID", customerOrderID).append("Customer Details", customer).append("Item Name", itemName).append("Item Price", itemPrice).append("Quantity", quantity).append("Item Total", itemTotal).append("Total Bill", totalBill).append("Delivery Status", "Not Received");
        vendorOrderCollection.insert(presentOrder);

    }

    /**
     * Method to get outlet name from a username of a vendor.
     * Queries the DB with the username and return the outlet name of the vendor
     */
    public static String getOutletName(String username) {

        String outletName;

        DBCollection customerCollection = databaseLogin.getCollection("Vendors");

        DBObject query = new BasicDBObject("Username", username);
        DBObject where = customerCollection.findOne(query);

        outletName = where.get("Outlet").toString();

        return outletName;
    }

    /**
     * Method to get Vendor's name from a username of a vendor.
     */
    public static String getVendorName(String username) {

        String vendorName;

        DBCollection customerCollection = databaseLogin.getCollection("Vendors");

        DBObject query = new BasicDBObject("Username", username);
        DBObject where = customerCollection.findOne(query);

        vendorName = where.get("Name").toString();

        return vendorName;
    }

    /**
     * Method to get all the item names in the menu of an outlet.
     * Return a list of all the item names (strings).
     */
    public static ArrayList getItemNames(String outletName) {

        DBCollection Menu = database.getCollection(outletName + "menu");

        BasicDBObject queryName = new BasicDBObject();
        BasicDBObject fieldName = new BasicDBObject();
        fieldName.put("Item Name", 1);
        DBCursor cursorName = Menu.find(queryName, fieldName);
        ArrayList itemNameArr = new ArrayList();
        while (cursorName.hasNext()) {
            BasicDBObject objName = (BasicDBObject) cursorName.next();
            itemNameArr.add(objName.getString("Item Name"));
        }
        return itemNameArr;
    }

    /**
     * Method to get all the item prices in the menu of an outlet.
     * Return a list of all the item prices.
     */
    public static ArrayList getItemPrices(String outletName) {

        DBCollection Menu = database.getCollection(outletName + "menu");

        BasicDBObject queryPrice = new BasicDBObject();
        BasicDBObject fieldPrice = new BasicDBObject();
        fieldPrice.put("Price", 1);
        DBCursor cursorPrice = Menu.find(queryPrice, fieldPrice);
        ArrayList priceArr = new ArrayList();
        while (cursorPrice.hasNext()) {
            BasicDBObject objPrice = (BasicDBObject) cursorPrice.next();
            priceArr.add(objPrice.getString("Price"));
        }
        return priceArr;
    }

    /**
     * Method to add an item to the menu of an outlet.
     * Used when the Vendor clicks the Add button present in the homepage of the Vendor.
     */
    public static void addToMenu(String itemName, String itemPrice, String outletName) {

        DBCollection Menu = database.getCollection(outletName + "menu");

        BasicDBObject details = new BasicDBObject("Item Name", itemName).append("Price", itemPrice);
        Menu.insert(details);

    }

}


