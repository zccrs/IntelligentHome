#ifndef UTILITY_H
#define UTILITY_H

#include <QObject>
#include <QVariant>

class QSettings;
class Utility : public QObject
{
    Q_OBJECT
public:
    static Utility* getInstance();
signals:
#ifdef Q_OS_ANDROID
public slots:
    void showMessage(const QString& message) const;
    void showNotify(const QString &title, const QString& message) const;
    void showButtonNotify() const;
    void quit() const;
#endif
    void setValue(const QString &key, const QVariant &value);
    QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const;

    QString stringEncrypt(const QString &content, QString key);//加密任意字符串，中文请使用utf-8编码
    QString stringUncrypt(const QString &content_hex, QString key);//解密加密后的字符串

    QString appVersion() const;
private:
    explicit Utility(QObject *parent = 0);
    ~Utility();
private:
    static Utility* me;
    QSettings *settings;
};

#endif // UTILITY_H
