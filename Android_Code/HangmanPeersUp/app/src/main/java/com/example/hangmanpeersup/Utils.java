package com.example.hangmanpeersup;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;

public class Utils {

    public static void ShowAlertDialLog(Context mContext, String message) {

        AlertDialog alertDialog = new AlertDialog.Builder(mContext).create();
        alertDialog.setTitle("Alert");
        alertDialog.setMessage(message);
        alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "OK",
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                }
        );
        alertDialog.show();
    }

    public static void openAlert(Context mContext, String message) {

        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(mContext);


        alertDialogBuilder.setTitle(" decision");

        alertDialogBuilder.setMessage("Are you sure?");

        // set positive button: Yes message

        alertDialogBuilder.setPositiveButton("Yes", new DialogInterface.OnClickListener() {

            public void onClick(DialogInterface dialog, int id) {

                // go to a new activity of the app
//
//                Intent positveActivity = new Intent(mContext,
//
//                        PositiveActivity.class);
//
//                startActivity(positveActivity);

            }

        });

        // set negative button: No message

        alertDialogBuilder.setNegativeButton("No", new DialogInterface.OnClickListener() {

            public void onClick(DialogInterface dialog, int id) {

                // cancel the alert box and put a Toast to the user

                dialog.cancel();

            }

        });

        AlertDialog alertDialog = alertDialogBuilder.create();

        // show alert

        alertDialog.show();
    }

}


