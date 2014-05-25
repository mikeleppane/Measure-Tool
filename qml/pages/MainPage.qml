/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import Sailfish.Media 1.0
import QtSensors 5.0
import "content"
import "../pages/scripts/MeasuretoolDB.js" as MtDB
import "../pages/scripts/Calculations.js" as Calc
import "../pages/scripts/Vars.js" as Vars


Page {
    id: page
    width: Screen.width
    height: Screen.height

    property real _height: 0.0
    property real _distance: 0.0
    property real _angle_x: 0.0
    property real _angle_y: 0.0
    property bool isDistance: false;
    property bool isHeight: false;

    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
            }
            MenuItem {
                text: qsTr("Options")
                onClicked: pageStack.push(Qt.resolvedUrl("OptionsPage.qml"));
            }
            MenuItem {
                text: qsTr("See Measurements")
                onClicked: pageStack.push(Qt.resolvedUrl("ImagePage.qml"));
            }
        }
    }

    Row {
        spacing: Theme.paddingLarge
        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge
            leftMargin: Theme.paddingLarge
            rightMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        x: 10
        TextField {
            id: objDistance
            width: page.width * 0.5
            text: ""
            placeholderText: qsTr("Distance")
            label: qsTr("Measured distance")
            font.pixelSize: Theme.fontSizeLarge
            font.underline: true
            font.bold: true
            color: Theme.highlightColor
            placeholderColor: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            readOnly: true
        }
        TextField {
            id: objHeight
            width: page.width * 0.5
            text: ""
            placeholderText: qsTr("Height")
            label: qsTr("Measured height")
            font.pixelSize: Theme.fontSizeLarge
            font.underline: true
            font.bold: true
            color: Theme.highlightColor
            placeholderColor: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            readOnly: true
        }
    }

    Rectangle {
        width: page.width
        height: page.height * 0.75
        anchors.centerIn: parent
        opacity: 0.2
    }

    Item {
        id: cameraOutput
        width: page.width * 0.9
        height: page.height * 0.7
        anchors.centerIn: parent
        GStreamerVideoOutput {
            anchors.fill: parent
            source: camera
            focus: visible
        }

        Camera {
            id: camera
            focus {
                focusMode: Camera.FocusContinuous
                focusPointMode: Camera.FocusPointCenter
            }
        }
        z: 2
    }

    Marker {
        id: marker
        anchors.centerIn: cameraOutput
        anchors.margins: 0
        width: 75
        height: 75
        z: 10
    }

    RotationSensor {
        id: rotationSensor
        active: false

        onReadingChanged: {
            if (isDistance) {
                Calc.measure();
                Vars.DISTANCE = _distance;
            } else if (isHeight) {
                if (_distance > 0) {
                    if (_angle_x > 0 &&
                            (orientationSensor.reading.orientation
                                         === OrientationReading.TopUp ||
                                         orientationSensor.reading.orientation
                                         === OrientationReading.TopDown)) {
                        Calc.getHeight();
                        Vars.HEIGHT = _height;
                    } else if (_angle_y > 0 &&
                               (orientationSensor.reading.orientation
                                          === OrientationReading.LeftUp ||
                                          orientationSensor.reading.orientation
                                          === OrientationReading.RightUp)) {
                        Calc.getHeight();
                        Vars.HEIGHT = _height;
                    }
                }
            }
        }
    }

    OrientationSensor {
        id: orientationSensor
        active: true

        onReadingChanged: {
            if (reading.orientation === OrientationReading.LeftUp ||
                reading.orientation === OrientationReading.RightUp) {
                marker.canvasRotation = 90;
            } else if (reading.orientation === OrientationReading.TopUp ||
                        reading.orientation === OrientationReading.TopDown) {
                marker.canvasRotation = 0;
            }
        }
    }
    Column {
        anchors {
            bottom: parent.bottom
            bottomMargin: Theme.paddingSmall
            horizontalCenter: parent.horizontalCenter
        }
        z: 10
        Row {
            Button {
                id: measureButton
                width: page.width / 2
                text: qsTr("Get distance");
                onClicked: {
                    if (!rotationSensor.active && !isDistance && !isHeight) {
                        rotationSensor.active = true;
                        isDistance = true;
                        text = qsTr("measuring...");
                    } else {
                        rotationSensor.active = false;
                        isDistance = false;
                        text = qsTr("Get distance");
                    }
                }
            }
            Button {
                id: heightButton
                width: page.width / 2
                text: qsTr("Get height");
                onClicked: {
                    if (!rotationSensor.active && !isDistance && !isHeight) {
                        rotationSensor.active = true
                        isHeight = true;
                        text = qsTr("Measuring...");
                    } else {
                        rotationSensor.active = false
                        isHeight = false;
                        text = qsTr("Get height");
                        /*
                        if (Vars.ISCAMERA) {
                            camera.imageCapture.capture();
                        }
                        */
                    }
                }
            }
        }
        Row {
            IconButton {
                id: zoomOut
                width: page.width / 3
                icon.source: "image://theme/icon-camera-zoom-out"
                onClicked: {
                    camera.digitalZoom -= 0.5
                }
            }
            IconButton {
                id: cameraButton
                width: page.width / 3
                icon.source: "image://theme/icon-camera-shutter-release"
                onClicked: {
                    //anim.restart();
                    if (isFinite(_distance) && isFinite(_height)) {
                        camera.imageCapture.capture();

                    }
                }
                /*
                SequentialAnimation {
                    id: anim
                    NumberAnimation { target: cameraButton; property: "opacity"; to: 0.25; duration: 250 }
                    NumberAnimation { target: cameraButton; property: "opacity"; to: 1.0; duration: 250 }
                }
                */
            }
            IconButton {
                id: zoomIn
                width: page.width / 3
                icon.source: "image://theme/icon-camera-zoom-in"
                onClicked: {
                    camera.digitalZoom += 0.5
                }
            }
        }
    }
    Connections {
        target: camera.imageCapture

        onImageSaved: {
            MtDB.addImage(path, _distance, _height);
        }
    }

}


