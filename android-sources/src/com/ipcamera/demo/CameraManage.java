package com.ipcamera.demo;

import vstc2.nativecaller.NativeCaller;
import com.ipcamera.demo.BridgeService.AddCameraInterface;
import com.ipcamera.demo.BridgeService.CallBackMessageInterface;
import com.ipcamera.demo.BridgeService.IpcamClientInterface;
import com.ipcamera.demo.BridgeService.PlayInterface;
import android.util.Log;
import java.nio.ByteBuffer;

import com.ipcamera.demo.utils.ContentCommon;
import com.rainystar.intelligenthome.NativeAPI;
import com.rainystar.intelligenthome.Communication;

public class CameraManage implements AddCameraInterface,
                                     IpcamClientInterface,
                                     CallBackMessageInterface,
                                     PlayInterface
{
    Communication callQt = new Communication();

    @Override
    public void callBackSearchResultData(int cameraType, String strMac,
                                    String strName, String strDeviceID, String strIpAddr, int port)
    {
        Log.d("callBackSearchResultData:",strMac+","+strName+","+strDeviceID+","+strIpAddr);
        NativeAPI.notice(strMac+","+strName+","+strDeviceID+","+strIpAddr);
    }


    @Override
    public void BSMsgNotifyData(String did, int type, int param)
    {
        Log.d("BSMsgNotifyData:",String.valueOf(type)+","+String.valueOf(param));

        String reStr="";

        //||type == ContentCommon.PPPP_MSG_TYPE_PPPP_MODE
        if(type == ContentCommon.PPPP_MSG_TYPE_PPPP_STATUS){

            switch (param) {
                case ContentCommon.PPPP_STATUS_CONNECTING://0
                        reStr="正在连接。。。";
                        break;
                case ContentCommon.PPPP_STATUS_CONNECT_FAILED://3
                        reStr="连接失败。。。";
                        NativeCaller.StopPPPP(did);
                        break;
                case ContentCommon.PPPP_STATUS_DISCONNECT://4
                        reStr="断线了。。。";
                        break;
                case ContentCommon.PPPP_STATUS_INITIALING://1
                        reStr="已连接，正在初始化。。。";
                        break;
                case ContentCommon.PPPP_STATUS_INVALID_ID://5
                        reStr="ID无效";
                        break;
                case ContentCommon.PPPP_STATUS_ON_LINE://2 在线状态
                        reStr="连接完毕";
                        //摄像机在线之后读取摄像机类型

                        String cmd="get_status.cgi?loginuse=admin&loginpas=888888&user=admin&pwd=888888";
                        NativeCaller.TransferMessage(did, cmd, 1);
                        NativeCaller.PPPPGetSystemParams(did,
                                        ContentCommon.MSG_TYPE_GET_PARAMS);
                        NativeCaller.StartPPPPLivestream(did, 10, 1);//确保不能重复start
                        break;
                case ContentCommon.PPPP_STATUS_DEVICE_NOT_ON_LINE://6
                        reStr="设备不在线";
                        NativeCaller.StopPPPP(did);
                        break;
                case ContentCommon.PPPP_STATUS_CONNECT_TIMEOUT://7
                        reStr="连接超时";
                        NativeCaller.StopPPPP(did);
                        break;
                case ContentCommon.PPPP_STATUS_CONNECT_ERRER://8
                        reStr="密码错误";
                        NativeCaller.StopPPPP(did);
                        break;
                default:
                        reStr="未知状态";
                        break;
            }
        }else if(type == ContentCommon.PPPP_MSG_TYPE_PPPP_MODE){
            reStr = "网络环境太复杂，无法实现UDP穿墙";
            //NativeCaller.StopPPPP(did);
        }

        Log.d("BSMsgNotifyData:", reStr);
        NativeAPI.notice(reStr);
    }

    @Override
    public void BSSnapshotNotify(String did, byte[] bImage, int len)
    {
        Log.d("BSSnapshotNotify:", did+","+String.valueOf(len));
    }

    @Override
    public void callBackUserParams(String did, String user1, String pwd1,
                                    String user2, String pwd2, String user3, String pwd3)
    {
        Log.d("callBackUserParams:", did);
    }

    @Override
    public void CameraStatus(String did, int status)
    {
        Log.d("CameraStatus:", did+","+String.valueOf(status));
    }

    @Override
    public void CallBackGetStatus(String did, String resultPbuf, int cmd)
    {
        Log.d("CameraStatus:", did+","+resultPbuf+","+String.valueOf(cmd));
    }

    @Override
    public void callBackCameraParamNotify(String did, int resolution,
                                    int brightness, int contrast, int hue, int saturation, int flip)
    {
    }


    @Override
    public void callBaceVideoData(byte[] videobuf, int h264Data, int len,
                                    int width, int height)
    {
        try{
            byte[] rgb = new byte[width * height * 2];
            int temp = NativeCaller.YUV4202RGB565(videobuf, rgb, width, height);
            callQt.streamingVideo(rgb, width, height);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void callBackMessageNotify(String did, int msgType, int param)
    {
        Log.d("callBackMessageNotify:", String.valueOf(msgType)+","+String.valueOf(param));
    }

    @Override
    public void callBackAudioData(byte[] pcm, int len)
    {
    }

    @Override
    public void callBackH264Data(byte[] h264, int type, int size)
    {
        Log.d("", String.valueOf(type)+","+String.valueOf(size));
    }

}

