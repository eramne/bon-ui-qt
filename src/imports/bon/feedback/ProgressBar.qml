import QtQuick
import QtQuick.Templates as T
import bon

T.ProgressBar {
    id: control

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
    property color _backgroundColor: control.state !== ProgressBar.State.Success && control.state !== ProgressBar.State.Error ? __app__.style.palette.controls.background : _indicatorColor
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
        if (control.indeterminate) {
            if (control.state === ProgressBar.State.Running) {
                rotationTimer.running = true;
            } else if (control.state === ProgressBar.State.Paused) {
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
        control.stateChanged();
    }

    width: 100
    height: _height

    contentItem: Item {
        anchors.fill: parent
        Rectangle {
            id: indicator
            radius: _radius
            width: control.indeterminate ? Math.min(Math.min(parent.width, parent.width-indicator.indeterminateRotatorPosition),parent.width+indicator.indeterminateRotatorPosition) : (control.state !== ProgressBar.State.Success && control.state !== ProgressBar.State.Error ? parent.width * control.position : parent.width)
            height: parent.height
            color: _indicatorColor
            x: control.indeterminate ? Math.max(0,indicator.indeterminateRotatorPosition) : 0

            property real indeterminateRotatorPosition: -parent.width

            Timer {
                id: rotationTimer
                interval: 100
                running: false
                repeat: true
                onTriggered: function () {
                    indicator.indeterminateRotatorPosition += 10;
                    if (indicator.indeterminateRotatorPosition > control.width) {
                        posAnimation.enabled = false;
                        indicator.indeterminateRotatorPosition = -control.width;
                        posAnimation.enabled = true;
                    }
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: _duration;
                    easing.type: _easing;
                }
            }

            Behavior on indeterminateRotatorPosition {
                id: posAnimation
                animation: NumberAnimation {
                    duration: _progressDuration;
                    easing.type: _progressEasing;
                }
            }

            Behavior on width {
                enabled: !control.indeterminate
                animation: NumberAnimation {
                    duration: _progressDuration*8;
                    easing.type: _progressEasing;
                }
            }
        }
        scale: control.mirrored ? -1 : 1
    }

    background: Rectangle {
        width: parent.width
        height: parent.height
        radius: _radius
        color: _backgroundColor

        Behavior on color {
            ColorAnimation {
                duration: _duration;
                easing.type: _easing;
            }
        }
    }
}
