package com.engagemobile.vsfootball.fragment;

import java.io.InputStream;
import java.util.ArrayList;

import android.app.SearchManager;
import android.app.SearchableInfo;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.provider.ContactsContract.Contacts.Photo;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SearchView;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.MyContacts;
import com.engagemobile.vsfootball.view.adapter.ContactsAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class NewGameContactFragment extends VsFootballFragment {
	//	private Button mBtnCancel;
	//	private Button mBtnSubmit;
	//	private EditText mEditText;
	//	private OnClickListener mOnClickListener;
	ContentResolver resolver;
	Button button;
	private TextView mTvSlidBar;
	private static final String[] PHONES_PROJECTION = new String[] {
			Phone.DISPLAY_NAME, Phone.NUMBER, Photo.PHOTO_ID, Phone.CONTACT_ID };

	private static final int PHONES_DISPLAY_NAME_INDEX = 0;

	private static final int PHONES_NUMBER_INDEX = 1;

	private static final int PHONES_PHOTO_ID_INDEX = 2;

	private static final int PHONES_CONTACT_ID_INDEX = 3;
	//    private ArrayList<String> mContactsName = new ArrayList<String>();  
	//    private ArrayList<String> mContactsNumber = new ArrayList<String>();  
	//    private ArrayList<Bitmap> mContactsPhonto = new ArrayList<Bitmap>();  

	ListView mLvContact;
	private ArrayList<MyContacts> mListContacts = new ArrayList<MyContacts>();

	@Override
	public void onCreate(Bundle savedInstanceState) {
		//		mOnClickListener = new OnClickListener() {
		//			@Override
		//			public void onClick(View v) {
		//				if (v == mBtnCancel)
		//					activityParent.getFragmentManager().popBackStack();
		//				else if (v == mBtnSubmit)
		//					activityParent.getFragmentManager().popBackStack();
		//			}
		//		};
		super.onCreate(savedInstanceState);
		resolver = mContext.getContentResolver();
		resolver.query(MyContacts.CONTENT_URI,
				new String[] { MyContacts.NAME },
				null, null, null);
		insertContacts();
		getPhoneContacts();
	}

	private void insertContacts() {
		ContentValues values = new ContentValues();
		values.put(MyContacts.NAME, "zhangsan");
		resolver.insert(MyContacts.CONTENT_URI, values);
		values.clear();
		values.put(MyContacts.NAME, "lisia");
		resolver.insert(MyContacts.CONTENT_URI, values);
		values.clear();
		values.put(MyContacts.NAME, "wangwu");
		resolver.insert(MyContacts.CONTENT_URI, values);
		values.clear();
		values.put(MyContacts.NAME, "chenliua");
		resolver.insert(MyContacts.CONTENT_URI, values);
		values.clear();

	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater
				.inflate(R.layout.fragment_new_game_contact, null);
		SearchManager searchManager = (SearchManager) mContext
				.getSystemService(Context.SEARCH_SERVICE);
		SearchView searchView = (SearchView) rootView
				.findViewById(R.id.searchview);
		mLvContact = (ListView) rootView
				.findViewById(R.id.lv_contact);
		mTvSlidBar = (TextView) rootView
				.findViewById(R.id.tv_sidebar_text);
		mLvContact.setAdapter(new ContactsAdapter(mContext, mListContacts));
		SearchableInfo info = searchManager.getSearchableInfo(activityParent
				.getComponentName());
		searchView.setSearchableInfo(info);
		searchView.setIconifiedByDefault(false);
		return rootView;
	}

	private void getPhoneContacts() {
		ContentResolver resolver = mContext.getContentResolver();

		Cursor phoneCursor = resolver.query(Phone.CONTENT_URI,
				PHONES_PROJECTION, null, null, null);

		if (phoneCursor != null) {
			while (phoneCursor.moveToNext()) {

				String phoneNumber = phoneCursor.getString(PHONES_NUMBER_INDEX);
				if (TextUtils.isEmpty(phoneNumber))
					continue;

				String contactName = phoneCursor
						.getString(PHONES_DISPLAY_NAME_INDEX);

				Long contactid = phoneCursor.getLong(PHONES_CONTACT_ID_INDEX);

				Long photoid = phoneCursor.getLong(PHONES_PHOTO_ID_INDEX);

				Bitmap contactPhoto = null;

				if (photoid > 0) {
					Uri uri = ContentUris.withAppendedId(
							ContactsContract.Contacts.CONTENT_URI, contactid);
					InputStream input = ContactsContract.Contacts
							.openContactPhotoInputStream(resolver, uri);
					contactPhoto = BitmapFactory.decodeStream(input);
				}
				//				else {
				//					contactPhoto = BitmapFactory.decodeResource(getResources(),
				//							R.drawable.contact_photo);
				//				}
				mListContacts.add(new MyContacts(null, contactName,
						phoneNumber));
				//				mContactsName.add(contactName);
				//				mContactsNumber.add(phoneNumber);
				//				mContactsPhonto.add(contactPhoto);
			}

			phoneCursor.close();
		}
	}

	@Override
	public void onResume() {
		activityParent.hideAd();
		activityParent.tvTitleBarTitle.setText("Contacts");
		super.onResume();
	}

	@Override
	public void onPause() {
		activityParent.showAd();
		super.onPause();
	}
}
