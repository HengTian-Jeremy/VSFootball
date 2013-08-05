package com.engagemobile.vsfootball.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 * This Class is used for validating the format of email address.
 * @author xiaoyuanhu
 *
 */
public class ValidateUtil {

	public static boolean validateEmail(String email) {
		String pattern = "^([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$";
		if (email == null)
			return false;
		Pattern regex = Pattern.compile(pattern);
		Matcher matcher = regex.matcher(email);
		return matcher.matches();

	}

}
