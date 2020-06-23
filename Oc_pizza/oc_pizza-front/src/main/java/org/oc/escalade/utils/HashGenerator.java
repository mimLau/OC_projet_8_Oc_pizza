package org.oc.escalade.utils;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashGenerator {
    public final static String cryptoMD5(String cryptoText) {
        byte[] defaultBytes = null;
        defaultBytes = cryptoText.getBytes();

        try{
            MessageDigest algorithm = MessageDigest.getInstance( "MD5" );
            algorithm.reset();
            algorithm.update(defaultBytes);
            byte messageDigest[] = algorithm.digest();

            StringBuffer hexString = new StringBuffer();
            for (int i=0;i<messageDigest.length;i++) {
                hexString.append(Integer.toHexString(0xFF & messageDigest[i]));
            }
            cryptoText = hexString.toString();

        }catch( NoSuchAlgorithmException nsae ){

        }
        return cryptoText;
    }


    public final static String toHexString(String input) throws NoSuchAlgorithmException {
        // Convert byte array into signum representation
        BigInteger number = new BigInteger(1, getSHA(input));

        // Convert message digest into hex value
        StringBuilder hexString = new StringBuilder(number.toString(16));

        // Pad with leading zeros
        while (hexString.length() < 32)
        {
            hexString.insert(0, '0');
        }

        return hexString.toString();
    }



    private static byte[] getSHA(String input) throws NoSuchAlgorithmException {
        // Static getInstance method is called with hashing SHA
        MessageDigest md = MessageDigest.getInstance("SHA-256");

        // digest() method called
        // to calculate message digest of an input
        // and return array of byte
        return md.digest(input.getBytes(StandardCharsets.UTF_8));
    }


}
