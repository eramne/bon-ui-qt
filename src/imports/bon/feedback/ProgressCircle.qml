import QtQuick
import QtQuick.Shapes
import QtQuick.Templates as T
import bon

T.ProgressBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    layer.enabled: true
    layer.samples: 8

    property int state: ProgressBar.State.Paused

    property real _width: 40
    property real _height: 40
    property real _thickness: 8
    property real _radius: _height/2
    property color _indicatorColor: state === ProgressBar.State.Running ? __app__.style.palette.controls.accent
                                         : state === ProgressBar.State.Paused ? __app__.style.palette.controls.background_1
                                         : state === ProgressBar.State.Success ? __app__.style.palette.success
                                         : __app__.style.palette.error
    property color _backgroundColor: __app__.style.palette.controls.background
    property real _elevation: 1
    property real _progressEasing: Easing.Linear
    property real _progressDuration: __app__.style.animations.basic.duration
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    enum State {
        Running,
        Paused,
        Success,
        Error
    }

    width: _width
    height: _height

    background: Shape {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        ShapePath {
            startX: control.width/2; startY: _thickness/2
            fillColor: "transparent"
            strokeColor: _backgroundColor
            strokeWidth: _thickness
            PathArc {
                x: control.width/2-0.1; y: _thickness/2
                radiusX: control.width/2 - _thickness/2; radiusY: control.height/2 - _thickness/2
                useLargeArc: true
            }
        }
    }
}
