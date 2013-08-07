package com.engagemobile.vsfootball.database;

import java.util.HashMap;

import com.engagemobile.vsfootball.bean.MyContacts;

import android.app.SearchManager;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.DatabaseErrorHandler;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.sqlite.SQLiteQueryBuilder;
import android.provider.BaseColumns;
import android.util.Log;

/*
 * database help
 * 
 * */
public class SearchDatabase extends SQLiteOpenHelper {
	 String project[]={MyContacts.NAME};
	 public  String[] columns = new String[] {
	           SearchManager.SUGGEST_COLUMN_TEXT_1,
	           BaseColumns._ID};  
	    
	   private static final HashMap<String,String> mColumnMap = buildColumnMap();
	    /**
	     * Builds a map for all columns that may be requested, which will be given to the 
	     * SQLiteQueryBuilder. This is a good way to define aliases for column names, but must include 
	     * all columns, even if the value is the key. This allows the ContentProvider to request
	     * columns w/o the need to know real column names and create the alias itself.
	     */
	    private static HashMap<String,String> buildColumnMap() {
	        HashMap<String,String> map = new HashMap<String,String>();
	        map.put(SearchManager.SUGGEST_COLUMN_TEXT_1,"name as "+SearchManager.SUGGEST_COLUMN_TEXT_1);
	        map.put(BaseColumns._ID, "rowid AS " +
	                BaseColumns._ID);
	        map.put(SearchManager.SUGGEST_COLUMN_INTENT_DATA_ID, "rowid AS " +
	                SearchManager.SUGGEST_COLUMN_INTENT_DATA_ID);
	        map.put(SearchManager.SUGGEST_COLUMN_SHORTCUT_ID, "rowid AS " +
	                SearchManager.SUGGEST_COLUMN_SHORTCUT_ID);
	        return map;
	    }
	public SearchDatabase(Context context,String name){
		this(context, name, null, 1);
	}
	public SearchDatabase(Context context, String name, CursorFactory factory,
			int version) {
		super(context, name, factory, version);
		// TODO Auto-generated constructor stub
	
	}



	@Override
	public void onCreate(SQLiteDatabase db) {
		// TODO Auto-generated method stub
		db.execSQL("Create table "+MyContacts.TABLENAME+"("+MyContacts.ID+" integer primary key,"+MyContacts.NAME+" TEXT"+")");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		// TODO Auto-generated method stub
		 db.execSQL("DROP TABLE IF EXISTS " + MyContacts.DBNAME);
         onCreate(db);
	}
	
	public void insertContacts(ContentValues values){
		 SQLiteDatabase db=getWritableDatabase();
		db.insert(MyContacts.TABLENAME, null, values);
	}
	public Cursor queryContacts(String str){
		SQLiteQueryBuilder builder=new SQLiteQueryBuilder();
		builder.setTables(MyContacts.TABLENAME);
		builder.setProjectionMap(mColumnMap);	
		SQLiteDatabase db=getReadableDatabase();
		
		return builder.query(db, columns, MyContacts.NAME+" like "+"'%"+str+"%'", null, null, null,null);	
	}

}
