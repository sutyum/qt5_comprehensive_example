import QtQuick 2.15

Item {
    id: root
    signal accepted()
    signal rejected()
    property alias title: titleText.text
    property alias text: bodyText.text
    anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0.5, 0.5, 0.5, 0.75)
        MouseArea {
            anchors.fill: parent
        }
    }
    Rectangle {
        id: background
        anchors.centerIn: parent
        color: "lightGrey"
        height: parent.height * 0.6
        width: Math.max(titleText.paintedWidth + 12, bodyText.paintedWidth + 12)
        Rectangle {
            id: titleBar
            anchors {
                left: parent.left; right: parent.right
                top: parent.top;
            }
            height: parent.height * 0.25
            color: "grey"
            Text {
                id: titleText
                anchors {
                    fill: parent
                    leftMargin: 6; rightMargin: 6
                }
                font.pixelSize: parent.height * 0.75
            }
        }
        Text{
            id: bodyText
            anchors {
                left: parent.left; right: parent.right
                top:titleBar.bottom; bottom: btnNo.top
            }
            font.pixelSize: height * 0.3
            verticalAlignment: Text.AlignVCenter
        }
        Button {
            id: btnYes
            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            width: parent.width * 0.5
            height: parent.height * 0.15
            text: "Yes"
            onClicked: {
                root.accepted()
                root.visible = false
            }
        }
        Button {
            id: btnNo
            anchors {
                left: btnYes.right; right: parent.right
                top: btnYes.top; bottom: parent.bottom
            }
            text: "No"
            onClicked: {
                root.rejected()
                root.visible = false
            }
        }
    }

    Connections {
        target: panelIO
        function onBackPressed(){btnNo.clicked()}
        function onOkPressed(){btnYes.clicked()}
    }
}
