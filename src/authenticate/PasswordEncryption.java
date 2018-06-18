package authenticate;

import java.math.*;
import java.security.*;

public class PasswordEncryption {

    /**
     * Method to hash the password
     * Used during Sign Up  (hashed password is stored in DB).
     * Used when the user enters the password to login.
     */
    public static String MD5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger number = new BigInteger(1, messageDigest);
            String hashtext = number.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
