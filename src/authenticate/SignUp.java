package authenticate;
import com.mongodb.*;

public class SignUp {

    static Mongo client = new Mongo();
    static DB database = client.getDB("Login");

    /**
     * Method to store the Vendor Details entered in Sign Up page.
     * The details are stored in a Mongo DB.
     */
    public static void signUpVendor(String name, String username, String password, String mobile, String outletName){

        String hashPassword = PasswordEncryption.MD5(password); //hashing the password before storing in the db

        DBCollection vendorCollection = database.getCollection("Vendors");

        BasicDBObject details = new BasicDBObject("Name", name).append("Username", username).append("Password", hashPassword).append("Mobile", mobile).append("Outlet", outletName);
        vendorCollection.insert(details);

        }

    /**
     * Method to check if the username that is entered in Vendor Sign up page already exists.
     * Returns a boolean, true if it already exists and false it it does not
     */
    public static boolean vendorUsernameAlreadyExists(String username){

        boolean check;

        DBCollection vendorCollection = database.getCollection("Vendors");

        DBObject query = new BasicDBObject("Username", username);
        DBObject where = vendorCollection.findOne(query);

        if (where != null){
            check = true;
        } else {
            check = false;
        }
        return check;
    }

    /**
     * Method to store the Customer Details entered in Sign Up page.
     * The details are stored in a Mongo DB.
     */
    public static void signUpCustomer(String name, String username, String password, String mobile, String room){

        String hashPassword = PasswordEncryption.MD5(password); //hashing the password before storing it

        DBCollection customerCollection = database.getCollection("Customers");

        BasicDBObject details = new BasicDBObject("Name", name).append("Username", username).append("Password", hashPassword).append("Mobile", mobile).append("Room",room);
        customerCollection.insert(details);

    }

    /**
     * Method to check if the username that is entered in Customer Sign up page already exists.
     * Returns a boolean, true if it already exists and false it it does not
     */
    public static boolean customerUsernameAlreadyExists(String username){

        boolean check;

        DBCollection customerCollection = database.getCollection("Customers");

        DBObject query = new BasicDBObject("Username", username);
        DBObject where = customerCollection.findOne(query);

        if (where != null){
            check = true;
        } else {
            check = false;
        }
        return check;
    }
}
