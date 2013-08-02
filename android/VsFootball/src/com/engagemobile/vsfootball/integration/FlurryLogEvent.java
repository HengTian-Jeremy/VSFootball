package com.engagemobile.vsfootball.integration;

import java.util.HashMap;
import java.util.Map;

import com.flurry.android.FlurryAgent;

/**
 * Used to log events to Flurry
 * 
 * @author Andrew Zhao
 */
public class FlurryLogEvent {
	private Map<String, String> mParams = new HashMap<String, String>();
	private FlurryEventId mEventId;

	/**
	 * Constructs a new empty FlurryLogEvent instance.
	 */
	public FlurryLogEvent() {
		mParams.clear();
	}

	/**
	 * Constructs a new empty FlurryLogEvent instance.
	 * 
	 * @param eventId
	 *            The Flurry event id
	 */
	public FlurryLogEvent(FlurryEventId eventId) {
		this();
		setmEventId(eventId);
	}

	/**
	 * Add parameter and its value attached with this event log
	 * 
	 * @param param
	 *            The {@link FlurryLogEvent} parameter
	 * @param value
	 *            The value of this parameter
	 */
	public void addParam(FlurryParam param, String value) {
		mParams.put(param.getName(), value);
	}

	/**
	 * Send the event to log in to Flurry
	 */
	public void send() {
		if (getmEventId() != null) {
			FlurryAgent.logEvent(getmEventId().name(), mParams);
		}

	}

	public FlurryEventId getmEventId() {
		return mEventId;
	}

	public void setmEventId(FlurryEventId mEventId) {
		this.mEventId = mEventId;
	}

}
