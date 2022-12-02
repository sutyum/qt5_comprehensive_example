import QtQuick 2.15

Item {
    id: root
    property int currentValue: 0
    property int minValue: -99
    property int maxValue: 99
    width: height * 3.55
    height: parent.height * 0.1
    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"
    }
    Button {
        id: btnMinus
        anchors {
            top: display.top; bottom: display.bottom
            right: display.left
        }
        height: parent.height
        width: height
        text: "-"
        onClicked: currentValue -= 1
    }
    Text{
        id: display
        anchors.centerIn: parent
        width: height * 1.55
        height: parent.height
        text: currentValue
        font.pixelSize: height * 0.75
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Button {
        id: btnPlus
        anchors {
            top: display.top; bottom: display.bottom
            left: display.right
        }
        height: parent.height
        width: height
        text: "+"
        onClicked: currentValue += 1
    }
    Rectangle {
        anchors.fill: parent
        visible: root.activeFocus
        color: Qt.rgba(0.0, 0.0, 1.0, 0.25)
        border.width: root.activeFocus ? 2 : 0
        border.color: "blue"
        z:100
    }
    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        onClicked: {
            root.forceActiveFocus()
            mouse.accepted = false
        }
    }
    onCurrentValueChanged: {
        if(currentValue > maxValue)
            currentValue = maxValue
        else if(currentValue < minValue)
            currentValue = minValue
    }
    Connections {
        target: panelIO
        function onLeftPressed() {if(activeFocus) currentValue -= 1 }
        function onRightPressed() {if(activeFocus) currentValue += 1 }
    }
}
