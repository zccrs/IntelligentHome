#ifndef STARENCRYPTION_H
#define STARENCRYPTION_H

#include <QString>

class StarEncryption
{
public:
    StarEncryption();
    ~StarEncryption();

    QString stringEncrypt(const QString &content, QString key);//加密任意字符串，中文请使用utf-8编码
    QString stringUncrypt(const QString &content_hex, QString key);//解密加密后的字符串

private:
    char numToStr(int num);//将数字按一定的规律换算成字母
    QByteArray strZoarium(const QByteArray &str);//按一定的规律加密字符串(只包含数字和字母的字符串)
    QByteArray unStrZoarium(const QByteArray &str);//按一定的规律解密字符串(只包含数字和字母的字符串)
    QByteArray fillContent(const QByteArray &str, int length);//将字符串填充到一定的长度
};

#endif // STARENCRYPTION_H
