package com.engagemobile.vsfootball.activity;

import android.content.Intent;
import android.os.Bundle;

import com.engagemobile.vsfootball.R;
import com.facebook.Request;
import com.facebook.Session;
import com.facebook.SessionState;
import com.facebook.model.GraphUser;

public class FacebookLoginActivity extends VsFootballActivity {
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_facebook_login);
		
		/*
		// start Facebook Login
		Session.openActiveSession(this, true, new Session.StatusCallback() {

			// callback when session changes state
			@Override
			public void call(Session session, SessionState state,
					Exception exception) {
				if (session.isOpened()) {

					// make request to the /me API
					Request.executeMeRequestAsync(session,
							new Request.GraphUserCallback() {

								// callback after Graph API response with user object

								@Override
								public void onCompleted(GraphUser user,
										com.facebook.Response response) {
									if (user != null) {
										//			                TextView welcome = (TextView) findViewById(R.id.welcome);
										//			                welcome.setText("Hello " + user.getName() + "!");
									}
								}
							});
				}
			}
		});
		*/
	}

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		Session.getActiveSession().onActivityResult(this, requestCode,
				resultCode, data);
	}
}
