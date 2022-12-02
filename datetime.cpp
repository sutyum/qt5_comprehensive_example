#include "datetime.h"
#include <QDateTime>
#include <QTimer>

DateTime::DateTime(QObject *parent)
    : QObject(parent)
    , m_timer(new QTimer(this))
{
    updateTime();
    m_timer->start(1000);
    connect(m_timer, &QTimer::timeout, this, &DateTime::updateTime);
}

void DateTime::setUtcOffset(int offset)
{
    if(offset == m_utcOffset || offset > 12 || offset < -12)
        return;
    m_utcOffset = offset;
    Q_EMIT utcOffsetChanged();
}

void DateTime::setScreenSaverTimeout(int secondsUntilTimeout)
{
    if ((secondsUntilTimeout == m_screenSaverTimeout) || (secondsUntilTimeout < 0) || (secondsUntilTimeout > 600))
           return;
       m_screenSaverTimeout = secondsUntilTimeout;
       Q_EMIT screenSaverTimeoutChanged();
}

void DateTime::updateTime()
{
    QString currentTime = QDateTime::currentDateTime().toOffsetFromUtc(m_utcOffset * 3600).toString(QStringLiteral("hh:mm.ss AP"));
    if(m_currentTime != currentTime) {
        m_currentTime = currentTime;
        Q_EMIT currentTimeChanged();
    }

    QString currentDate = QDateTime::currentDateTime().toOffsetFromUtc(m_utcOffset * 3600).toString(QStringLiteral("MMMM d, yyyy"));
    if(m_currentDate != currentDate) {
        m_currentDate = currentDate;
        Q_EMIT currentDateChanged();
    }
}
