#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

void customMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    if (!msg.contains("QML Shortcut: Shortcut: Only binding to one of multiple key bindings associated with")) {
        fprintf(stdout, qFormatLogMessage(type, context, msg).toLocal8Bit()+"\n");
        fflush(stdout);
    }
}

int main(int argc, char* argv[]) {
    #if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
        QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    #endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath(BON_PATH);
    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray("1"));
    qInstallMessageHandler(customMessageOutput);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject* obj, const QUrl& objUrl) {
        if (!obj && url == objUrl) {
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
