import QtQuick
import QtQuick.Templates as T
import bon as B

T.ProgressBar {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property int state: ProgressBar.State.Paused

    property color _indicatorColor: state === ProgressBar.State.Running ? B.Theme.palette.accent
                                         : state === ProgressBar.State.Paused ? B.Theme.palette.background_2
                                         : state === ProgressBar.State.Success ? B.Theme.palette.success
                                         : B.Theme.palette.error

    enum State {
        Running,
        Paused,
        Success,
        Error
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

            NumberAnimation on indeterminateRotatorPosition {
                running: root.indeterminate
                loops: Animation.Infinite
                duration: 2000
                from: -root.width
                to: root.width
            }

            Behavior on color {
                ColorAnimation {
                    duration: B.Theme.animations.progressColor.duration;
                    easing.type: B.Theme.animations.progressColor.type;
                }
            }

            Behavior on width {
                enabled: !root.indeterminate
                animation: NumberAnimation {
                    duration: B.Theme.animations.progressStep.duration;
                    easing.type: B.Theme.animations.progressStep.type;
                }
            }
        }
        scale: root.mirrored ? -1 : 1
    }

    background: Rectangle {
        width: parent.width
        height: parent.height
        radius: height/2
        color: root.state !== ProgressBar.State.Success && root.state !== ProgressBar.State.Error ? B.Theme.palette.background_1 : root._indicatorColor

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.progressColor.duration;
                easing.type: B.Theme.animations.progressColor.type;
            }
        }
    }
}
