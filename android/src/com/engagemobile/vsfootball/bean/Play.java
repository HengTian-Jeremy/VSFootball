package com.engagemobile.vsfootball.bean;

public class Play {
	public Play(int id, String name, String type, String style, float price) {
		super();
		this.id = id;
		this.name = name;
		this.type = type;
		this.style = style;
		this.price = price;
	}

	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	private String name;
	private String type;
	private String style;
	private float price;
}
