package com.engagemobile.vsfootball.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SHAUtil {
	public static String getSHA(String val) throws NoSuchAlgorithmException {
		MessageDigest sha = MessageDigest.getInstance("SHA-1");
		sha.update(val.getBytes());
		byte[] m = sha.digest();
		return getString(m);
	}

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
