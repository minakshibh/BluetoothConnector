package com.example.hangmanpeersup.bluetoothchat;

import android.app.Activity;
import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.RelativeLayout;

import com.example.hangmanpeersup.R;

import java.util.ArrayList;

public class GameProgressActivity extends Activity {

    private RelativeLayout browseTxtLayout;
    private ProgressDialog mProgressDlg;
    private ArrayList<BluetoothDevice> mDeviceList = new ArrayList<BluetoothDevice>();
    private BluetoothAdapter mBluetoothAdapter;
    private RelativeLayout logoutLayout;
    private Intent i;
    private Context mContext;
    public static String engGame = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gameprogress);
        browseTxtLayout = (RelativeLayout) findViewById(R.id.browseTxtLayout);
        logoutLayout = (RelativeLayout) findViewById(R.id.logoutLayout);
        browseTxtLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                engGame ="EndGame";
             BluetoothChatFragment.sendMessage("EndGame");
                //openAlert(GameProgressActivity.this,"Your scrore and rank saved successfully");
            }
        });
    }

    @Override
    public void onPause() {
        super.onPause();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }




}