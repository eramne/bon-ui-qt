import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

T.AbstractButton {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    icon.name: ""

    hoverEnabled: enabled
    checkable: true

    width: 40
    height: 40
    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    B.Elevation {
        anchors.fill: background
        radius: background.radius
        elevation: root.checked ? (root.down ? 1 : 2) : 0
        z: -1
    }

    contentItem: Item {
        anchors.fill: parent
        B.Icon {
            id: icon
            anchors.centerIn: parent
            visible: isValid
            name: root.icon.name
            dark: root.checked
            opacity: root.down || root.hovered || !root.enabled ? B.Theme.highlight_hover_opacity : 1

            Behavior on opacity {
                NumberAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
        }
    }

    background: Rectangle {
        anchors.fill: root
        color: checked ? (
                   root.down ? B.Theme.palette.accent_1 : B.Theme.palette.accent
               ) : (
                   root.down ? B.Theme.palette.background_2 : B.Theme.palette.background_1
               )

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }
    }
}
