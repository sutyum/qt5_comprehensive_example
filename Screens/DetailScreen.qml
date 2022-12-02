import QtQuick 2.15
import QtCharts 2.15
import "../MedComponents"
Item {
    id: root
    signal requestBack()
    signal requestEdit(int row)
    property int index: -1
    Rectangle {
        anchors.fill: parent
        color: "lightgrey"
        Rectangle {
            id: patientInfo
            anchors.left:parent.left
            width: parent.width * 0.33
            height: parent.height * 0.45
            color: "darkgrey"
            Text {
                id: lblInfo
                font.pixelSize: parent.height * 0.13
                text: "Patient Info"
            }
            Column {
                anchors.fill: parent
                anchors.topMargin: lblInfo.paintedHeight
                anchors.margins: 6
                Text {
                    id: lblName
                    font.pixelSize: parent.height * 0.13
                    text: "Name: " + patientData.roleFromRow(index, "lastName") + ", " + patientData.roleFromRow(index, "firstName")
                }
                Text {
                    id: lblDob
                    font.pixelSize: parent.height * 0.13
                    text: "D.O.B: " + patientData.roleFromRow(index, "dob")
                }
                Text {
                    id: lblAddress
                    font.pixelSize: parent.height * 0.13
                    text: {
                        "Address\n  " +
                                patientData.roleFromRow(index, "address") + "\n  " +
                                patientData.roleFromRow(index, "city") + ", " + patientData.roleFromRow(index, "state") + " " + patientData.roleFromRow(index, "zipCode")
                    }
                }
            }
        }
        Rectangle {
            id :commentBox
            anchors.left: patientInfo.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: weightContainer.top
            color: "darkgrey"
            Text {
                id: lblComment
                font.pixelSize: parent.height * 0.13
                text: "Comments"
            }
            Rectangle {
                anchors.fill: parent
                anchors.topMargin: lblComment.paintedHeight
                anchors.margins: 6
                Text {
                    anchors.fill: parent
                    text: patientData.roleFromRow(index, "comments")
                }
            }
        }
        ChartView {
            id: weightContainer
            anchors.top: patientInfo.bottom
            anchors.bottom: btnEdit.top
            anchors.left: parent.left
            anchors.right: parent.right
            antialiasing: true
            legend.visible: false
        }
        Button {
            anchors {
                bottom: parent.bottom
                left: parent.left; right: parent.right
            }
            height: parent.height * 0.1
            text: "Back to List"
            onClicked: root.requestBack()
        }
        Button {
            id: btnEdit
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
            height: parent.height * 0.1
            text: "Edit"
            onClicked: root.requestEdit(index)
        }
    }
    onIndexChanged: {
        weightContainer.removeAllSeries()
        var weightData = patientData.roleFromRow(index, "weightData").split(",")
        weightContainer.createSeries(ChartView.SeriesTypeSpline, "Patient Weight", createAxis(0, (weightData.length - 2)), createAxis(50,350))
        for (var i = 0; i< weightData.length -1; i++)
            weightContainer.series(0).append(i, weightData[i])
    }
    function createAxis(min, max) {
        return Qt.createQmlObject("import QtQuick 2.12; import QtCharts 2.3; ValueAxis {min: " + min + "; max: " + max + "}", weightContainer);
    }
}
