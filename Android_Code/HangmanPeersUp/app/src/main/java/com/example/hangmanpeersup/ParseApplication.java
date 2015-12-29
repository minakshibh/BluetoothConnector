package com.example.hangmanpeersup;

import android.app.Application;

import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseUser;

public class ParseApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        // Add your initialization code here
        //Parse.initialize(this, TWXYl61DYYIEOtCOiVQLoK6KVuXQLcn31Fx173Bx", "o61XyJ33FxWT7Jp7COrQAH86k0WviqHmQ76Z1MVX");
        Parse.initialize(this, getResources().getString(R.string.appId), getResources().getString(R.string.clientId));
        ParseUser.enableAutomaticUser();
        ParseACL defaultACL = new ParseACL();

        // If you would like all objects to be private by default, remove this
        // line.
        defaultACL.setPublicReadAccess(true);

        ParseACL.setDefaultACL(defaultACL, true);
    }

}