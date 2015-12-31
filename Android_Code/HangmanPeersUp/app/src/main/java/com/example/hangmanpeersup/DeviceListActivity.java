package com.example.hangmanpeersup;

import android.app.Activity;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;


public class DeviceListActivity extends Activity {
    private ListView mListView, mListView1;
    private DeviceListAdapter mAdapter;
    private PairedDeviceListAdapter mAdapteList;
    private ArrayList<BluetoothDevice> mDeviceList;
    private ArrayList<BluetoothDevice> mDeviceList1;
    private Intent i;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_paired_devices);

        mDeviceList = getIntent().getExtras().getParcelableArrayList("device.list");
        mDeviceList1 = getIntent().getExtras().getParcelableArrayList("device.list1");
        mListView = (ListView) findViewById(R.id.lv_paired);
        mListView1 = (ListView) findViewById(R.id.lv_unpaired);
        mAdapter = new DeviceListAdapter(this);
        mAdapteList = new PairedDeviceListAdapter(this);
        mListView1.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                i = new Intent(DeviceListActivity.this, SelectedGameActivity.class);
                i.putExtra("DeviceName", mDeviceList1.get(position).getName());
                startActivity(i);
            }
        });

        mListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                BluetoothDevice device = mDeviceList.get(position);

//                if (device.getBondState() == BluetoothDevice.BOND_BONDED) {
//                    unpairDevice(device);
//                } else {
//                    showToast("Pairing...");
//                    pairDevice(device);
//                }
                String paired = pairDevice(device);
                if (paired.equalsIgnoreCase("1")){
                    i = new Intent(DeviceListActivity.this, SelectedGameActivity.class);
                    i.putExtra("DeviceName", mDeviceList1.get(position).getName());
                    startActivity(i);

                }else{ }
            }
        });

// add elements to al, including duplicates
        HashSet hs = new HashSet();
        hs.addAll(mDeviceList);
        mDeviceList.clear();
        mDeviceList.addAll(hs);
        for (int i = 0; i < mDeviceList.size(); i++) {
            System.out.println(mDeviceList.get(i).getAddress());
        }
        List newList = new ArrayList(new LinkedHashSet(
                mDeviceList));
        Iterator it = newList.iterator();
        while (it.hasNext()) {
            System.out.println(it.next());
            //mDeviceList1.
        }
        //mAdapter.setData(mDeviceList);
        mAdapteList.setData(mDeviceList1);
//        mAdapter.setListener(new DeviceListAdapter.OnPairButtonClickListener() {
//            @Override
//            public void onPairButtonClick(int position) {
//                BluetoothDevice device = mDeviceList.get(position);
//
//                if (device.getBondState() == BluetoothDevice.BOND_BONDED) {
//                    unpairDevice(device);
//                } else {
//                    showToast("Pairing...");
//
//                    pairDevice(device);
//                }
//            }
//        });

        mListView.setAdapter(mAdapter);
        mListView1.setAdapter(mAdapteList);
        registerReceiver(mPairReceiver, new IntentFilter(BluetoothDevice.ACTION_BOND_STATE_CHANGED));
    }

    @Override
    public void onDestroy() {
        unregisterReceiver(mPairReceiver);

        super.onDestroy();
    }


    private void showToast(String message) {
        //Toast.makeText(getApplicationContext(), message, Toast.LENGTH_SHORT).show();
    }

    private String pairDevice(BluetoothDevice device) {
        try {
            Method method = device.getClass().getMethod("createBond", (Class[]) null);
            method.invoke(device, (Object[]) null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "1";
    }

    private void unpairDevice(BluetoothDevice device) {
        try {
            Method method = device.getClass().getMethod("removeBond", (Class[]) null);
            method.invoke(device, (Object[]) null);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private final BroadcastReceiver mPairReceiver = new BroadcastReceiver() {
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();

            if (BluetoothDevice.ACTION_BOND_STATE_CHANGED.equals(action)) {
                final int state = intent.getIntExtra(BluetoothDevice.EXTRA_BOND_STATE, BluetoothDevice.ERROR);
                final int prevState = intent.getIntExtra(BluetoothDevice.EXTRA_PREVIOUS_BOND_STATE, BluetoothDevice.ERROR);

                if (state == BluetoothDevice.BOND_BONDED && prevState == BluetoothDevice.BOND_BONDING) {
                    //showToast("Paired");
                } else if (state == BluetoothDevice.BOND_NONE && prevState == BluetoothDevice.BOND_BONDED) {
                    //showToast("Unpaired");
                }

                mAdapter.notifyDataSetChanged();
            }
        }
    };
}