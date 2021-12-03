import QtQuick
import QtQuick.Templates as T
import bon

T.RadioButton {
    id: root

    implicitWidth: indicator.width + leftPadding + rightPadding
    implicitHeight: indicator.height + topPadding + bottomPadding

    property bool mixed: false
    hoverEnabled: enabled
    property int effectiveState: mixed ? -1 : root.checked //0 = off, 1 = on, -1 = mixed

    onClicked: function () {
        mixed = false;
    }

    opacity: !root.enabled ? Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    padding: 0

    Elevation {
        anchors.fill: indicator
        radius: indicator.radius
        elevation: root.enabled ? (
                       root.effectiveState == 0 ? (
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
        color: root.effectiveState === 0 ? (
                   root.down ? Theme.palette.background_2 : Theme.palette.background_1
               ) : root.effectiveState === 1  ? (
                   root.down ? Theme.palette.accent_1 : Theme.palette.accent
               ) : (
                   root.down ? Theme.palette.accent : Theme.palette.accent_1
               )

        Behavior on color {
            ColorAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Rectangle {
            id: icon
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: root.effectiveState == 1 && !root.hovered && !root.down ? 8
                       : (root.effectiveState == -1 && (root.hovered || root.down) ? 8
                       : (root.effectiveState == -1 ? 12
                       : (root.effectiveState == 0 && !root.hovered && !root.down) ? 16 : 12)
                   )
            height: root.effectiveState == 1 && !root.hovered && !root.down ? 8
                        : (root.effectiveState == -1 && (root.hovered || root.down) ? 8
                        : (root.effectiveState == -1 ? 4
                        : (root.effectiveState == 0 && !root.hovered && !root.down) ? 16 : 12)
                    )
            radius: 8
            color: (root.effectiveState == 1 || root.effectiveState == -1) && (!root.hovered && !root.down) ? (
                       Theme.palette.highlight
                   ) : root.effectiveState == -1 || (root.effectiveState == 1 && (!root.hovered && !root.down)) ? (
                       Theme.palette.highlight_1
                   ) : Theme.palette.background

            Behavior on color {
                ColorAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
            Behavior on width {
                animation: NumberAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
            Behavior on height {
                animation: NumberAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
        }
    }
}
