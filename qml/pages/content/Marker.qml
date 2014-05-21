import QtQuick 2.0

Item {
    property alias canvasObj: canvas
    property alias canvasRotation: canvas.rotation
    Canvas {
        id: canvas
        smooth: true
        width: 125
        height: 125
        rotation: 0
        onPaint: {
            var cxt1 = canvas.getContext('2d')
            cxt1.beginPath();
            cxt1.moveTo(canvas.width / 2 , canvas.height * 0.30);
            cxt1.lineTo(canvas.width / 2, canvas.height * 0.70);
            cxt1.lineWidth = 3
            var gradient1 = cxt1.createLinearGradient(canvas.width / 2 ,canvas.height * 0.30,
                                                     canvas.width / 2,canvas.height * 0.70)
            gradient1.addColorStop(0, "#FF0000")
            gradient1.addColorStop(0.25, "#FF6666")
            gradient1.addColorStop(0.5, 'transparent')
            gradient1.addColorStop(0.75, "#FF6666")
            gradient1.addColorStop(1.0, "#FF0000")
            cxt1.strokeStyle = gradient1;
            cxt1.stroke();
            var cxt2 = canvas.getContext('2d')
            cxt2.beginPath();
            cxt2.moveTo(0, canvas.height / 2);
            cxt2.lineTo(canvas.width, canvas.height / 2);
            cxt2.lineWidth = 3
            var gradient2 = cxt2.createLinearGradient(0,canvas.height / 2,
                                                     canvas.width,canvas.height / 2)
            gradient2.addColorStop(0, "#FF0000")
            gradient2.addColorStop(0.25, "#FF6666")
            gradient2.addColorStop(0.5, 'transparent')
            gradient2.addColorStop(0.75, "#FF6666")
            gradient2.addColorStop(1.0, "#FF0000")
            cxt2.strokeStyle = gradient2;
            cxt2.stroke();
        }
        opacity: 0.75

        Behavior on rotation {
            NumberAnimation {duration: 1500;
                             easing.type: Easing.InCirc}
        }
    }
}
