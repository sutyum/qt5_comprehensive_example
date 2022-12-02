import QtQuick 2.15
import QtQuick.Window 2.15
import "MedComponents"
import "Screens"

import Helpers 1.0

Window {
    visible: true
    width: 1280; height: 720
    title: qsTr("Medish Device")
    Rectangle {
        id: headerBar
        anchors {
            top: parent.top
            left: parent.left; right: parent.right
        }
        height: parent.height * 0.1
        z: 10
        DateTimeLabel { anchors.fill: parent }
    }
    Rectangle {
        id: mainContent
        anchors {
            top: headerBar.bottom; bottom: parent.bottom
            left: parent.left; right: parent.right
        }
        Loader {
            id: screenLoader
            anchors.fill: parent
            source: "Screens/HomeScreen.qml"
        }
        Connections {
            target: screenLoader.item
            ignoreUnknownSignals: true
            function onRequestSettings() {screenLoader.source = "Screens/SettingScreen.qml"}
            function onRequestNew() {screenLoader.source = "Screens/NewPatientScreen.qml"}
            function onRequestBack(){screenLoader.source = "Screens/HomeScreen.qml"}
            function onRequestRemove(row) {patientData.removeRow(row)}
            function onRequestView(row) {
                screenLoader.source = "Screens/DetailScreen.qml"
                screenLoader.item.index = row
            }
        }
        Connections {
            target: panelIO
            function onBackPressed() {screenLoader.source = "Screens/HomeScreen.qml"}
        }
    }
    Timer {
         id: screenSaverTimer
         interval: DateTime.screenSaverTimeout * 1000
         running: DateTime.screenSaverTimeout !== 0
         repeat: true
         onTriggered: screenSaver.visible = true
    }
    ScreenSaver {
       z: 999
       id: screenSaver
       anchors.fill: parent
       visible: false
    }
    MouseArea {
       anchors.fill: parent
       z:1000
       onPressed: {
           mouse.accepted = screenSaver.visible
           inputHappened()
       }
    }

    Connections {
        target: panelIO
        function onUpPressed() {inputHappened()}
        function onDownPressed() {inputHappened()}
        function onLeftPressed() {inputHappened()}
        function onRightPressed() {inputHappened()}
        function onOkPressed() {inputHappened()}
        function onBackPressed() {inputHappened()}
    }

    function inputHappened() {
        if(screenSaver.visible)
            screenSaver.visible = false
        else
            screenSaverTimer.restart()
    }
}
