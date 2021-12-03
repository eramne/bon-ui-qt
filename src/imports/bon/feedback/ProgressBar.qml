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

    property color _indicatorColor: state === ProgressBar.State.Running ? Theme.palette.accent
                                         : state === ProgressBar.State.Paused ? Theme.palette.background_2
                                         : state === ProgressBar.State.Success ? Theme.palette.success
                                         : Theme.palette.error

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
    height: 8

    contentItem: Item {
        anchors.fill: parent
        Rectangle {
            id: indicator
            radius: height/2
            width: root.indeterminate ? Math.min(Math.min(parent.width, parent.width-indicator.indeterminateRotatorPosition),parent.width+indicator.indeterminateRotatorPosition) : (root.state !== ProgressBar.State.Success && root.state !== ProgressBar.State.Error ? parent.width * root.position : parent.width)
            height: parent.height
            color: root._indicatorColor
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
                    duration: Theme.animations.progressColor.duration;
                    easing.type: Theme.animations.progressColor.type;
                }
            }

            Behavior on indeterminateRotatorPosition {
                id: posAnimation
                animation: NumberAnimation {
                    duration: Theme.animations.progressRotate.duration;
                    easing.type: Theme.animations.progressRotate.type;
                }
            }

            Behavior on width {
                enabled: !root.indeterminate
                animation: NumberAnimation {
                    duration: Theme.animations.progressStep.duration;
                    easing.type: Theme.animations.progressStep.type;
                }
            }
        }
        scale: root.mirrored ? -1 : 1
    }

    background: Rectangle {
        width: parent.width
        height: parent.height
        radius: height/2
        color: root.state !== ProgressBar.State.Success && root.state !== ProgressBar.State.Error ? Theme.palette.background_1 : root._indicatorColor

        Behavior on color {
            ColorAnimation {
                duration: Theme.animations.progressColor.duration;
                easing.type: Theme.animations.progressColor.type;
            }
        }
    }
}
