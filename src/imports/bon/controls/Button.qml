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

    icon.color: _textColor
    icon.name: ""

    leftPadding: !_round ? 20 : 0
    rightPadding: !_round ? 20 : 0

    hoverEnabled: enabled

    property color _textColor: order === 1 ? (
                                   Theme.palette.text.label_dark
                               ) : (
                                   Theme.palette.text.label
                               )
    property real _textOpacity: root.down || root.hovered || !root.enabled ? Theme.highlight_hover_opacity : 1
    property color _backgroundColor: order === 1 ? (
                                         root.down ? Theme.palette.accent_1 : Theme.palette.accent
                                     ) : (
                                         root.down ? Theme.palette.background_2 : (
                                             root.hovered ? Theme.palette.background_1 : Theme.palette.background
                                         )
                                     )
    property color _borderColor: Theme.palette.background_1
    property real _borderWidth: order === 2 && !root.down && !root.hovered ? 2 : 0
    property real _radius: !_round ? 8 : Math.max(width, height)/2
    property real _elevation: order === 1 ? (
                                  root.down ? 1 : 2
                              ) : 0
    property bool _round: root.text.length === 0

    width: root.text.length > 0 ? contentItem.width + leftPadding + rightPadding : height
    height: 40

    opacity: !root.enabled ? Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    property int order: 1 // 1 = primary, 2 = secondary, 3 or anything else = tertiary

    Behavior on _backgroundColor {
        ColorAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }

    Behavior on _textOpacity {
        NumberAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }

    Behavior on _borderWidth {
        NumberAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }

    Elevation {
        anchors.fill: background
        radius: background.radius
        elevation: _elevation
        z: -1
    }

    contentItem: RowLayout {
        anchors.centerIn: root
        spacing: !_round ? 10 : 0
        height: root.height
        width: Layout.minimumWidth

        Icon {
            id: icon
            Layout.alignment: Qt.AlignCenter
            visible: isValid
            name: root.icon.name
            color: root.icon.color
            opacity: _textOpacity
        }

        Text {
            text: root.text
            Layout.alignment: Qt.AlignVCenter
            color: _textColor
            font: Theme.text.button
            opacity: _textOpacity
        }
    }

    background: Rectangle {
        anchors.fill: root
        color: _backgroundColor
        radius: _radius
        border.color: _borderColor
        border.width: _borderWidth
    }
}
