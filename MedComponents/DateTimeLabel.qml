import QtQuick 2.15
import Helpers 1.0

Item {
    id: root
    property color textColor: "black"
    property alias backgroundColor: background.color
    implicitHeight: 16
    implicitWidth: txt_currentDate.paintedWidth + txt_currentTime.paintedWidth + 12
    Rectangle {
        id: background
        anchors.fill: parent
        Text {
            id: txt_currentDate
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left; leftMargin: 3
            }
            text: DateTime.currentDate
            color: textColor
            font.pixelSize: parent.height * 0.6
        }
        Text {
            id: txt_currentTime
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right; rightMargin: 3
            }
            text: DateTime.currentTime
            color: textColor
            font.pixelSize: parent.height * 0.6
        }
    }
}
