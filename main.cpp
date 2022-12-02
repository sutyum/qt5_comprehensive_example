#include <QApplication>
#include <QDir>
#include <QFile>
#include <QSettings>
#include <QSqlTableModel>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "panelcontroller.h"
#include "patientdata.h"
#include "datetime.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QSettings settings(QStringLiteral("myCompany"), QStringLiteral("MedishDemo"), nullptr);

    QSqlDatabase db = QSqlDatabase::addDatabase(QStringLiteral("QSQLITE"));
    if (!QFile::exists(QStringLiteral("/usr/share/medical-data/medData.db")))
        db.setDatabaseName(QStringLiteral("%1/Labs/medData.db").arg(QDir::homePath()));
    else
        db.setDatabaseName(QStringLiteral("/usr/share/medical-data/medData.db"));
    db.open();
    PatientData patientData(nullptr, db);
    PanelController panelIO;

    DateTime::get()->setUtcOffset(settings.value(QStringLiteral("utcOffset"), 0).toInt());
    QObject::connect(DateTime::get(), &DateTime::utcOffsetChanged, [&settings] {
        settings.setValue(QStringLiteral("utcOffset"), DateTime::get()->utcOffset());
    });

    DateTime::get()->setScreenSaverTimeout(settings.value(QStringLiteral("screenSaverTimeout"), 0).toInt());
       QObject::connect(DateTime::get(), &DateTime::screenSaverTimeoutChanged, [&settings] {
           settings.setValue(QStringLiteral("screenSaverTimeout"), DateTime::get()->screenSaverTimeout());
       });

    qmlRegisterSingletonType<DateTime>("Helpers", 1, 0, "DateTime", &DateTime::qmlInstance);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("patientData", &patientData);
    engine.rootContext()->setContextProperty("panelIO", &panelIO);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
