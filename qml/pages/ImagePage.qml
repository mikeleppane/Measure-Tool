import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages/scripts/Vars.js" as Vars
import "../pages/scripts/MeasuretoolDB.js" as MtDB

Page {
    id: imagepage
    width: Screen.width
    height: Screen.height

    property var images: []

    SilicaListView {
        id: listView
        anchors.fill: parent
        clip: true
        focus: true
        model: ListModel {id: imageModel}
        header: PageHeader {
            id: pageheader
            title: qsTr("Measured objects")
        }

        spacing: Theme.paddingLarge

        PullDownMenu {
            visible: imageModel.count > 0
            MenuItem {
                text: "Delete all images"
                onClicked: {
                    if (images.length > 0) {
                        var imgs = images.map(function(img) {return img.path;})
                        logic.removeAllImages(imgs);
                        var i = 0, count = images.length;
                        for (i; i < count; i++) {
                            MtDB.removeImage(images[i].path);
                        }
                        imageModel.clear();
                        images = [];
                    }
                }
            }
        }
        ViewPlaceholder {
            enabled: imageModel.count === 0
            text: "No images available"
        }

        delegate: imageDelegate

        VerticalScrollDecorator {
            flickable: listView
        }
    }

    Component {
        id: imageDelegate
        BackgroundItem {
            id: bgItem
            width: ListView.view.width
            height: col.childrenRect.height + Theme.paddingLarge
            Column {
                id: col
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.paddingMedium
                Image {
                    id: img
                    source: path
                    fillMode: Image.PreserveAspectFit
                    height: 250
                    smooth: true
                }
                Row {
                    spacing: Theme.paddingLarge
                    anchors.horizontalCenter: img.horizontalCenter
                    Column {
                        spacing: 5
                        Label {
                            id: dLabel
                            text: Number(distance).toPrecision(4) + " m";
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.highlightColor
                            font.underline: true
                        }
                        Label {
                            anchors.horizontalCenter: dLabel.horizontalCenter
                            text: qsTr("Distance");
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.highlightColor
                        }
                    }
                    Column {
                        spacing: 5
                        Label {
                            id: hLabel
                            text: Number(_height).toPrecision(4) + " m";
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.highlightColor
                            font.underline: true
                        }
                        Label {
                            anchors.horizontalCenter: hLabel.horizontalCenter
                            text: qsTr("Height");
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.highlightColor
                        }
                    }
                }
            }
            onPressAndHold: {
                remorse.execute(bgItem, qsTr("Deleting image..."), function() {
                                logic.removeImage(path);
                                MtDB.removeImage(path);
                                images.splice(index,1);
                                imageModel.remove(index);
                                listView.positionViewAtBeginning();
                });
            }
            RemorseItem { id: remorse;}
        }
    }
    onStatusChanged: {
        if (status === PageStatus.Activating) {
            if (imageModel.count !== 0) imageModel.clear();
            images = MtDB.getImages();
            var i = 0, count = images.length;
            for (i; i < count; i++) {
                imageModel.append({"path": images[i].path,
                                   "distance": images[i].distance,
                                   "_height": images[i].height});
            }
         }
    }
}
