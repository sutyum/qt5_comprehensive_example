#pragma once
#include <QObject>
#include <QDateTime>
#include <QQmlEngine>
#include <QJSEngine>

class QTimer;
class DateTime : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY currentTimeChanged)
    Q_PROPERTY(QString currentDate READ currentDate NOTIFY currentDateChanged)
    Q_PROPERTY(int utcOffset READ utcOffset WRITE setUtcOffset NOTIFY utcOffsetChanged)
    Q_PROPERTY(int screenSaverTimeout READ screenSaverTimeout WRITE setScreenSaverTimeout NOTIFY screenSaverTimeoutChanged)
public:
    static DateTime *get() {
        static DateTime m;
        return &m;
    }

    static QObject* qmlInstance(QQmlEngine *qmlEngine, QJSEngine* jsEngine) {
        Q_UNUSED(jsEngine)
        qmlEngine->setObjectOwnership(get(), QQmlEngine::CppOwnership);
        return get();
    }

    QString currentDate() { return m_currentDate; }
    QString currentTime() { return m_currentTime; }
    int utcOffset() { return m_utcOffset; }
    void setUtcOffset(int offset);
    int screenSaverTimeout() { return m_screenSaverTimeout; }
    void setScreenSaverTimeout(int secondsUntilTimeout);

signals:
    void currentTimeChanged();
    void currentDateChanged();
    void utcOffsetChanged();
    void screenSaverTimeoutChanged();
private:
    void updateTime();
    DateTime* operator=(DateTime& other) = delete;
    DateTime(const DateTime& other) = delete;
    DateTime(QObject *parent = nullptr);
    ~DateTime() = default;
    QString m_currentDate;
    QString m_currentTime;
    QTimer *m_timer = nullptr;
    int m_utcOffset = 0;
    int m_screenSaverTimeout = 0;
};
