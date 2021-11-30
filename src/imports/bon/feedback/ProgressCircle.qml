import QtQuick
import QtQuick.Shapes
import QtQuick.Templates as T
import bon

T.ProgressBar {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    layer.enabled: true
    layer.samples: 8

    property int state: ProgressCircle.State.Paused
    property bool small: false

    property real _width: small ? 20 : 40
    property real _height: small ? 20 : 40
    property real _thickness: 8
    property color _indicatorColor: state === ProgressCircle.State.Running ? __app__.style.palette.controls.accent
                                         : state === ProgressCircle.State.Paused ? __app__.style.palette.controls.background_1
                                         : state === ProgressCircle.State.Success ? __app__.style.palette.success
                                         : __app__.style.palette.error
    property color _backgroundColor: root.state !== ProgressCircle.State.Success && root.state !== ProgressCircle.State.Error ? __app__.style.palette.controls.background : _indicatorColor
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

    onStateChanged: {
        if (root.indeterminate) {
            if (root.state === ProgressCircle.State.Running) {
                rotationTimer.running = true;
            } else if (root.state === ProgressCircle.State.Paused) {
                rotationTimer.running = false;
            } else {
                rotationTimer.running = false;
            }
        } else {
            rotationTimer.running = false;
            indicator.indeterminateRotatorPosition = 0;
        }
    }

    Component.onCompleted: {
        root.stateChanged();
    }

    width: _width
    height: _height

    contentItem: Shape {
        id: indicator
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        property real start: root.indeterminate ? indeterminateRotatorPosition % 1 : 0
        property real end: root.indeterminate ? start + 0.5 % 1 : root.value

        property real indeterminateRotatorPosition: 0

        Timer {
            id: rotationTimer
            interval: 100
            running: false
            repeat: true
            onTriggered: function () {
                indicator.indeterminateRotatorPosition = indicator.indeterminateRotatorPosition + 0.05;
            }
        }

        Behavior on indeterminateRotatorPosition {
            id: posAnimation
            animation: NumberAnimation {
                duration: __app__.style.animations.progressRotate.duration;
                easing.type: __app__.style.animations.progressRotate.type;
            }
        }

        Behavior on end {
            enabled: !root.indeterminate
            animation: NumberAnimation {
                duration: __app__.style.animations.progressStep.duration;
                easing.type: __app__.style.animations.progressStep.type;
            }
        }

        ShapePath {
            startX: Math.sin(indicator.start*2*Math.PI)*((root.width/2)-(_thickness/2)) + root.width/2;
            startY: -Math.cos(indicator.start*2*Math.PI)*((root.height/2)-(_thickness/2)) + root.height/2;
            fillColor: "transparent"
            strokeColor: _indicatorColor
            strokeWidth: _thickness
            capStyle: ShapePath.RoundCap

            Behavior on strokeColor {
                ColorAnimation {
                    duration: __app__.style.animations.progressColor.duration;
                    easing.type: __app__.style.animations.progressColor.type;
                }
            }

            PathArc {
                x: Math.sin(indicator.end*2*Math.PI)*((root.width/2)-(_thickness/2)) + root.width/2;
                y: -Math.cos(indicator.end*2*Math.PI)*((root.height/2)-(_thickness/2)) + root.height/2;
                radiusX: root.width/2 - _thickness/2; radiusY: root.height/2 - _thickness/2
                useLargeArc: Math.abs(indicator.end-indicator.start)>0.5
            }
        }
    }

    background: Shape {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        ShapePath {
            startX: root.width/2; startY: _thickness/2
            fillColor: "transparent"
            strokeColor: _backgroundColor
            strokeWidth: _thickness

            Behavior on strokeColor {
                ColorAnimation {
                    duration: __app__.style.animations.progressColor.duration;
                    easing.type: __app__.style.animations.progressColor.type;
                }
            }

            PathArc {
                x: root.width/2-0.0001; y: _thickness/2
                radiusX: root.width/2 - _thickness/2; radiusY: root.height/2 - _thickness/2
                useLargeArc: true
            }
        }
    }
}
