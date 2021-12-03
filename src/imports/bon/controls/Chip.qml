import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon

T.Button {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    icon.color: root._textColor

    leftPadding: 10
    rightPadding: 10

    hoverEnabled: enabled

    property color _textColor: checked ? Theme.palette.text.label_dark : Theme.palette.text.label
    property real _textOpacity: root.down || root.hovered || !root.enabled ? Theme.highlight_hover_opacity : 1

    height: 34
    opacity: !root.enabled ? Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    Behavior on _textOpacity {
        NumberAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }



    Elevation {
        anchors.fill: background
        radius: background.radius
        elevation: root.checked ? (root.down ? 1 : 2) : 0
        z: -1
    }

    background: Rectangle {
        anchors.fill: root
        color: checked ? (
                   root.down ? Theme.palette.accent_1 : Theme.palette.accent
               ) : (
                   root.down ? Theme.palette.background_2 : (
                       root.hovered ? Theme.palette.background_1 : Theme.palette.background
                   )
               )
        radius: Math.max(width, height)/2
        border.color: Theme.palette.background_1
        border.width: !root.checked && !root.down && !root.hovered ? 2 : 0

        Behavior on border.width {
            NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }
    }
}
