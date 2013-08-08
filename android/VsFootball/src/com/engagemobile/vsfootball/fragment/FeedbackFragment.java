package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.app.FragmentTransaction;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.MainActivity;
import com.engagemobile.vsfootball.bean.ModelContext;
import com.engagemobile.vsfootball.net.FeedbackService;
import com.engagemobile.vsfootball.net.GameService;
import com.engagemobile.vsfootball.net.NetException;
import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.view.adapter.GameAdapter;
import com.engagemobile.vsfootball.view.adapter.NewOpponentsAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class FeedbackFragment extends VsFootballFragment {
	private Button mBtnCancel;
	private Button mBtnSubmit;
	private EditText mEtContent;
	private OnClickListener mOnClickListener;
	private ProgressDialog mProgress;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		mOnClickListener = new OnClickListener() {
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (v == mBtnCancel)
					activityParent.getFragmentManager().popBackStack();
				else if (v == mBtnSubmit) {
					String content = mEtContent.getText().toString();
					if (!content.isEmpty()) {
						sendFeedback(content);
					}

				}
			}

		};
		super.onCreate(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater.inflate(R.layout.fragment_feedback, null);
		mBtnCancel = (Button) rootView.findViewById(R.id.btn_feedback_cancel);
		mBtnSubmit = (Button) rootView.findViewById(R.id.btn_feedback_submit);
		mEtContent = (EditText) rootView.findViewById(R.id.et_feedback);
		mBtnCancel.setOnClickListener(mOnClickListener);
		mBtnSubmit.setOnClickListener(mOnClickListener);
		return rootView;
	}

	@Override
	public void onResume() {
		activityParent.btnTitleBarAdd.setVisibility(View.GONE);
		activityParent.btnTitleBarList.setVisibility(View.VISIBLE);
		activityParent.btnTitleBarBack.setVisibility(View.GONE);
		activityParent.tvTitleBarTitle.setText(getString(R.string.title));
		super.onResume();
	}

	private void sendFeedback(String comment) {
		AsyncTask<String, Integer, Response> sendFeedbackTask = new AsyncTask<String, Integer, Response>() {

			@Override
			protected void onPreExecute() {
				if (mProgress == null) {
					mProgress = new ProgressDialog(getActivity());
				}
				mProgress.setTitle(R.string.processing);
				mProgress.setMessage(getString(R.string.process_login));
				mProgress.show();
			}

			@Override
			protected Response doInBackground(String... params) {
				FeedbackService service = new FeedbackService();
				try {
					return service.sendFeedback(ModelContext.getInstance()
							.getGuid(), params[0], null, null);
				} catch (NetException e) {
					return null;
				}
			}

			protected void onPostExecute(Response response) {
				mProgress.dismiss();
				activityParent.getFragmentManager().popBackStack();
			}

		};
		sendFeedbackTask.execute(new String[] { comment });
	}
}
