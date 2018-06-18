package authenticate;
import com.mongodb.*;


public class LoginCheck {

    static Mongo client = new Mongo();
    static DB database = client.getDB("Login");

    /**
     * Method to check the username and password of a customer.
     * returns a boolean - true if the username and password are right, else false
     */
    public static boolean checkCustomerLogin(String username, String password) {

        boolean login;
        String hashPassword = PasswordEncryption.MD5(password);

        DBCollection customerCollection = database.getCollection("Customers");
        BasicDBObject query = new BasicDBObject();

        query.put("Username", username);
        query.put("Password", hashPassword);

        BasicDBObject where = new BasicDBObject();
        where.put("$and", query);

        DBObject doc = customerCollection.findOne(query);

        if (doc != null) {
            login = true;
        } else
            login = false;
        return login;

    }

    /**
     * Method to check the username and password of a vendor.
     * returns a boolean - true if the username and password are right, else false
     */
    public static boolean checkVendorLogin(String username, String password){

        boolean login;
        String hashPassword = PasswordEncryption.MD5(password);

        DBCollection vendorCollection = database.getCollection("Vendors");
        BasicDBObject query=new BasicDBObject();

        query.put("Username", username);
        query.put("Password", hashPassword);

        BasicDBObject where=new BasicDBObject();
        where.put("$and", query);
        DBObject doc = vendorCollection.findOne(query);

        if (doc != null) {
            login = true;
        } else
            login = false;
        return login;
    }
}


