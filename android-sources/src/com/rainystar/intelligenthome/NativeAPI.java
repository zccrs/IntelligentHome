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
import android.app.ActivityManager.RunningServiceInfo;
import android.os.Bundle;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONArray;
import org.json.JSONTokener;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import com.iflytek.cloud.SpeechUtility;
import com.iflytek.cloud.SpeechConstant;
import com.iflytek.cloud.RecognizerListener;
import com.iflytek.cloud.SpeechRecognizer;
import com.iflytek.cloud.SpeechError;
import com.iflytek.cloud.RecognizerResult;
import com.iflytek.cloud.ui.RecognizerDialog;
import com.iflytek.cloud.ui.RecognizerDialogListener;
import com.iflytek.cloud.InitListener;
import com.iflytek.cloud.ErrorCode;

import com.ipcamera.demo.*;
import vstc2.nativecaller.NativeCaller;

public class NativeAPI extends org.qtproject.qt5.android.bindings.QtActivity
{
    private static NotificationManager m_notificationManager1, m_notificationManager2;
    private static Notification.Builder m_builder;
    private static NativeAPI m_instance;
    private static Intent intent1, intent2, intent3, intent4, intent5;
    private static CameraManage m_cameraManage;
    private static String TAG = NativeAPI.class.getSimpleName();
    private HashMap<String, String> mIatResults = new LinkedHashMap<String, String>();
    // 语音听写对象
    private SpeechRecognizer mIat;
    // 语音听写UI
    private RecognizerDialog mIatDialog;
    private String speechResult;//储存识别后的讲话结果

    public NativeAPI()
    {
        m_instance = this;

        if(m_cameraManage == null){
            m_cameraManage = new CameraManage();
            BridgeService.setAddCameraInterface(m_cameraManage);
            BridgeService.setIpcamClientInterface(m_cameraManage);
            BridgeService.setPlayInterface(m_cameraManage);

            final NativeAPI native_api = this;
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    SpeechUtility.createUtility(NativeAPI.this, SpeechConstant.APPID +"=你申请的appid");

                    intent5 = new Intent();
                    intent5.setClass(native_api, BridgeService.class);
                    native_api.startService(intent5);

                    mIat = SpeechRecognizer.createRecognizer(NativeAPI.this, mInitListener);
                    // 初始化听写Dialog，如果只使用有UI听写功能，无需创建SpeechRecognizer
                    // 使用UI听写功能，请根据sdk文件目录下的notice.txt,放置布局文件和图片资源

                    mIatDialog = new RecognizerDialog(NativeAPI.this, mInitListener);
                    NativeCaller.PPPPInitialOther("ADCBBFAOPPJAHGJGBBGLFLAGDBJJHNJGGMBFBKHIBBNKOKLDHOBHCBOEHOKJJJKJBPMFLGCPPJMJAPDOIPNL");
                }
            });
        }
    }

    private InitListener mInitListener = new InitListener() {
                    @Override
                    public void onInit(int code) {
                            Log.d(TAG, "SpeechRecognizer init() code = " + code);
                            if (code != ErrorCode.SUCCESS) {
                                    notice("初始化失败，错误码：" + code);
                            }
                    }
            };
    private RecognizerDialogListener recognizerDialogListener = new RecognizerDialogListener() {
        @Override
        public void onResult(RecognizerResult results, boolean isLast) {
            Log.d(TAG, "解析录音。。。");

            printResult(results);

            if(isLast){
                Log.d(TAG, speechResult);
                notice(speechResult);
            }

        }

                            /**
                             * 识别回调错误.
                             */
        @Override
        public void onError(SpeechError error) {
            notice(error.getPlainDescription(true));
        }
    };

    /**
    * 听写监听器。
    */
   private RecognizerListener recognizerListener = new RecognizerListener() {

           @Override
           public void onBeginOfSpeech() {
                   notice("开始说话");
           }

           @Override
           public void onError(SpeechError error) {
                   // Tips：
                   // 错误码：10118(您没有说话)，可能是录音机权限被禁，需要提示用户打开应用的录音权限。
                   // 如果使用本地功能（语音+）需要提示用户开启语音+的录音权限。
                   notice(error.getPlainDescription(true));
           }

           @Override
           public void onEndOfSpeech() {
                   notice("结束说话");
           }

           @Override
           public void onResult(RecognizerResult results, boolean isLast) {
                   Log.d(TAG, results.getResultString());

                   if (isLast) {
                           // TODO 最后的结果
                   }
           }

           @Override
           public void onVolumeChanged(int volume) {
                   notice("当前正在说话，音量大小：" + volume);
           }

           @Override
           public void onEvent(int eventType, int arg1, int arg2, Bundle obj) {
           }
   };

    private String parseIatResult(String json) {
                    StringBuffer ret = new StringBuffer();
                    try {
                            JSONTokener tokener = new JSONTokener(json);
                            JSONObject joResult = new JSONObject(tokener);

                            JSONArray words = joResult.getJSONArray("ws");
                            for (int i = 0; i < words.length(); i++) {
                                    // 转写结果词，默认使用第一个结果
                                    JSONArray items = words.getJSONObject(i).getJSONArray("cw");
                                    JSONObject obj = items.getJSONObject(0);
                                    ret.append(obj.getString("w"));
    //				如果需要多候选结果，解析数组其他字段
    //				for(int j = 0; j < items.length(); j++)
    //				{
    //					JSONObject obj = items.getJSONObject(j);
    //					ret.append(obj.getString("w"));
    //				}
                            }
                    } catch (Exception e) {
                            e.printStackTrace();
                    }
                    return ret.toString();
            }

    private void printResult(RecognizerResult results) {
                    String text = parseIatResult(results.getResultString());

                    String sn = null;
                    // 读取json结果中的sn字段
                    try {
                            JSONObject resultJson = new JSONObject(results.getResultString());
                            sn = resultJson.optString("sn");
                    } catch (JSONException e) {
                            e.printStackTrace();
                    }

                    m_instance.mIatResults.put(sn, text);

                    StringBuffer resultBuffer = new StringBuffer();
                    for (String key : mIatResults.keySet()) {
                            resultBuffer.append(mIatResults.get(key));
                    }

                    speechResult = resultBuffer.toString();
            }

    private void setParam() {
                    // 清空参数
        mIat.setParameter(SpeechConstant.PARAMS, null);

                    // 设置听写引擎
        mIat.setParameter(SpeechConstant.ENGINE_TYPE, SpeechConstant.TYPE_CLOUD);
                    // 设置返回结果格式
        mIat.setParameter(SpeechConstant.RESULT_TYPE, "json");

                    //if (lag.equals("en_us")) {
                            // 设置语言
                            //mIat.setParameter(SpeechConstant.LANGUAGE, "en_us");
                   // } else {
                            // 设置语言
        mIat.setParameter(SpeechConstant.LANGUAGE, "zh_cn");
                            // 设置语言区域
        mIat.setParameter(SpeechConstant.ACCENT, "mandarin");
                    //}

                    // 设置语音前端点:静音超时时间，即用户多长时间不说话则当做超时处理
        mIat.setParameter(SpeechConstant.VAD_BOS, "4000");

                    // 设置语音后端点:后端点静音检测时间，即用户停止说话多长时间内即认为不再输入， 自动停止录音
        mIat.setParameter(SpeechConstant.VAD_EOS, "1000");

                    // 设置标点符号,设置为"0"返回结果无标点,设置为"1"返回结果有标点
        mIat.setParameter(SpeechConstant.ASR_PTT, "1");

                    // 设置音频保存路径，保存音频格式仅为pcm，设置路径为sd卡请注意WRITE_EXTERNAL_STORAGE权限
        mIat.setParameter(SpeechConstant.ASR_AUDIO_PATH, "/mnt/sdcard/iflytek/wavaudio.pcm");

                    // 设置听写结果是否结果动态修正，为“1”则在听写过程中动态递增地返回结果，否则只在听写结束之后返回最终结果
                    // 注：该参数暂时只对在线听写有效
        mIat.setParameter(SpeechConstant.ASR_DWA, "0");
    }

    public static void listenSpeech()
    {
        m_instance.mIatResults.clear();
        m_instance.setParam();

        m_instance.runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                m_instance.mIatDialog.setListener(m_instance.recognizerDialogListener);
                                m_instance.mIatDialog.show();
                            }
                        });
       // m_instance.mIat.startListening(m_instance.recognizerListener);
        notice("请开始讲话");
    }


    public static void moveTaskToBack()
    {
        m_instance.moveTaskToBack(true);
    }

    public static void startCameraSearch()
    {
        new Thread(new Runnable() {
            @Override
            public void run() {
                Log.d(TAG, "startSearch");
                NativeCaller.StartSearch();
            }
        }).start();
    }

    public static void stopCaceraSearch()
    {
        NativeCaller.StopSearch();
    }

    public static void connectCamera(final String did, final String user, final String pwd)
    {
        NativeCaller.Init();
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    Thread.sleep(100);
                    int result = NativeCaller.StartPPPP(did, user, pwd,1,"");
                    Log.d("connectCamera:", String.valueOf(result));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    public static void disconnectCamera(String did)
    {
        int result = NativeCaller.StopPPPP(did);

        Log.d("disconnectCamera", String.valueOf(result));
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
        m_instance.stopService(intent5);
    }

}
