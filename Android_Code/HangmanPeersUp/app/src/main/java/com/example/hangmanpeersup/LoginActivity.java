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

import com.parse.LogInCallback;
import com.parse.ParseUser;

public class LoginActivity extends Activity implements View.OnClickListener {
    private RelativeLayout LoginLayout;
    private RelativeLayout ForgetTextLayout;
    private RelativeLayout RegisterLayout;
    private Intent i;
    private String UserName;
    private String PwdTxt;
    private EditText userNameTxt;
    private EditText PasswwordTxt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_login);
        setUI();
    }

    private void setUI() {
        LoginLayout = (RelativeLayout) findViewById(R.id.logoutLayout);
        ForgetTextLayout = (RelativeLayout) findViewById(R.id.forgetTextLayout);
        RegisterLayout = (RelativeLayout)findViewById(R.id.RegisterLayout);
        userNameTxt = (EditText) findViewById(R.id.userNameTxt);
        PasswwordTxt = (EditText) findViewById(R.id.pwdTxt);
        LoginLayout.setOnClickListener(this);
        RegisterLayout.setOnClickListener(this);
        ForgetTextLayout.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {

            case R.id.logoutLayout:
                if (!isNetworkAvailable()) {
                } else {
                    loginFun();
                }
                break;

            case R.id.forgetTextLayout:
                i = new Intent(this, ForgetpasswordActivity.class);
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

    private void loginFun() {
        UserName = userNameTxt.getText().toString();
        PwdTxt = PasswwordTxt.getText().toString();

        // Send data to Parse.com for verification
        ParseUser.logInInBackground(UserName, PwdTxt,
                new LogInCallback() {
                    @Override
                    public void done(ParseUser parseUser, com.parse.ParseException e) {
                        if (parseUser != null) {
                            // If user exist and authenticated, send user to Welcome.class
                            Toast.makeText(getApplicationContext(), "Successfully Logged in", Toast.LENGTH_LONG).show();
                            i = new Intent(getApplicationContext(), fg.class);
                            startActivity(i);
                            finish();
                        } else {
                            Toast.makeText(getApplicationContext(), "No such user exist, please signup", Toast.LENGTH_LONG).show();
                        }
                    }
                });
    }

    private boolean isNetworkAvailable() {
        ConnectivityManager connectivityManager
                = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        return activeNetworkInfo != null && activeNetworkInfo.isConnected();
    }
}
