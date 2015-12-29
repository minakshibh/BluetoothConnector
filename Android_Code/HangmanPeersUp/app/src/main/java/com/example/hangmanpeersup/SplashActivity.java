package com.example.hangmanpeersup;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.Window;

import com.parse.ParseAnonymousUtils;
import com.parse.ParseUser;

public class SplashActivity extends Activity {

    Intent i;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.splashscreen);

        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {

                // Determine whether the current user is an anonymous user
                if (ParseAnonymousUtils.isLinked(ParseUser.getCurrentUser())) {
               // If user is anonymous, send the user to LoginSignupActivity.class
                    i = new Intent(SplashActivity.this, LoginActivity.class);
                    startActivity(i);
                    finish();
                } else {
                  // If current user is NOT anonymous user
                  // Get current user data from Parse.com
                    ParseUser currentUser = ParseUser.getCurrentUser();
                    if (currentUser != null) {
                   // Send logged in users to Welcome.class
                        i = new Intent(SplashActivity.this, LoginActivity.class);
                        startActivity(i);
                        finish();
                    } else {
                  // Send user to LoginSignupActivity.class
                        i = new Intent(SplashActivity.this, LoginActivity.class);
                        startActivity(i);
                        finish();
                    }
                }


            }
        }, 400);

    }

}
