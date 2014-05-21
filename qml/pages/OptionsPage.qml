import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages/scripts/MeasuretoolDB.js" as MtDB
import "../pages/scripts/Vars.js" as Vars

//OptionsDialog.qml

Dialog {
    id: dialog
    width: Screen.width
    height: Screen.height

    SilicaFlickable {
        id: view
        anchors.fill: parent
        clip: true
        focus: true

        DialogHeader {
            id: dialogHeader
            width: parent.width
        }
        Column {
            id: col
            anchors {
                top: dialogHeader.bottom
                topMargin: Theme.paddingMedium
                horizontalCenter: parent.horizontalCenter
            }
            width: dialog.width
            spacing: Theme.paddingMedium

            TextArea {
                id: textarea
                focus: true
                font.family: "Verdana"
                width: parent.width
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: TextEdit.WordWrap
                text: "In order to enhance accuracy try to set the height of the phone(from ground level) " +
                      "as close as possible. The default value will be 1.5 m but it is advisable " +
                      "to measure real distance and set it accordingly."
                readOnly: true

            }
            TextField {
                id: phoneHField
                focus: true
                width: dialog.width
                font.pixelSize: Theme.fontSizeExtraLarge
                placeholderText: qsTr("Set height...")
                label: qsTr("Phone height")
                color: errorHighlight && text !== "" ? "red" : "steelblue"
                validator: DoubleValidator{bottom: 0.0}
                errorHighlight: text ? !acceptableInput : false
                inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
            }
        }
        /*
        TextSwitch {
            id: cameraswitch
            anchors {
                top: col.bottom
                topMargin: Theme.paddingLarge
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("Camera off")
            description: qsTr("Enable/disable camera mode while measuring")
            onCheckedChanged: {
                if (!checked) {
                    text = qsTr("Camera off");
                    Vars.ISCAMERA = false;
                } else {
                    text =  qsTr("Camera on");
                    Vars.ISCAMERA = true;
                }
            }
        }
        */
    }
    onAccepted: {
        if (phoneHField.text !== "" &&
                isFinite(Number(String(phoneHField.text).replace(",",".")))) {
            MtDB.updateHeight(parseFloat(String(phoneHField.text).replace(",",".")));
        }
    }
    onOpened: {
        phoneHField.text = String(MtDB.getHeight()).replace(".",",")
        //cameraswitch.checked = Vars.ISCAMERA;
    }

}
