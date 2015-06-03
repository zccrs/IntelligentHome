#include "video.h"
#include <QDebug>

CameraVideo::CameraVideo(QObject *parent):
    QObject(parent), m_videoSurface(NULL)
{
    video_format = QVideoSurfaceFormat(QSize(1280, 720), QVideoFrame::Format_RGB565);
    video_format.setFrameRate(60);
}

QAbstractVideoSurface *CameraVideo::videoSurface() const
{
    return m_videoSurface;
}

void CameraVideo::setVideoSurface(QAbstractVideoSurface *arg)
{
    if (m_videoSurface == arg)
        return;

    if(m_videoSurface){
        m_videoSurface->stop();
        disconnect(this, SLOT(presentFrame(QVideoFrame)));
    }

    m_videoSurface = arg;
    connect(this, &CameraVideo::present, this,
            &CameraVideo::presentFrame, Qt::QueuedConnection);

    arg->start(video_format);

    emit videoSurfaceChanged(arg);
}

void CameraVideo::setImageData(const char *byte, int width, int height, qreal frameRate)
{
    if(m_videoSurface){
        QVideoFrame frame = QVideoFrame(QImage((uchar*)byte, width, height, QImage::Format_RGB16));
        emit present(frame);
    }
}

void CameraVideo::presentFrame(const QVideoFrame &frame)
{
    m_videoSurface->present(frame);
}

