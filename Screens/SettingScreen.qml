import QtQuick 2.15
import Helpers 1.0
import "../MedComponents"

Item {
    id: root
    signal requestBack()
    Rectangle {
        anchors.fill: parent
        color: "lightgrey"
        Text {
            id: timeZoneLabel
            anchors {
                top: parent.top;
                left: parent.left
                margins: parent.height * 0.03
            }
            text: "Time Offset from UTC"
            font.pixelSize: parent.height * 0.08
        }
        SpinBox {
            id: timeZoneSelector
            anchors {
                top: timeZoneLabel.top
                left: timeZoneLabel.right
                leftMargin: 12
            }
            currentValue: DateTime.utcOffset
            minValue: -12
            maxValue: 12
            onCurrentValueChanged: DateTime.utcOffset = currentValue
        }
        Text {
            id: screenSaverLabel
            anchors.left: parent.left
            anchors.top: timeZoneLabel.bottom
            anchors.margins: parent.height *0.03
            text: "Screen timeout (seconds)"
            font.pixelSize: parent.height * 0.08
        }

        SpinBox {
            id: screenSaverSelector
            anchors.top: screenSaverLabel.top
            anchors.left: screenSaverLabel.right
            anchors.leftMargin: 6
            currentValue: DateTime.screenSaverTimeout
            minValue: 0
            maxValue: 600
            onCurrentValueChanged: DateTime.screenSaverTimeout = currentValue
        }

        Button {
            anchors {
                bottom: parent.bottom
                left: parent.left; right: parent.right
            }
            height: parent.height * 0.1
            text: "Back to List"
            onClicked: requestBack()
        }
    }
    Connections {
        target: panelIO
        function onOkPressed() {panelIO.soundBuzzer(500)}
        function onUpPressed() {
            if(timeZoneSelector.activeFocus) screenSaverSelector.forceActiveFocus()
            else timeZoneSelector.forceActiveFocus()
        }
        function onDownPressed() {
            if (timeZoneSelector.activeFocus) screenSaverSelector.forceActiveFocus()
            else timeZoneSelector.forceActiveFocus()
        }
    }
}
