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
			sb.append(b[i]);
		}
		String result = sb.toString();
		result = result.replaceAll("-", "");
		return result;
	}
}
