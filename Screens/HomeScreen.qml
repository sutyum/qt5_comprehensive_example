import QtQuick 2.15
import "../MedComponents"

Item {
    id: root
    anchors.fill: parent
    signal requestNew()
    signal requestSettings()
    signal requestRemove(int row)
    signal requestView(int row)
    property int buttonHeight: height * 0.1
    Rectangle {
        anchors {
            left: parent.left; right: parent.right
            top: parent.top; bottom: btnSettings.top
        }
        color: "cyan"
        ListView {
            anchors {
                fill: parent
                topMargin: 2;
            }
            model: patientData
            delegate: ListDelegate {
                height: buttonHeight
                width: root.width
                onRequestRemove: {
                    confirmDialog.text = "Remove " + model.lastName + ',' + model.firstName + "?"
                    confirmDialog.visible = true
                    confirmDialog.index = row
                }
                onRequestView: root.requestView(row)
            }
            spacing: 2
        }
    }
    Button {
        id:btnSettings
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
        height: buttonHeight
        text: "⚙"
        onClicked: requestSettings()
    }
    Button {
        id: btnNew
        anchors {
            bottom: parent.bottom
            left: parent.left; right: btnSettings.left
        }
        height: buttonHeight
        text: "Add Patient"
        onClicked: requestNew()
    }
    QuestionDialog {
        id: confirmDialog
        property int index: -1
        title: "Delete Record?"
        visible: false
        onAccepted: patientData.removeRow(index)
    }
}
