import QtQuick 2.15

Item {
    id: root
    implicitHeight: 16
    implicitWidth: label.paintedWidth + 8
    signal clicked()
    property alias text: label.text
    property alias radius: background.radius
    property color backgroundColor: "grey"
    property color textColor: "white"
    Rectangle {
        id: background
        anchors.fill: parent
        color: root.enabled ? ma.pressed ? Qt.lighter(backgroundColor) : backgroundColor : Qt.darker(backgroundColor)
        border.color: Qt.darker(backgroundColor)
        border.width: 1
        Text {
            id: label
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.8
            color: root.enabled ? textColor : Qt.darker(textColor)
            text: "Button"
        }
        MouseArea {
            id: ma
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}
