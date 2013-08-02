package com.engagemobile.vsfootball.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Define the password encryption algorithm.
 * 
 * @author xiaoyuanhu
 */
public class SHAUtil {
	/**
	 * Encrypt the passwords to a byte array
	 * 
	 * @param val
	 *            the password you entered.
	 * @return an encrypted byte array
	 * @throws NoSuchAlgorithmException
	 */
	public static String getSHA(String val) throws NoSuchAlgorithmException {
		MessageDigest sha = MessageDigest.getInstance("SHA-1");
		sha.update(val.getBytes());
		byte[] m = sha.digest();
		return getString(m);
	}

	/**
	 * Convert the byte array into a string.
	 * 
	 * @param b
	 *            an encrypted byte array
	 * @return a string was encrypted
	 */
	private static String getString(byte[] b) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < b.length; i++) {
			if ((0xff & b[i]) < 0x10) {
				sb.append("0" + Integer.toHexString((0xFF & b[i])));
			} else {
				sb.append(Integer.toHexString(0xFF & b[i]));
			}
		}
		return sb.toString();
	}

}
