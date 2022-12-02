import QtQuick 2.15
import "../MedComponents"

Item {
    id: root
    signal requestBack()
    property int lineHeight: (root.height - virtualKeyboard.height) * 0.17
    property int lineBaseWidth: lineHeight * 6
    property int index: -1
    Rectangle {
        anchors.fill: parent
        color: "darkgrey"
        LineEdit {
            id: lineFName
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 6
            width: root.lineBaseWidth
            height: root.lineHeight
            placeHolderText: "First Name"
            text: patientData.roleFromRow(index, "firstName")
            validator: RegExpValidator { regExp: /.+/}
        }
        LineEdit {
            id: lineLName
            anchors.left: lineFName.right
            anchors.right: lineComments.left
            anchors.top: parent.top
            anchors.margins: 6
            height: root.lineHeight
            placeHolderText: "Last Name"
            text: patientData.roleFromRow(index, "lastName")
            validator: RegExpValidator { regExp: /.+/}
        }
        Text {
            id: lblDob
            text: "DOB"
            anchors.top: lineLName.bottom
            anchors.verticalCenter: lineDob.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 6
            font.pixelSize: root.lineHeight - 6
        }
        LineEdit {
            id: lineDob
            anchors.top: lineLName.bottom
            anchors.left: lblDob.right
            anchors.margins: 6
            width: root.lineBaseWidth *1.25
            height: root.lineHeight
            text: patientData.roleFromRow(index, "dob")
            placeHolderText: "MM/DD/YYYY"
            validator: RegExpValidator { regExp: /\d{2}\/\d{2}\/\d{4}/ }
        }
        LineEdit {
            id: lineAddress
            anchors.left: parent.left
            anchors.right: lineZip.right
            anchors.top: lineDob.bottom
            height: root.lineHeight
            anchors.margins: 6
            placeHolderText: "Address"
            text: patientData.roleFromRow(index, "address")
            validator: RegExpValidator { regExp: /.+/}
        }
        LineEdit {
            id: lineCity
            anchors.left: parent.left
            anchors.top: lineAddress.bottom
            anchors.margins: 6
            width: root.lineBaseWidth * 1.25
            height: root.lineHeight
            placeHolderText: "City"
            text: patientData.roleFromRow(index, "city")
            validator: RegExpValidator { regExp: /.+/}
        }
        LineEdit {
            id: lineState
            anchors.left: lineCity.right
            anchors.top: lineAddress.bottom
            anchors.margins: 6
            width: root.lineBaseWidth * 0.4
            height: root.lineHeight
            placeHolderText: "State"
            text: patientData.roleFromRow(index, "state")
            validator: RegExpValidator { regExp: /\S{2}/}
        }
        LineEdit {
            id: lineZip
            anchors.left: lineState.right
            anchors.top: lineAddress.bottom
            anchors.margins: 6
            width: root.lineBaseWidth * 0.5
            height: root.lineHeight
            placeHolderText: " Zip "
            text: patientData.roleFromRow(index, "zipCode")
            validator: RegExpValidator { regExp: /\d{5}/}
        }
        LineEdit {
            id:lineComments
            anchors.left: lineZip.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: lineWeightData.top
            anchors.bottomMargin: 6
            placeHolderText: "Comments"
            text: patientData.roleFromRow(index, "comments")
            multiLine: true
        }
        LineEdit {
            id: lineWeightData
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: lineZip.bottom
            height: root.lineHeight
            anchors.margins: 6
            placeHolderText: "Comma seperated weight data (Ending with Comma)"
            text: patientData.roleFromRow(index, "weightData")
            validator: RegExpValidator {regExp: /(\d{2,3},)*/}
        }
        Button {
            id: btnSave
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            height: parent.height * 0.08
            text: "Save Entry"
            enabled: lineFName.validInput && lineLName.validInput
                     && lineDob.validInput && lineAddress.validInput
                     && lineCity.validInput && lineZip.validInput
                     && lineState.validInput
            onClicked: {
                var data = lineFName.text + ";" + lineLName.text + ";" + lineDob.text + ";"
                data += lineAddress.text + ";" + lineCity.text + ";" + lineState.text + ";"
                data += lineZip.text + ";" + lineComments.text +  ";" + lineWeightData.text
                patientData.addRow(root.index, data)
                root.requestBack()
            }
        }
        Button {
              id: btnBack
              anchors.bottom: parent.bottom
              anchors.left: btnSave.right
              anchors.right: btnKbd.left
              height: parent.height * 0.08
              text: "Back to List"
              onClicked: root.requestBack()
        }
        Button {
            id: btnKbd
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: height * 1.25
            height: parent.height * 0.08
            text: "⌨"
            onClicked: virtualKeyboard.visible = !virtualKeyboard.visible
        }
    }

    VirtualKeyboard {
        id: virtualKeyboard
        focus: false
        anchors.bottom: parent.bottom
        onKeyPressed: {
            var cursorPos = activeFocusItem.cursorPosition
            activeFocusItem.text = activeFocusItem.text.slice(0, cursorPos) + key + activeFocusItem.text.slice(cursorPos, activeFocusItem.text.length)
            activeFocusItem.cursorPosition = Math.max(0, cursorPos + 1)
        }
        onBackspacePressed: {
            var cursorPos = activeFocusItem.cursorPosition
            activeFocusItem.text = activeFocusItem.text.slice(0, cursorPos -1) + activeFocusItem.text.slice(cursorPos, activeFocusItem.text.length)
            activeFocusItem.cursorPosition = Math.max(0, cursorPos - 1)
        }
    }
}
