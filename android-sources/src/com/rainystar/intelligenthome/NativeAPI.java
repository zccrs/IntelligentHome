package com.rainystar.intelligenthome;

import android.widget.Toast;
import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.util.Log;
import android.widget.RemoteViews;
import android.view.View;
import android.content.Intent;
import android.app.PendingIntent;
import android.widget.Button;
import android.app.ActivityManager;
import java.util.List;
import android.app.ActivityManager.RunningServiceInfo;

import com.ipcamera.demo.*;
import vstc2.nativecaller.NativeCaller;

public class NativeAPI extends org.qtproject.qt5.android.bindings.QtActivity
{
    private static NotificationManager m_notificationManager1, m_notificationManager2;
    private static Notification.Builder m_builder;
    private static NativeAPI m_instance;
    private static Intent intent1, intent2, intent3, intent4;
    private static CameraManage m_cameraManage;

    public NativeAPI()
    {
        m_instance = this;

        if(m_cameraManage == null){
            m_cameraManage = new CameraManage();
            BridgeService.setAddCameraInterface(m_cameraManage);
            new Thread(new SearchThread()).start();
            //updateListHandler.postDelayed(updateThread, SEARCH_TIME);
        }

    }

    private class SearchThread implements Runnable {
                    @Override
                    public void run() {
                            Log.d("tag", "startSearch");
                            NativeCaller.StartSearch();
                    }
            }

    public static void notice(String s)
    {
        notice(s, m_instance);
    }

    public static void notice(final String s, final Context activity)
    {
        m_instance.runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Toast.makeText(activity, s, Toast.LENGTH_SHORT).show();
                            }
                        });
    }

    public static void notify(String title, String s)
    {
        if (m_notificationManager1 == null) {
            m_notificationManager1 = (NotificationManager)m_instance.getSystemService(Context.NOTIFICATION_SERVICE);
            m_builder = new Notification.Builder(m_instance);
            m_builder.setSmallIcon(R.drawable.icon);
            m_builder.setContentTitle(title);
            //m_builder.setOngoing(true);
            Notification notification = m_builder.build();
            //notification.flags = Notification.FLAG_AUTO_CANCEL;
        }

        m_builder.setContentText(s);
        m_notificationManager1.notify(111, m_builder.build());
    }

    public static void showButtonNotify()
    {
        if (m_notificationManager2 == null) {
            m_notificationManager2 = (NotificationManager)m_instance.getSystemService(Context.NOTIFICATION_SERVICE);
            m_builder = new Notification.Builder(m_instance);
            m_builder.setSmallIcon(R.drawable.icon);
            m_builder.setOngoing(true);
        }
        RemoteViews mRemoteViews = null;
        try{
            mRemoteViews = new RemoteViews(m_instance.getPackageName(), R.layout.notify);
        }catch(Exception e){
            Log.d(":", "new RemoteViews error!");
            e.printStackTrace();
        }
        if(mRemoteViews!=null){
            m_builder.setContent(mRemoteViews);
            intent1 = new Intent(m_instance, BackService.class);
            intent1.putExtra("text", "1");
            intent2 = new Intent(m_instance, BackService.class);
            intent2.putExtra("text", "2");
            intent3 = new Intent(m_instance, BackService.class);
            intent3.putExtra("text", "3");
            intent4 = new Intent(m_instance, BackService.class);
            intent4.putExtra("text", "4");
            PendingIntent pendingintent1 = PendingIntent.getService(m_instance, 1, intent1, PendingIntent.FLAG_UPDATE_CURRENT);
            PendingIntent pendingintent2 = PendingIntent.getService(m_instance, 2, intent2, PendingIntent.FLAG_UPDATE_CURRENT);
            PendingIntent pendingintent3 = PendingIntent.getService(m_instance, 3, intent3, PendingIntent.FLAG_UPDATE_CURRENT);
            PendingIntent pendingintent4 = PendingIntent.getService(m_instance, 4, intent4, PendingIntent.FLAG_UPDATE_CURRENT);
            mRemoteViews.setOnClickPendingIntent(R.id.btn1, pendingintent1);
            mRemoteViews.setOnClickPendingIntent(R.id.btn2, pendingintent2);
            mRemoteViews.setOnClickPendingIntent(R.id.btn3, pendingintent3);
            mRemoteViews.setOnClickPendingIntent(R.id.btn4, pendingintent4);
            m_notificationManager2.notify(888, m_builder.build());
        }else{
            Log.d(":", "RemoteViews is Null!");
        }
    }

    public static void quit()
    {
        m_instance.stopService(intent1);
        m_instance.stopService(intent2);
        m_instance.stopService(intent3);
        m_instance.stopService(intent4);
        m_notificationManager2.cancelAll();
    }

}
