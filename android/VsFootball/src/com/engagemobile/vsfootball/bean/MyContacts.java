package com.engagemobile.vsfootball.bean;

import android.net.Uri;

public class MyContacts {
	public static final String AUTHOR = "com.example.android.ContactsProvider";
	public static final String TABLENAME = "contacts";
	public static final String DBNAME = "mycontacts.db";
	public static final String ID = "_id";
	public static final String NAME = "name";
	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHOR);
	private String email;
	private String name;
	private String phoneNumber;

	public MyContacts(String email, String name,
			String phoneNumber) {
		super();
		this.email = email;
		this.name = name;
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

}
