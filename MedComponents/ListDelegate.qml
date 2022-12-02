import QtQuick 2.15

Item {
    id: root
    signal requestView(int row)
    signal requestRemove(int row)
    implicitHeight: 50
    implicitWidth: 100
    Rectangle {
        anchors.fill: parent
        color: model.index %2 === 0 ? "lightgrey" : "darkgrey"
        Text {
            id:nameLabel
            anchors {
                left: parent.left; leftMargin: 6
            }
            text: model.lastName + ", " + model.firstName
            font.pixelSize: parent.height * 0.8
        }
        Text {
            id: dobLabel
            anchors {
                right: btnRemove.left; rightMargin: 6
            }
            text: model.dob
            font.pixelSize: parent.height * 0.8
        }
        MouseArea {
            id: ma
            anchors.fill: parent
            onClicked: root.requestView(model.index)
        }
        Button {
            id: btnRemove
            anchors {
                right: parent.right; rightMargin: 2
            }
            height: parent.height - anchors.rightMargin;
            width: height
            text: "X"
            onClicked: root.requestRemove(model.index)
        }
    }
}
