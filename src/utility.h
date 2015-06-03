#ifndef UTILITY_H
#define UTILITY_H

#include <QObject>
#include <QVariant>
#include <QUrl>

class QSettings;
class DrawImage;
class CameraVideo;
class Utility : public QObject
{
    Q_OBJECT
public:
    static Utility* getInstance();
signals:
    //void playVideo(int width, int height);
public slots:
#ifdef Q_OS_ANDROID
    void showMessage(const QString& message) const;
    void showNotify(const QString &title, const QString& message) const;
    void showButtonNotify() const;
    void quit() const;
    void appToBack() const;
    void startCameraSearch() const;
    void stopCaceraSearch() const;
    void connectCamera(const QString& did,
                       const QString& user="admin",
                       const QString& pwd="888888") const;

    void test();
#endif
    void setValue(const QString &key, const QVariant &value);
    QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const;

    QString stringEncrypt(const QString &content, QString key);//加密任意字符串，中文请使用utf-8编码
    QString stringUncrypt(const QString &content_hex, QString key);//解密加密后的字符串

    QString appVersion() const;
    void setDrawImage(CameraVideo* canvas);
private:
    explicit Utility(QObject *parent = 0);
    ~Utility();
private:
    static Utility* me;
    QSettings *settings;
};

#endif // UTILITY_H
