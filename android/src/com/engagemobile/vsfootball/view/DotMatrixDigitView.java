package com.engagemobile.vsfootball.view;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.engagemobile.vsfootball.R;

public class DotMatrixDigitView extends LinearLayout {

	private ImageView mIvDecade;
	private ImageView mIvUnits;

	public DotMatrixDigitView(Context context) {
		super(context);
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		inflater.inflate(R.layout.view_dot_matrix_digit, this);
		mIvDecade = (ImageView) findViewById(R.id.iv_tens_digit);
		mIvUnits = (ImageView) findViewById(R.id.iv_units_digit);
	}

	public DotMatrixDigitView(Context context, AttributeSet attrs) {
		super(context, attrs);
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		inflater.inflate(R.layout.view_dot_matrix_digit, this);
		mIvDecade = (ImageView) findViewById(R.id.iv_tens_digit);
		mIvUnits = (ImageView) findViewById(R.id.iv_units_digit);
	}

	public void setDigit(int digit) {
		if (digit >= 0 && digit < 100) {
			int decade = digit / 10;
			int unit = digit % 10;
			mIvDecade.setImageResource(getDigitImage(decade));
			mIvUnits.setImageResource(getDigitImage(unit));
			invalidate();
			requestLayout();
		} else {

		}
	}

	private int getDigitImage(int num) {
		switch (num) {
		case 1:
			return R.drawable.digit_1;
		case 2:
			return R.drawable.digit_2;
		case 3:
			return R.drawable.digit_3;
		case 4:
			return R.drawable.digit_4;
		case 5:
			return R.drawable.digit_5;
		case 6:
			return R.drawable.digit_6;
		case 7:
			return R.drawable.digit_7;
		case 8:
			return R.drawable.digit_8;
		case 9:
			return R.drawable.digit_9;
		case 0:
			return R.drawable.digit_0;
		default:
			return R.drawable.digit_blank;
		}
	}
}
