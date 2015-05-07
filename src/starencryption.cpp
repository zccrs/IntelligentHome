#include "starencryption.h"
#include <QRegExp>

StarEncryption::StarEncryption()
{

}

StarEncryption::~StarEncryption()
{

}

QString StarEncryption::stringEncrypt(const QString &content, QString key)
{
    if(content==""||key=="")
        return content;
    if(key.size ()>256)
        key = key.mid (0,256);//密匙最长256位
    QByteArray data = strZoarium (content.toUtf8 ().toBase64 ());
    int data_size = data.size ();
    QByteArray mykey = strZoarium (key.toLatin1 ().toHex ());
    int key_size = mykey.size ();
    //qDebug()<<data;
    data=fillContent (data, 2*key_size-data_size);//填充字符串
    //qDebug()<<data;
    QByteArray temp="";
    for(int i=0;i<data.size ();++i){
        int ch = (int)data[i]+(int)mykey[i%key_size];
        //qDebug()<<ch<<(int)mykey[i%key_size]<<(int)data[i];
        if(ch>=0)
            temp.append (QString(ch));
    }
    //qDebug()<<temp;
    return QString::fromUtf8 (temp);
}

QString StarEncryption::stringUncrypt(const QString &content, QString key)
{
    if(content==""||key=="")
        return content;
    if(key.size ()>256)
        key = key.mid (0,256);//密匙最长256位
    QByteArray data = content.toLatin1 ();
    QByteArray mykey = strZoarium (key.toLatin1 ().toHex ());
    int key_size = mykey.size ();
    QByteArray temp;

    for(int i=0;i<data.size ();++i){
        int ch = (int)(uchar)data[i]-(int)mykey[i%key_size];
        if(ch>=0){
            temp.append ((char)ch);
        }
    }
    temp = unStrZoarium (temp);
    int fill_size = temp.mid (0, 3).toInt ();
    temp = temp.mid (fill_size+3, temp.size ()-fill_size-3);//除去填充的字符

    return QString::fromUtf8 (QByteArray::fromBase64 (temp));
}

char StarEncryption::numToStr(int num)
{
    QByteArray str="QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm";
    return str[num%str.size ()];
}

QByteArray StarEncryption::strZoarium(const QByteArray &str)
{
    QByteArray result;
    for(int i=0;i<str.size ();++i){
        char ch = (char)str[i];
        int ch_ascii = (int)ch;
        if(ch<='9'&&ch>='0'){//如果是数字
            result.append (ch);
        }else{//如果不是数字
            if(ch_ascii>=0)
                result.append (numToStr (ch_ascii)).append (QByteArray::number (ch_ascii)).append (numToStr (ch_ascii*2));
        }
    }
    return result;
}

QByteArray StarEncryption::unStrZoarium(const QByteArray &str)
{
    QByteArray result="";
    for(int i=0;i<str.size ();){
        char ch = (char)str[i];
        if(ch<='9'&&ch>='0'){//如果是数字
            result.append (ch);
            i++;
        }else{//如果是其他
            QRegExp regexp("[^0-9]");
            int pos = QString(str).indexOf (regexp, i+1);
            if(pos>0){
                int num = str.mid (i+1, pos-i-1).toInt ();
                if(num>=0)
                    result.append ((char)num);
                i=pos+1;
            }else{
                //qDebug()<<"数据有错";
                i++;
            }
        }
    }
    return result;
}

QByteArray StarEncryption::fillContent(const QByteArray &str, int length)
{
    if(length>0){
        QByteArray fill_size = QByteArray::number (length);
        if(fill_size.size ()==1)
            fill_size="00"+fill_size;
        else if(fill_size.size ()==2)
            fill_size="0"+fill_size;
        for(int i=0;i<length;++i){
            fill_size.append ("0");
        }
        return fill_size+str;
    }else{
        return "000"+str;
    }
}
