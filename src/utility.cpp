#include "utility.h"
#include <QDebug>
#include <QSettings>
#include <QStandardPaths>
#include <QTimer>
#include <QGuiApplication>
#include "starencryption.h"
#include "video.h"

Utility* Utility::me = new Utility;
CameraVideo* draw_image = NULL;

#ifdef Q_OS_ANDROID

#include <QtAndroidExtras/QAndroidJniObject>
#include "com_rainystar_intelligenthome_Communication.h"

JNIEXPORT int JNICALL Java_com_rainystar_intelligenthome_Communication_callQt__I
  (JNIEnv *, jobject, jint code)
{
    qDebug()<<"Utility from java:"<<code;
    return 0;
}

JNIEXPORT int JNICALL Java_com_rainystar_intelligenthome_Communication_callQt__Ljava_lang_String_2
  (JNIEnv *env, jobject, jstring code)
{
    const char *str;
    str = env->GetStringUTFChars(code,NULL);
    qDebug()<<"Utility from java:"<<str;
    env->ReleaseStringUTFChars(code,str);
    return 0;
}

JNIEXPORT void JNICALL Java_com_rainystar_intelligenthome_Communication_streamingVideo
  (JNIEnv *env, jobject, jbyteArray byte, jint width, jint height)
{
    const char *data = (char*)env->GetByteArrayElements(byte, NULL);

    if(draw_image){
        draw_image->setImageData(data, width, height);
    }

    env->ReleaseByteArrayElements(byte, (jbyte*)data, 0);
}

#endif

Utility *Utility::getInstance()
{
    return me;
}

#ifdef Q_OS_ANDROID

void callVoidFun(const char *methodName)
{
    QAndroidJniObject::callStaticMethod<void>("com/rainystar/intelligenthome/NativeAPI",
                                              methodName,
                                              "()V");
}

void Utility::showMessage(const QString &message) const
{
    QAndroidJniObject javaNotification = QAndroidJniObject::fromString(message);
    QAndroidJniObject::callStaticMethod<void>("com/rainystar/intelligenthome/NativeAPI",
                                              "notice",
                                              "(Ljava/lang/String;)V",
                                              javaNotification.object<jstring>());
}

void Utility::showNotify(const QString &title, const QString &message) const
{
    QAndroidJniObject arg1 = QAndroidJniObject::fromString(title);
    QAndroidJniObject arg2 = QAndroidJniObject::fromString(message);
    QAndroidJniObject::callStaticMethod<void>("com/rainystar/intelligenthome/NativeAPI",
                                              "notify",
                                              "(Ljava/lang/String;Ljava/lang/String;)V",
                                              arg1.object<jstring>(),
                                              arg2.object<jstring>());
}

void Utility::showButtonNotify() const
{
    callVoidFun("showButtonNotify");
}

void Utility::quit() const
{
    callVoidFun("quit");
}

void Utility::appToBack() const
{
    callVoidFun("moveTaskToBack");
}

void Utility::startCameraSearch() const
{
    callVoidFun("startCameraSearch");
    QTimer::singleShot(200, this, SLOT(stopCaceraSearch()));
    //200ms后停止搜索
}

void Utility::stopCaceraSearch() const
{
    callVoidFun("stopCaceraSearch");
}

void Utility::connectCamera(const QString &did, const QString &user, const QString &pwd) const
{
    QAndroidJniObject arg1 = QAndroidJniObject::fromString(did);
    QAndroidJniObject arg2 = QAndroidJniObject::fromString(user);
    QAndroidJniObject arg3 = QAndroidJniObject::fromString(pwd);
    QAndroidJniObject::callStaticMethod<void>("com/rainystar/intelligenthome/NativeAPI",
                                              "connectCamera",
                                              "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V",
                                              arg1.object<jstring>(),
                                              arg2.object<jstring>(),
                                              arg3.object<jstring>());
}

void Utility::test()
{
    callVoidFun("test");
}

#endif

void Utility::setValue(const QString &key, const QVariant &value)
{
    settings->setValue(key, value);
    settings->sync();
}

QVariant Utility::value(const QString &key, const QVariant &defaultValue) const
{
    return settings->value(key, defaultValue);
}

QString Utility::stringEncrypt(const QString &content, QString key)
{
    StarEncryption temp;
    return temp.stringEncrypt(content, key);
}

QString Utility::stringUncrypt(const QString &content_hex, QString key)
{
    StarEncryption temp;
    return temp.stringUncrypt(content_hex, key);
}

QString Utility::appVersion() const
{
    return qApp->applicationVersion();
}

void Utility::setDrawImage(CameraVideo *canvas)
{
    draw_image = canvas;
}

Utility::Utility(QObject *parent) : QObject(parent)
{
    settings = new QSettings(
                QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation)
                +"/.IntelligentHome/.settings/IntelligentHome.conf",
                QSettings::NativeFormat, this);
}

Utility::~Utility()
{
}
