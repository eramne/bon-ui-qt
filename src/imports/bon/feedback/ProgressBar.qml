import QtQuick
import QtQuick.Templates as T
import bon

T.ProgressBar {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property int state: ProgressBar.State.Paused

    property real _height: 8
    property real _radius: _height/2
    property color _indicatorColor: state === ProgressBar.State.Running ? __app__.style.palette.controls.accent
                                         : state === ProgressBar.State.Paused ? __app__.style.palette.controls.background_1
                                         : state === ProgressBar.State.Success ? __app__.style.palette.success
                                         : __app__.style.palette.error
    property color _backgroundColor: root.state !== ProgressBar.State.Success && root.state !== ProgressBar.State.Error ? __app__.style.palette.controls.background : _indicatorColor
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
            if (root.state === ProgressBar.State.Running) {
                rotationTimer.running = true;
            } else if (root.state === ProgressBar.State.Paused) {
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

    width: 100
    height: _height

    contentItem: Item {
        anchors.fill: parent
        Rectangle {
            id: indicator
            radius: _radius
            width: root.indeterminate ? Math.min(Math.min(parent.width, parent.width-indicator.indeterminateRotatorPosition),parent.width+indicator.indeterminateRotatorPosition) : (root.state !== ProgressBar.State.Success && root.state !== ProgressBar.State.Error ? parent.width * root.position : parent.width)
            height: parent.height
            color: _indicatorColor
            x: root.indeterminate ? Math.max(0,indicator.indeterminateRotatorPosition) : 0

            property real indeterminateRotatorPosition: -parent.width

            Timer {
                id: rotationTimer
                interval: 100
                running: false
                repeat: true
                onTriggered: function () {
                    indicator.indeterminateRotatorPosition += 10;
                    if (indicator.indeterminateRotatorPosition > root.width) {
                        posAnimation.enabled = false;
                        indicator.indeterminateRotatorPosition = -root.width;
                        posAnimation.enabled = true;
                    }
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: __app__.style.animations.progressColor.duration;
                    easing.type: __app__.style.animations.progressColor.type;
                }
            }

            Behavior on indeterminateRotatorPosition {
                id: posAnimation
                animation: NumberAnimation {
                    duration: __app__.style.animations.progressRotate.duration;
                    easing.type: __app__.style.animations.progressRotate.type;
                }
            }

            Behavior on width {
                enabled: !root.indeterminate
                animation: NumberAnimation {
                    duration: __app__.style.animations.progressStep.duration;
                    easing.type: __app__.style.animations.progressStep.type;
                }
            }
        }
        scale: root.mirrored ? -1 : 1
    }

    background: Rectangle {
        width: parent.width
        height: parent.height
        radius: _radius
        color: _backgroundColor

        Behavior on color {
            ColorAnimation {
                duration: __app__.style.animations.progressColor.duration;
                easing.type: __app__.style.animations.progressColor.type;
            }
        }
    }
}
