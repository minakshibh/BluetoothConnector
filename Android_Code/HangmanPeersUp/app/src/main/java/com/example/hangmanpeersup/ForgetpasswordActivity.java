package com.example.hangmanpeersup;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.Toast;

import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.RequestPasswordResetCallback;


public class ForgetpasswordActivity extends Activity implements View.OnClickListener {
    private EditText EmailEditText;
    private RelativeLayout RegisterUserLayout;
    private RelativeLayout LoginUserLauout;
    private RelativeLayout RecoverPasswordLayout;
    private String EmailStr;
    private Intent i;
    private Context mContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_forgetpassword);
        setUI();
        this.mContext = ForgetpasswordActivity.this;
    }

    private void setUI() {
        EmailEditText = (EditText) findViewById(R.id.EmailEditText);
        RegisterUserLayout = (RelativeLayout) findViewById(R.id.RegisterLayout);
        LoginUserLauout = (RelativeLayout) findViewById(R.id.loginLayout);
        RecoverPasswordLayout = (RelativeLayout) findViewById(R.id.RecoverPasswordLayout);
        RecoverPasswordLayout.setOnClickListener(this);
        LoginUserLauout.setOnClickListener(this);
        RegisterUserLayout.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.RecoverPasswordLayout:
                recoverPassword();
                break;

            case R.id.loginLayout:
                i = new Intent(this, LoginActivity.class);
                startActivity(i);
                break;

            case R.id.RegisterLayout:
                i = new Intent(this, RegisterActivity.class);
                startActivity(i);
                break;

            default:
                break;
        }
    }

    private void recoverPassword() {
        EmailStr = EmailEditText.getText().toString();
        if (EmailStr != null && !EmailStr.equalsIgnoreCase("")) {
            ParseUser.requestPasswordResetInBackground(EmailStr,
                    new RequestPasswordResetCallback() {
                        @Override
                        public void done(ParseException e) {
                            if (e == null) {
                                // Show a simple Toast message upon successful registration
                                Toast.makeText(getApplicationContext(),
                                        "Successfully Signed up, please log in.",
                                        Toast.LENGTH_LONG).show();
                                Utils.ShowAlertDialLog(mContext, e.getMessage());
                            } else {
                                Toast.makeText(getApplicationContext(),
                                        "Sign up Error", Toast.LENGTH_LONG)
                                        .show();

                            }
                        }
                    });
        }else{
            Utils.ShowAlertDialLog(mContext, "Sign up Error");
        }

    }
}
