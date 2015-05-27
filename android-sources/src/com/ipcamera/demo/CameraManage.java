package com.ipcamera.demo;

import vstc2.nativecaller.NativeCaller;
import com.ipcamera.demo.BridgeService.AddCameraInterface;
import com.ipcamera.demo.BridgeService.CallBackMessageInterface;
import com.ipcamera.demo.BridgeService.IpcamClientInterface;
import android.util.Log;

public class CameraManage implements AddCameraInterface,IpcamClientInterface,CallBackMessageInterface
{
    @Override
    public void callBackSearchResultData(int cameraType, String strMac,
                                    String strName, String strDeviceID, String strIpAddr, int port)
    {
        Log.d("callBackSearchResultData:",strMac+","+strName+","+strDeviceID+","+strIpAddr);
    }


    @Override
    public void BSMsgNotifyData(String did, int type, int param)
    {
    }

    @Override
    public void BSSnapshotNotify(String did, byte[] bImage, int len)
    {
    }

    @Override
    public void callBackUserParams(String did, String user1, String pwd1,
                                    String user2, String pwd2, String user3, String pwd3)
    {
    }

    @Override
    public void CameraStatus(String did, int status)
    {
    }

    @Override
    public void CallBackGetStatus(String did, String resultPbuf, int cmd)
    {
    }

}

