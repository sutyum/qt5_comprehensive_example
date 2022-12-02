import QtQuick 2.15

Rectangle {
   id: root
   property alias text : textEdit.text
   property alias validator: textEdit.validator
   property alias placeHolderText: placeHolderText.text
   property alias validInput: textEdit.acceptableInput
   property bool multiLine: false
   //property int fontSize: multiLine ? font.pixelSize : height * 0.75
   implicitHeight: 36
   implicitWidth: 120
   clip: true
   color: "lightgrey"
   border.color: validInput ? "green" : "red"
   border.width: 3
   TextInput {
          id: textEdit
          anchors.fill: parent
          leftPadding: 6
          rightPadding: 6
          cursorVisible: activeFocus
          font.pixelSize: multiLine ? parent.height * 0.2 : parent.height * 0.75
          wrapMode: multiLine ? Text.WrapAnywhere : Text.NoWrap
      }

      Text {
          id: placeHolderText
          color: "grey"
          anchors.fill: parent
          leftPadding: 6
          rightPadding: 6
          topPadding: multiLine ? 6 : 0
          font.pixelSize: multiLine ? parent.height * 0.2 : parent.height * 0.75
          visible: textEdit.text === ""
      }
   }
