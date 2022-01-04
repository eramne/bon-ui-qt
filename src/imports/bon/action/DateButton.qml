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


    hoverEnabled: enabled
    checkable: true
    text: "1"

    property bool today: false
    property bool rangeSelected: false

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

        Text {
            id: text
            text: root.text
            anchors.fill: parent
            color: checked || rangeSelected ? (
                       B.Theme.palette.text.label_dark
                   ) : (
                       B.Theme.palette.text.label
                   )
            font: B.Theme.text.button
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
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
        color: root.rangeSelected ? (
                   root.down ? B.Theme.palette.accent : B.Theme.palette.accent_1
               ) : (
                   checked ? (
                       root.down ? B.Theme.palette.accent_1 : B.Theme.palette.accent
                   ) : (
                       root.down ? B.Theme.palette.background_2 : (
                           root.hovered ? B.Theme.palette.background_1 : B.Theme.palette.background
                       )
                   )
               )
        opacity: root.rangeSelected ? (root.down ? 1 : 0) : 1
        radius: Math.max(width,height)/2
        border.color: B.Theme.palette.background_1
        border.width: today && !root.down && !root.hovered && !root.checked ? 2 : 0

        Behavior on color {
            enabled: root.down || root.hovered
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Behavior on border.width {
            NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }
    }
}
