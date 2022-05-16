import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

T.Button {
    id: root

    leftPadding: 10
    rightPadding: root.variant === Chip.Type.Input ? 5 : 10

    property int variant: set?.variant ?? Chip.Type.Action
    checkable: root.variant === Chip.Type.Choice
    hoverEnabled: enabled
    autoExclusive: set?.exclusive ?? false

    property real _textOpacity: root.down || root.hovered || !root.enabled ? B.Theme.highlight_hover_opacity : 1

    property var set: parent?.set ?? undefined

    width: contentItem.implicitWidth + leftPadding + rightPadding
    height: 34
    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled
    icon.name: root.variant === Chip.Type.Choice ? (checked ? "check" : "") : ""

    enum Type {
        Action,
        Choice,
        Input
    }

    signal closed()

    onClosed: {
        visible = false;
    }

    Behavior on _textOpacity {
        NumberAnimation {
            duration: B.Theme.animations.basic.duration
            easing.type: B.Theme.animations.basic.type
        }
    }

    Behavior on width {
        enabled: root.variant === Chip.Type.Choice
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

    contentItem: RowLayout {
        anchors.verticalCenter: root.verticalCenter
        x: root.leftPadding
        spacing: 5
        height: root.height
        width: Layout.minimumWidth
        clip: root.variant === Chip.Type.Choice

        B.Icon {
            id: icon
            Layout.alignment: Qt.AlignCenter
            dark: root.checked
            visible: root.variant === Chip.Type.Choice ? (root.checked ? true : false) : isValid
            name: root.variant === Chip.Type.Choice ? "check" : root.icon.name
            opacity: root._textOpacity
        }

        B.LabelText {
            text: root.text
            dark: root.checked
            Layout.alignment: Qt.AlignVCenter
            opacity: root._textOpacity
        }

        B.SmallIconButton {
            visible: root.variant === Chip.Type.Input
            icon.name: "cancel"
            Component.onCompleted: {
                onClicked.connect(root.closed)
            }
        }
    }
}
