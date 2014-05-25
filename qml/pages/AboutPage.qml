import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        anchors.fill: parent;
        Column {
            id: col
            anchors.centerIn: parent
            spacing: 5
            Image {
                id: name
                horizontalAlignment: Image.AlignHCenter
                source: "qrc:/images/images/harbour-measuretool.png"
                smooth: true
            }
            Label {
                width: parent.width
                text: qsTr("MeasureTool for Sailfish OS")
                horizontalAlignment: Text.AlignHCenter;
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeLarge
            }
        }
        Text {
            anchors {
                top: col.bottom
                topMargin: Theme.paddingLarge*3
            }
            width: parent.width;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            horizontalAlignment: Text.AlignHCenter;
            textFormat: Text.RichText;
            font.pixelSize: Theme.fontSizeSmall
            color: "white"
            text: "<style>a:link { color: " + Theme.highlightColor + "; }</style>" +
                  "Version 1.1 <br/>" +
                  qsTr('Created by Mikko Leppänen') + '<br/>' +
                  qsTr('The source code is available at %1').arg('<br/> <a href="https://github.com/MikeL83/Measure-Tool">%1</a>').arg("Project webpage")

            onLinkActivated: {
                Qt.openUrlExternally(link);
            }
        }
    }
}
