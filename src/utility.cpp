#include "utility.h"
#include <QDebug>
#include <QSettings>
#include <QStandardPaths>
#include <QGuiApplication>
#include "starencryption.h"

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
#endif

Utility* Utility::me = new Utility;

Utility *Utility::getInstance()
{
    return me;
}
#ifdef Q_OS_ANDROID
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
    QAndroidJniObject::callStaticMethod<void>("com/rainystar/intelligenthome/NativeAPI",
                                              "showButtonNotify",
                                              "()V");
}

void Utility::quit() const
{
    QAndroidJniObject::callStaticMethod<void>("com/rainystar/intelligenthome/NativeAPI",
                                              "quit",
                                              "()V");
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
