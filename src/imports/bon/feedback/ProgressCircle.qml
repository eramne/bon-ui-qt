import QtQuick
import QtQuick.Shapes
import QtQuick.Templates as T
import bon as B

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

    property real _thickness: small ? 4 : 8
    property color _indicatorColor: state === ProgressCircle.State.Running ? B.Theme.palette.accent
                                         : state === ProgressCircle.State.Paused ? B.Theme.palette.background_2
                                         : state === ProgressCircle.State.Success ? B.Theme.palette.success
                                         : B.Theme.palette.error

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

    width: small ? 20 : 40
    height: small ? 20 : 40

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
                duration: B.Theme.animations.progressRotate.duration;
                easing.type: B.Theme.animations.progressRotate.type;
            }
        }

        Behavior on end {
            enabled: !root.indeterminate
            animation: NumberAnimation {
                duration: B.Theme.animations.progressStep.duration;
                easing.type: B.Theme.animations.progressStep.type;
            }
        }

        ShapePath {
            startX: Math.sin(indicator.start*2*Math.PI)*((root.width/2)-(root._thickness/2)) + root.width/2;
            startY: -Math.cos(indicator.start*2*Math.PI)*((root.height/2)-(root._thickness/2)) + root.height/2;
            fillColor: "transparent"
            strokeColor: root._indicatorColor
            strokeWidth: root._thickness
            capStyle: ShapePath.RoundCap

            Behavior on strokeColor {
                ColorAnimation {
                    duration: B.Theme.animations.progressColor.duration;
                    easing.type: B.Theme.animations.progressColor.type;
                }
            }

            PathArc {
                x: Math.sin(indicator.end*2*Math.PI)*((root.width/2)-(root._thickness/2)) + root.width/2;
                y: -Math.cos(indicator.end*2*Math.PI)*((root.height/2)-(root._thickness/2)) + root.height/2;
                radiusX: root.width/2 - root._thickness/2; radiusY: root.height/2 - root._thickness/2
                useLargeArc: Math.abs(indicator.end-indicator.start)>0.5
            }
        }
    }

    background: Shape {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        ShapePath {
            startX: root.width/2; startY: root._thickness/2
            fillColor: "transparent"
            strokeColor: root.state !== ProgressCircle.State.Success && root.state !== ProgressCircle.State.Error ? B.Theme.palette.background_1 : root._indicatorColor
            strokeWidth: root._thickness

            Behavior on strokeColor {
                ColorAnimation {
                    duration: B.Theme.animations.progressColor.duration;
                    easing.type: B.Theme.animations.progressColor.type;
                }
            }

            PathArc {
                x: root.width/2-0.0001; y:root. _thickness/2
                radiusX: root.width/2 - root._thickness/2; radiusY: root.height/2 - root._thickness/2
                useLargeArc: true
            }
        }
    }
}
