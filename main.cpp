#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QScreen>
#include "utility.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setApplicationName("IntelligentHome");
    app.setOrganizationName("Star");
    app.setApplicationVersion("1.0.0");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("utility", Utility::getInstance());
    engine.rootContext()->setContextProperty("screen", app.primaryScreen());
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
