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
import "../pages/scripts/Vars.js" as Vars

CoverBackground {
    id: cover
    property bool active: status === Cover.Active

    Image {
        id: icon
        horizontalAlignment: Image.AlignHCenter
        source: "qrc:/images/images/harbour-measuretool.png"
        smooth: true
        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: item
        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge * 2
            left: parent.left
            leftMargin: Theme.paddingMedium
        }
        visible: false
        Column {
            spacing: Theme.paddingMedium
            Column {
                spacing: 0
                Label {
                    id: distanceField
                    width: cover.width
                    text: ""
                    font.pixelSize: Theme.fontSizeSmall
                    font.underline: true
                    font.bold: true
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignHCenter
                }
                Label {
                    anchors.horizontalCenter: distanceField.horizontalCenter
                    text: qsTr("Distance")
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.highlightColor
                }
            }
            Column {
                Label {
                    id: heightField
                    width: cover.width
                    text: ""
                    font.pixelSize: Theme.fontSizeSmall
                    font.underline: true
                    font.bold: true
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignHCenter
                }
                Label {
                    anchors.horizontalCenter: heightField.horizontalCenter
                    text: qsTr("Height")
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.highlightColor
                }
            }
        }
    }

    Label {
        id: label
        anchors {
            left: parent.left
            bottom: parent.bottom
        }

        text: "MeasureTool"
        color: Theme.secondaryHighlightColor
        font.pixelSize: Theme.fontSizeLarge*1.55
        opacity: 0.5
        transform: Rotation {angle: -60}
    }


    onActiveChanged: {
        if (active && (Vars.DISTANCE > 0 || Vars.HEIGHT > 0)) {
            label.opacity = icon.opacity = 0.25;
            item.visible = true
            distanceField.text = String(Number(Vars.DISTANCE).toPrecision(4)) + " m"
            heightField.text = String(Number(Vars.HEIGHT).toPrecision(4)) + " m"
        } else if (active && (Vars.DISTANCE < 0.0001 || Vars.HEIGHT < 0.0001))  {
            item.visible = false
            label.opacity = icon.opacity = 1.0
        }
    }
}


