import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

T.Button {
    id: root

    icon.name: ""

    leftPadding: !_round ? 20 : 0
    rightPadding: !_round ? 20 : 0

    hoverEnabled: enabled

    property real _textOpacity: root.down || root.hovered || !root.enabled ? B.Theme.highlight_hover_opacity : 1
    property bool _round: root.text.length === 0

    width: !_round ? contentItem.width + leftPadding + rightPadding : height
    height: 40

    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    property int order: Button.Order.Primary // 1 = primary, 2 = secondary, 3 or anything else = tertiary
    property bool enableElevationEffects: true

    enum Order {
        Primary,
        Secondary,
        Tertiary
    }

    Behavior on _textOpacity {
        NumberAnimation {
            duration: B.Theme.animations.basic.duration
            easing.type: B.Theme.animations.basic.type
        }
    }

    B.Elevation {
        anchors.fill: background
        radius: background.radius
        elevation: root.enableElevationEffects ? order === Button.Order.Primary ? (root.down ? 1 : 2) : 0 : 0
        z: -1
    }

    contentItem: RowLayout {
        anchors.centerIn: root
        spacing: !root._round ? 10 : 0
        height: root.height
        width: Layout.minimumWidth

        B.Icon {
            id: icon
            Layout.alignment: Qt.AlignCenter
            visible: isValid
            name: root.icon.name
            //color: root.icon.color
            opacity: root._textOpacity
            dark: order === Button.Order.Primary
        }

        B.ButtonText {
            text: root.text
            dark: order === Button.Order.Primary
            opacity: root._textOpacity
        }
    }

    background: Rectangle {
        anchors.fill: root
        color: order === Button.Order.Primary ? (
                   root.down ? B.Theme.palette.accent_1 : B.Theme.palette.accent
               ) : (
                   root.down ? B.Theme.palette.background_2 : (
                       root.hovered ? B.Theme.palette.background_1 : B.Theme.palette.background
                   )
               )
        radius: !root._round ? 8 : Math.max(width, height)/2
        border.color: B.Theme.palette.background_1
        border.width: order === Button.Order.Secondary && !root.down && !root.hovered ? 2 : 0

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
