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

    icon.color: _textColor
    icon.name: ""

    hoverEnabled: enabled
    checkable: true

    property color _textColor: checked ? (
                                   B.Theme.palette.text.label_dark
                               ) : (
                                   B.Theme.palette.text.label
                               )
    property real _textOpacity: root.down || root.hovered || !root.enabled ? B.Theme.highlight_hover_opacity : 1

    width: 40
    height: 40
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

    contentItem: Item {
        anchors.fill: parent
        B.Icon {
            id: icon
            anchors.centerIn: parent
            visible: isValid
            name: root.icon.name
            color: root.icon.color
            opacity: _textOpacity
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
