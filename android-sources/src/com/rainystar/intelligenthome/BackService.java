package com.rainystar.intelligenthome;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;
import android.content.BroadcastReceiver;
import android.widget.Toast;


public class BackService extends Service
{
    private static String TAG = "BackService:";

    @Override
    public IBinder onBind(Intent arg0) {
        Log.d(TAG, "onBind");
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public void onCreate() {
        // TODO Auto-generated method stub
        super.onCreate();
        Log.d(TAG, "onCreate");
    }

    @Override
    public void onDestroy() {
        // TODO Auto-generated method stub
        super.onDestroy();
        Log.d(TAG, "onDestroy");
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.d(TAG, "onStartCommand");
        // TODO Auto-generated method stub
        try{
            System.loadLibrary("IntelligentHome");
            Communication test = new Communication();
            Toast.makeText(this, "clicked button "+intent.getStringExtra("text")+String.valueOf(test.callQt("fdsaf")), Toast.LENGTH_SHORT).show();
        }catch(Exception e){
            e.printStackTrace();
        }

        return super.onStartCommand(intent, flags, startId);
    }

}

