package com.engagemobile.vsfootball.bean;

import java.util.List;

public class MyContacts {
	private String email;
	private String name;
	private List<String> listNumber;

	public MyContacts(String email, String name,
			List<String> listNumber) {
		super();
		this.email = email;
		this.name = name;
		this.listNumber = listNumber;
	}

	public MyContacts() {
		super();
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

	public List<String> getListNumber() {
		return listNumber;
	}

	public void setListNumber(List<String> listNumber) {
		this.listNumber = listNumber;
	}

	public void addNumber(String number) {
		this.listNumber.add(number);
	}
}
