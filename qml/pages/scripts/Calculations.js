function measure() {
    if ((orientationSensor.reading.orientation === OrientationReading.TopUp ||
        orientationSensor.reading.orientation === OrientationReading.TopDown) &&
          (Math.abs(rotationSensor.reading.x) < 90 && Math.abs(rotationSensor.reading.x) > 0)) {
        _distance = logic.calculateDistance(rotationSensor.reading.x, parseFloat(MtDB.getHeight()))
        _angle_x = Math.abs(rotationSensor.reading.x);
        objDistance.text = _distance.toPrecision(4) + " m";
    } else if ((orientationSensor.reading.orientation === OrientationReading.LeftUp ||
               orientationSensor.reading.orientation === OrientationReading.RightUp) &&
               (Math.abs(rotationSensor.reading.y) < 90 && Math.abs(rotationSensor.reading.y) > 0))  {
        _distance = logic.calculateDistance(rotationSensor.reading.y, parseFloat(MtDB.getHeight()))
        _angle_y = Math.abs(rotationSensor.reading.y);
        objDistance.text = _distance.toPrecision(4) + " m";
    }
}

function getHeight() {
    if (orientationSensor.reading.orientation === OrientationReading.TopUp ||
        orientationSensor.reading.orientation === OrientationReading.TopDown) {
        if (Math.abs(rotationSensor.reading.x) === 90) {
            objDistance.text = parseFloat(MtDB.getHeight()).toPrecision(4) + " m";
        } else if (Math.abs(rotationSensor.reading.x) < _angle_x && Math.abs(rotationSensor.reading.x) > 0 &&
                   Math.abs(rotationSensor.reading.y) <= 90 && Math.abs(rotationSensor.reading.y) >= 0) {
            _height = _distance -
                        logic.calculateDistance(rotationSensor.reading.x,parseFloat(MtDB.getHeight()))
            objHeight.text = _height.toPrecision(4) + " m"
        } else if (Math.abs(rotationSensor.reading.x) < 90 && Math.abs(rotationSensor.reading.x) > _angle_x &&
                   Math.abs(rotationSensor.reading.y) <= 90 && Math.abs(rotationSensor.reading.y) >= 0) {
            _height = parseFloat(MtDB.getHeight()) -
                        logic.calculateDistance(90.0 - Math.abs(rotationSensor.reading.x), _distance)
            objHeight.text = _height.toPrecision(4) + " m"
        } else if (Math.abs(rotationSensor.reading.x) === _angle_x) {
            objHeight.text = (0.0).toPrecision(4) + " m";
        } else if (Math.abs(rotationSensor.reading.x) < 90 && Math.abs(rotationSensor.reading.x) > 0 &&
                   Math.abs(rotationSensor.reading.y) <= 180 && Math.abs(rotationSensor.reading.y) > 90) {
            _height = parseFloat(MtDB.getHeight()) +
                        logic.calculateDistance(90.0 - Math.abs(rotationSensor.reading.x), _distance)
            objHeight.text = _height.toPrecision(4) + " m"
        }
    } else if (orientationSensor.reading.orientation === OrientationReading.LeftUp ||
          orientationSensor.reading.orientation === OrientationReading.RightUp) {
          if (Math.abs(rotationSensor.reading.y) === 90) {
              objDistance.text = parseFloat(MtDB.getHeight()).toPrecision(4) + " m";
          } else if (Math.abs(rotationSensor.reading.y) < _angle_y && Math.abs(rotationSensor.reading.y) > 0) {
              _height = _distance -
                          logic.calculateDistance(rotationSensor.reading.y, parseFloat(MtDB.getHeight()))
              objHeight.text = _height.toPrecision(4) + " m"
          } else if (Math.abs(rotationSensor.reading.y) < 90 && Math.abs(rotationSensor.reading.y) > _angle_y) {
              _height = parseFloat(MtDB.getHeight()) -
                          logic.calculateDistance(90.0 - Math.abs(rotationSensor.reading.y), _distance)
              objHeight.text = _height.toPrecision(4) + " m"
          } else if (Math.abs(rotationSensor.reading.y) === _angle_y) {
              objHeight.text = (0.0).toPrecision(4) + " m";
          } else if (Math.abs(rotationSensor.reading.y) <= 180 && Math.abs(rotationSensor.reading.y) > 90) {
              _height = parseFloat(MtDB.getHeight()) +
                          logic.calculateDistance(Math.abs(rotationSensor.reading.y) - 90.0, _distance)
              objHeight.text = _height.toPrecision(4) + " m"
          }
    }
}
