package com.example.hangmanpeersup;


import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.Toast;

import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

public class RegisterActivity extends Activity implements View.OnClickListener {
    private EditText UserNameEditTxt;
    private EditText EmailEditTxt;
    private EditText PasswordEditTxt, ConfirmPwdEditTxt;
    private RelativeLayout logoutLayout;
    private RelativeLayout loginLayout;
    private String UserName;
    private String Email;
    private String PassWord;
    private String ConfirmPassWord;
    private Intent i;
    private Context mContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_register);
        setUI();
        mContext = RegisterActivity.this;
    }

    private void setUI() {
        UserNameEditTxt = (EditText) findViewById(R.id.userNameTxt);
        EmailEditTxt = (EditText) findViewById(R.id.emailsText);
        PasswordEditTxt = (EditText) findViewById(R.id.pwdTxt);
        ConfirmPwdEditTxt = (EditText) findViewById(R.id.cpwdTxt);
        logoutLayout = (RelativeLayout) findViewById(R.id.logoutLayout);
        loginLayout = (RelativeLayout) findViewById(R.id.loginLayout);
        logoutLayout.setOnClickListener(this);
        loginLayout.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {

            case R.id.logoutLayout:
                if (!isNetworkAvailable()) {
                } else {
                    signUPFun();
                }
                break;
            case R.id.loginLayout:
                i = new Intent(RegisterActivity.this, LoginActivity.class);
                startActivity(i);
            default:
                break;
        }
    }

    private void signUPFun() {
        UserName = UserNameEditTxt.getText().toString();
        PassWord = PasswordEditTxt.getText().toString();
        ConfirmPassWord = ConfirmPwdEditTxt.getText().toString();
        Email = EmailEditTxt.getText().toString();
        // Force user to fill up the form
        if (UserName.equals("") && PassWord.equals("") && ConfirmPassWord.equals("") && Email.equals("")) {
            Toast.makeText(getApplicationContext(),
                    "Please complete the sign up form",
                    Toast.LENGTH_LONG).show();

        } else {
            // Save new user data into Parse.com Data Storage
            if (PassWord.equals(ConfirmPassWord)) {
                ParseUser user = new ParseUser();
                user.setUsername(UserName);
                user.setPassword(PassWord);
                user.setEmail(Email);
                user.signUpInBackground(new SignUpCallback() {
                    @Override
                    public void done(ParseException e) {
                        if (e == null) {
                            // Show a simple Toast message upon successful registration
                            Toast.makeText(getApplicationContext(),
                                    "Successfully Signed up, please log in.",
                                    Toast.LENGTH_LONG).show();
                            Utils.ShowAlertDialLog(mContext, "Successfully Signed up");
                        } else {
                            Toast.makeText(getApplicationContext(),
                                    "Sign up Error", Toast.LENGTH_LONG)
                                    .show();
                        }
                    }
                });
            }
        }
    }

    private boolean isNetworkAvailable() {
        ConnectivityManager connectivityManager
                = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        return activeNetworkInfo != null && activeNetworkInfo.isConnected();
    }
}
