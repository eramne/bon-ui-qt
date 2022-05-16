import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

T.AbstractButton {
    id: root

    hoverEnabled: enabled
    visible: icon.isValid
    //checkable: false

    property bool dark: false
    icon.name: ""
    //property string offIcon: ""
    //property string onIcon: offIcon

    width: 24
    height: 24
    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    contentItem: Item {
        anchors.fill: parent
        B.Icon {
            id: icon
            anchors.centerIn: parent
            visible: isValid
            name: root.icon.name //root.checked ? root.onIcon : root.offIcon
            dark: root.dark
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
        color: dark ? (
                   root.down ? B.Theme.palette.accent_1 : B.Theme.palette.accent
               ) : (
                   root.down ? B.Theme.palette.background_2 : B.Theme.palette.background_1
               )
        radius: Math.max(width,height)/2
        opacity: root.dark ? (root.pressed ? 1 : 0) : (root.pressed || root.hovered ? 1 : 0)

        Behavior on opacity {
            NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }
    }
}
