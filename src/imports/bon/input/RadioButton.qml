import QtQuick
import QtQuick.Templates as T
import bon as B

T.RadioButton {
    id: root

    implicitWidth: indicator.width + leftPadding + rightPadding
    implicitHeight: indicator.height + topPadding + bottomPadding

    property bool mixed: false
    hoverEnabled: enabled
    property int effectiveState: mixed ? RadioButton.State.Mixed : (root.checked ? RadioButton.State.On : RadioButton.State.Off)

    enum State {
        Off,
        On,
        Mixed
    }

    onClicked: function () {
        mixed = false;
    }

    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    padding: 0

    B.Elevation {
        anchors.fill: indicator
        radius: indicator.radius
        elevation: root.enabled ? (
                       root.effectiveState === RadioButton.State.Off ? (
                           !root.down ? 1 : 0
                       ) : (
                           !root.down ? 2 : 1
                       )
                   ) : 0
        z: -1
    }

    indicator: Rectangle {
        width: 20
        height: 20

        x: root.text ? (root.mirrored ? root.width - width - root.rightPadding : root.leftPadding) : root.leftPadding + (root.availableWidth - width) / 2
        y: root.topPadding + (root.availableHeight - height) / 2

        radius: Math.max(width, height)
        color: root.effectiveState === RadioButton.State.Off ? (
                   root.down ? B.Theme.palette.background_2 : B.Theme.palette.background_1
               ) : root.effectiveState === RadioButton.State.On  ? (
                   root.down ? B.Theme.palette.accent_1 : B.Theme.palette.accent
               ) : (
                   root.down ? B.Theme.palette.accent : B.Theme.palette.accent_1
               )

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Rectangle {
            id: icon
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: root.effectiveState === RadioButton.State.On && !root.hovered && !root.down ? 8
                       : (root.effectiveState === RadioButton.State.Mixed && (root.hovered || root.down) ? 8
                       : (root.effectiveState === RadioButton.State.Mixed ? 12
                       : (root.effectiveState === RadioButton.State.Off && !root.hovered && !root.down) ? 16 : 12)
                   )
            height: root.effectiveState === RadioButton.State.On && !root.hovered && !root.down ? 8
                        : (root.effectiveState === RadioButton.State.Mixed && (root.hovered || root.down) ? 8
                        : (root.effectiveState === RadioButton.State.Mixed ? 4
                        : (root.effectiveState === RadioButton.State.Off && !root.hovered && !root.down) ? 16 : 12)
                    )
            radius: 8
            color: (root.effectiveState === RadioButton.State.On || root.effectiveState === RadioButton.State.Mixed) && (!root.hovered && !root.down) ? (
                       B.Theme.palette.highlight
                   ) : root.effectiveState === RadioButton.State.Mixed || (root.effectiveState === RadioButton.State.On && (!root.hovered && !root.down)) ? (
                       B.Theme.palette.highlight_1
                   ) : B.Theme.palette.background

            Behavior on color {
                ColorAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
            Behavior on width {
                animation: NumberAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
            Behavior on height {
                animation: NumberAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
        }
    }
}
