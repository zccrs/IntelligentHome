#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include "utility.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setApplicationName("IntelligentHome");
    app.setOrganizationName("Star");
    app.setApplicationVersion("1.0.0");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("utility", Utility::getInstance());
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
