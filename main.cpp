#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QScreen>
#include <QtQml>
#include "utility.h"
#include "video.h"

#define RegisterPlugin(Plugin) \
    qmlRegisterType<Plugin>("com.star.intelligenthome", 1, 0, #Plugin)


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //app.setQuitOnLastWindowClosed(false);
    app.setApplicationName("IntelligentHome");
    app.setOrganizationName("Star");
    app.setApplicationVersion("1.0.0");

    RegisterPlugin(CameraVideo);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("utility", Utility::getInstance());
    engine.rootContext()->setContextProperty("screen", app.primaryScreen());
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
