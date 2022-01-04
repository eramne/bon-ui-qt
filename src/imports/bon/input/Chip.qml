import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

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

    property color _textColor: checked ? B.Theme.palette.text.label_dark : B.Theme.palette.text.label
    property real _textOpacity: root.down || root.hovered || !root.enabled ? B.Theme.highlight_hover_opacity : 1

    height: 34
    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    Behavior on _textOpacity {
        NumberAnimation {
            duration: B.Theme.animations.basic.duration
            easing.type: B.Theme.animations.basic.type
        }
    }

    B.Elevation {
        anchors.fill: background
        radius: background.radius
        elevation: root.checked ? (root.down ? 1 : 2) : 0
        z: -1
    }

    background: Rectangle {
        anchors.fill: root
        color: checked ? (
                   root.down ? B.Theme.palette.accent_1 : B.Theme.palette.accent
               ) : (
                   root.down ? B.Theme.palette.background_2 : (
                       root.hovered ? B.Theme.palette.background_1 : B.Theme.palette.background
                   )
               )
        radius: Math.max(width, height)/2
        border.color: B.Theme.palette.background_1
        border.width: !root.checked && !root.down && !root.hovered ? 2 : 0

        Behavior on border.width {
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
