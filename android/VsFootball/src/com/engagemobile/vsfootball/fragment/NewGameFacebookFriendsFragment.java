package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.database.Cursor;
import android.os.Bundle;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.MyContacts;
import com.engagemobile.vsfootball.view.SideBar;
import com.engagemobile.vsfootball.view.adapter.FacebookFriendsAdapter;
import com.facebook.FacebookRequestError;
import com.facebook.Request;
import com.facebook.RequestBatch;
import com.facebook.Response;
import com.facebook.Session;
import com.facebook.model.GraphUser;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class NewGameFacebookFriendsFragment extends VsFootballFragment {
	// private Button button;
	private TextView mTvSlidBar;
	private ListView mLvContact;
	private List<GraphUser> mListFriends = null;
	private List<GraphUser> mListSearch = null;
	private EditText mEtSearch;
	private ImageView mIvbtnClearSearch;
	private FacebookFriendsAdapter mAdapter;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		mListFriends = new ArrayList<GraphUser>();
		mListSearch = new ArrayList<GraphUser>();
		super.onCreate(savedInstanceState);
		// setContactList();
		getFriendsList();
		mAdapter = new FacebookFriendsAdapter(mContext, mListFriends);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater.inflate(R.layout.fragment_new_game_contact,
				null);
		mLvContact = (ListView) rootView.findViewById(R.id.lv_contact);
		mTvSlidBar = (TextView) rootView.findViewById(R.id.tv_sidebar_text);
		mLvContact.setAdapter(mAdapter);
		mEtSearch = (EditText) rootView.findViewById(R.id.edit_search);
		mIvbtnClearSearch = (ImageView) rootView
				.findViewById(R.id.btn_clean_search);
		SideBar.getInstance().setmDialogText(mTvSlidBar);
		SideBar.getInstance().setListView(mLvContact);
		mIvbtnClearSearch.setOnClickListener(new View.OnClickListener() {

			public void onClick(View v) {
				// TODO Auto-generated method stub
				mEtSearch.setText("");
				mIvbtnClearSearch.setVisibility(View.GONE);
				mAdapter.setmListContacts(mListFriends);
				mAdapter.isShowNum = false;
				mAdapter.notifyDataSetChanged();
				mLvContact.invalidate();
			}
		});

		mEtSearch.addTextChangedListener(new TextWatcher() {

			public void onTextChanged(CharSequence s, int start, int before,
					int count) {
				// TODO Auto-generated method stub
				if (s.length() != 0) {
					mIvbtnClearSearch.setVisibility(View.VISIBLE);
					getSearchUser(s.toString());
					mAdapter.setmListContacts(mListSearch);
					mAdapter.isShowNum = true;
				} else {
					mIvbtnClearSearch.setVisibility(View.GONE);
					mAdapter.setmListContacts(mListFriends);
					mAdapter.isShowNum = false;
				}
				mAdapter.notifyDataSetChanged();
				mLvContact.invalidate();
			}

			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
				// TODO Auto-generated method stub
			}

			public void afterTextChanged(Editable s) {
				// TODO Auto-generated method stub
			}
		});

		mLvContact.setOnScrollListener(new AbsListView.OnScrollListener() {

			public void onScrollStateChanged(AbsListView view, int scrollState) {
				// TODO Auto-generated method stub
				InputMethodManager inputMethodManager = (InputMethodManager) activityParent
						.getSystemService(Context.INPUT_METHOD_SERVICE);
				if (inputMethodManager.isActive()) {
					inputMethodManager.hideSoftInputFromWindow(
							mEtSearch.getWindowToken(),
							InputMethodManager.HIDE_NOT_ALWAYS);
				}
			}

			public void onScroll(AbsListView view, int firstVisibleItem,
					int visibleItemCount, int totalItemCount) {
				// TODO Auto-generated method stub

			}
		});
		mLvContact.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
				activityParent.opponnentName = ((MyContacts) ((FacebookFriendsAdapter) mLvContact
						.getAdapter()).getItem(position)).getName();
				new AlertDialog.Builder(mContext)
						.setTitle(
								getResources().getString(
										R.string.dialog_start_game_title))
						.setMessage(
								getResources()
										.getString(
												R.string.dialog_start_game_message,
												((MyContacts) ((FacebookFriendsAdapter) mLvContact
														.getAdapter())
														.getItem(position))
														.getName()))
						.setPositiveButton(
								getResources().getString(R.string.string_yes),
								new DialogInterface.OnClickListener() {

									@Override
									public void onClick(DialogInterface dialog,
											int which) {
										switchFragment(new NewGameOptionsFragment(), false);
									}
								})
						.setNegativeButton(
								getResources().getString(R.string.string_no),
								new DialogInterface.OnClickListener() {

									@Override
									public void onClick(DialogInterface dialog,
											int which) {
										// TODO Auto-generated method stub
										dialog.dismiss();
									}
								}).show();

			}
		});
		getFacebookFriends();
		return rootView;
	}

	private void getSearchUser(String condition) {
		mListSearch.clear();
		if (condition == null || condition.equals(""))
			return;
		String[] projection = { Phone.DISPLAY_NAME, Phone.NUMBER,
				Phone.PHOTO_ID, "sort_key" };
		String selection = Phone.DISPLAY_NAME + " like '%" + condition + "%'";
		Cursor cur = activityParent.getContentResolver().query(
				Phone.CONTENT_URI, projection, selection, null,
				Phone.DISPLAY_NAME + " COLLATE LOCALIZED ASC");
		cur.moveToFirst();
		while (cur.getCount() > cur.getPosition()) {
			List<String> phoneList = new ArrayList<String>();
			String number = cur.getString(cur.getColumnIndex(Phone.NUMBER));
			String name = cur.getString(cur.getColumnIndex(Phone.DISPLAY_NAME));
			String photo_id = cur.getString(cur.getColumnIndex(Phone.PHOTO_ID));
			String sort_key = cur.getString(cur.getColumnIndex("sort_key"));
			boolean show = true;
			String tempCondition = condition.replaceAll(" ", "").toLowerCase();
			String tempName = name.replaceAll(" ", "").toLowerCase();
			if (name != null && tempName.contains(tempCondition))
				show = true;
			else
				show = false;

			if (show) {
				phoneList.add(number);
				MyContacts person = new MyContacts(null, name, phoneList);
				// add2List(mListSearch, person);
			}
			cur.moveToNext();
		}
		cur.close();
	}

	/**
	 * get Contacts
	 */
	private void getFriendsList() {
		String[] projection = { Phone.DISPLAY_NAME, Phone.NUMBER,
				Phone.PHOTO_ID };
		Cursor cur = activityParent.getContentResolver().query(
				Phone.CONTENT_URI, projection, null, null,
				Phone.DISPLAY_NAME + " COLLATE LOCALIZED ASC");
		cur.moveToFirst();
		while (cur.getCount() > cur.getPosition()) {
			MyContacts person = new MyContacts();
			List<String> phone = new ArrayList<String>();
			String number = cur.getString(cur.getColumnIndex(Phone.NUMBER));
			String name = cur.getString(cur.getColumnIndex(Phone.DISPLAY_NAME));
			String photo_id = cur.getString(cur.getColumnIndex(Phone.PHOTO_ID));
			person.setName(name);
			phone.add(number);
			person.setListNumber(phone);
			// add2List(mListFriends, person);
			cur.moveToNext();
		}
		cur.close();
	}

	public void add2List(List<MyContacts> list, MyContacts person) {
		for (int i = 0; i < list.size(); ++i) {
			if (list.get(i).getName().equals(person.getName())) {
				for (int k = 0; k < person.getListNumber().size(); ++k)
					list.get(i).addNumber(person.getListNumber().get(k));
				return;
			}
		}
		list.add(person);
	}



	private void getFacebookFriends() {
		final Session session = Session.getActiveSession();
		if (session != null && session.isOpened()) {

			// Get the user's list of friends
			Request friendsRequest = Request.newMyFriendsRequest(session,
					new Request.GraphUserListCallback() {

						@Override
						public void onCompleted(final List<GraphUser> users,
								Response response) {
							FacebookRequestError error = response.getError();
							if (error != null) {
							} else if (session == Session.getActiveSession()) {
								// Set the friends attribute
								getActivity().runOnUiThread(new Runnable() {

									@Override
									public void run() {
										mAdapter.setmListContacts(users);
										mAdapter.notifyDataSetChanged();

									}
								});

							}
						}
					});
			Bundle params = new Bundle();
			params.putString("fields", "name,first_name,last_name");
			friendsRequest.setParameters(params);

			// Create a RequestBatch and add a callback once the batch of
			// requests completes
			RequestBatch requestBatch = new RequestBatch(friendsRequest);
			requestBatch.addCallback(new RequestBatch.Callback() {

				@Override
				public void onBatchCompleted(RequestBatch batch) {
				}
			});

			// Execute the batch of requests asynchronously
			requestBatch.executeAsync();
		}
	}
}
