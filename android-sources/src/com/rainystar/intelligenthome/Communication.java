package com.rainystar.intelligenthome;

public class Communication {
    public native int callQt(int code);
    public native int callQt(String code);
    public native void streamingVideo(byte[] videobuf, int width, int height);
}

