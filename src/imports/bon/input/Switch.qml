import QtQuick
import QtQuick.Templates as T
import bon as B

T.Switch {
    id: root

    implicitWidth: indicator.width + leftPadding + rightPadding
    implicitHeight: indicator.height + topPadding + bottomPadding

    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    padding: Math.max(Math.max(0,thumb.width-indicator.width),Math.max(0,thumb.height-indicator.height))

    hoverEnabled: enabled

    B.Elevation {
        anchors.fill: indicator
        radius: indicator.radius
        elevation: !root.pressed && root.checked ? 1 : 0
        z: -1
    }

    indicator: Rectangle {
        width: 40;
        height: 20;

        x: root.text ? (root.mirrored ? root.width - width - root.rightPadding : root.leftPadding) : root.leftPadding + (root.availableWidth - width) / 2
        y: root.topPadding + (root.availableHeight - height) / 2

        radius: Math.max(width,height)/2
        color: !root.checked ? (
                   root.pressed ? B.Theme.palette.background_2 : B.Theme.palette.background_1
               ) : (
                   root.pressed ? B.Theme.palette.accent_1 : B.Theme.palette.accent
               )

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        property int thumbPadding: (height - thumb.height)/2

        B.Elevation {
            anchors.fill: thumb
            radius: thumb.radius
            elevation: root.pressed ? 1 : 2
        }

        Rectangle {
            id: thumb
            x: (root.visualPosition * ((parent.width-(parent.thumbPadding*2)) - tmpWidth)) + parent.thumbPadding
            y: (parent.height - height) / 2
            width: tmpWidth
            height: 16
            radius: Math.max(width, height)/2
            color: root.enabled && !root.hovered && !root.pressed ? B.Theme.palette.highlight : B.Theme.palette.highlight_1

            property real tmpWidth: 16 + (root.pressed ? 8 : 0)

            Behavior on color {
                ColorAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }

            Behavior on x {
                enabled: root.focus;
                animation: NumberAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
            Behavior on width {
                enabled: root.focus;
                animation: NumberAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
        }
    }
}
