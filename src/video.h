#ifndef VIDEO_H
#define VIDEO_H

#include <QAbstractVideoSurface>
#include <QVideoSurfaceFormat>

class CameraVideo : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface NOTIFY videoSurfaceChanged)

public:
    CameraVideo(QObject* parent = 0);
    QAbstractVideoSurface* videoSurface() const;

public slots:
    void setVideoSurface(QAbstractVideoSurface* arg);
    void setImageData(const char* byte, int width, int height, qreal frameRate = 24);
signals:
    void videoSurfaceChanged(QAbstractVideoSurface* arg);
    void present(const QVideoFrame &frame);
private:
    QAbstractVideoSurface* m_videoSurface;

    QVideoSurfaceFormat video_format;
private slots:
    void presentFrame(const QVideoFrame &frame);
};

#endif // VIDEO_H
