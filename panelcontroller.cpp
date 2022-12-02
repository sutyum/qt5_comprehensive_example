#include "panelcontroller.h"

PanelController::PanelController()
   : m_buzzer("22", Gpio::LineDirection::Out)
   , m_btn_up("23", Gpio::LineDirection::In)
   , m_btn_down("17", Gpio::LineDirection::In)
   , m_btn_left("18", Gpio::LineDirection::In)
   , m_btn_right("24", Gpio::LineDirection::In)
   , m_btn_back("25", Gpio::LineDirection::In)
   , m_btn_ok("27", Gpio::LineDirection::In)
   , m_buzzerTimer(this)
{
    connect(&m_buzzerTimer, &QTimer::timeout, this, [this] {
           m_buzzer.setLineState(Gpio::Low);
       });

       connect(&m_btn_ok, &Gpio::lineStateChanged, this, [this](Gpio::LineState state) {
           if (state == Gpio::High)
               Q_EMIT okPressed();
       });

       connect(&m_btn_back, &Gpio::lineStateChanged, this, [this](Gpio::LineState state) {
           if (state == Gpio::High)
               Q_EMIT backPressed();
       });

       connect(&m_btn_up, &Gpio::lineStateChanged, this, [this](Gpio::LineState state) {
           if (state == Gpio::High)
               Q_EMIT upPressed();
       });
       connect(&m_btn_down, &Gpio::lineStateChanged, this, [this](Gpio::LineState state) {
           if (state == Gpio::High)
               Q_EMIT downPressed();
       });

       connect(&m_btn_left, &Gpio::lineStateChanged, this, [this](Gpio::LineState state) {
           if (state == Gpio::High)
               Q_EMIT leftPressed();
       });

       connect(&m_btn_right, &Gpio::lineStateChanged, this, [this](Gpio::LineState state) {
           if (state == Gpio::High) {
               Q_EMIT rightPressed();
           }
       });
    }
void PanelController::soundBuzzer(int beepLength)
{
   m_buzzerTimer.setInterval(beepLength);
   m_buzzerTimer.start();
   m_buzzer.setLineState(Gpio::High);
}
