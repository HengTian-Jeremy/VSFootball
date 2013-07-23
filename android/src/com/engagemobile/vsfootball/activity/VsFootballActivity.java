package com.engagemobile.vsfootball.activity;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.R.layout;
import com.engagemobile.vsfootball.R.menu;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;

public class VsFootballActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_vs_football);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.vs_football, menu);
		return true;
	}

}
