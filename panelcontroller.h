#pragma once
#include "gpio.h"
#include <QTimer>
class PanelController : public QObject {
   Q_OBJECT
public:
   explicit PanelController();
   Q_INVOKABLE void soundBuzzer(int beepLength = 250);
signals:
   void upPressed();
   void downPressed();
   void leftPressed();
   void rightPressed();
   void okPressed();
   void backPressed();
private:
   Gpio m_buzzer;
   Gpio m_btn_up;
   Gpio m_btn_down;
   Gpio m_btn_left;
   Gpio m_btn_right;
   Gpio m_btn_back;
   Gpio m_btn_ok;
   QTimer m_buzzerTimer;
};
