import QtQuick 2.15

Item {
    id: root
    readonly property var keysRow0: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
    readonly property var keysRow1: ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']
    readonly property var keysRow2: ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l']
    readonly property var keysRow3: ['z', 'x', 'c', 'v', 'b', 'n', 'm', ':', '.', '/']
    property bool shift: false
    signal keyPressed(var key)
    signal backspacePressed()
    signal hidePressed()
    property int keyHeight: height * 0.2
    property int keyWidth: width * 0.1
    height: parent.height * 0.5
    width: parent.width
    z: 100
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0.5, 0.5, 0.5, 0.75)
        Column {
            property var rows: [keysRow0, keysRow1, keysRow2, keysRow3]
            Repeater {
                model: parent.rows
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Repeater {
                        model: modelData
                        Button {
                            height: keyHeight
                            width: keyWidth
                            text: shift ? String(modelData).toUpperCase() : modelData
                            onClicked: checkKeyPress(modelData)
                        }
                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    height: keyHeight
                    width: keyWidth
                    text: shift ? "⬆" : "⇧"
                    onClicked: shift = !shift
                }
                Button {
                    height: keyHeight
                    width: keyWidth * (keysRow3.length - 3)
                    text: "Space"
                    onClicked: checkKeyPress(" ")
                }
                Button {
                    height: keyHeight
                    width: keyWidth
                    text: "⌫"
                    onClicked: checkKeyPress("⌫")
                }
                Button {
                    height: keyHeight
                    width: keyWidth
                    text: "⌨"
                    onClicked: checkKeyPress("⌨")
                }
            }
        }
    }
    function checkKeyPress(key) {
        if (key === "⌫")
            backspacePressed()
        else if (key === "⌨")
            visible = false
        else
            keyPressed(shift ? String(key).toUpperCase() : key)
        shift = false
    }
}
