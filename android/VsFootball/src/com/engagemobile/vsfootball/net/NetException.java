package com.engagemobile.vsfootball.net;

public class NetException extends Exception {

	public NetException() {
		super();
	}

	public NetException(String detailMessage, Throwable throwable) {
		super(detailMessage, throwable);
	}

	public NetException(String detailMessage) {
		super(detailMessage);
	}

	public NetException(Throwable throwable) {
		super(throwable);
	}

}
