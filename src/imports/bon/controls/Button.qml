import QtQuick 2.0
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as Bon

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
                                   __app__.style.palette.text.label_dark
                               ) : (
                                   __app__.style.palette.text.label
                               )
    property real _textOpacity: root.down || root.hovered || !root.enabled ? __app__.style.palette.controls.highlight_1.a : 1
    property color _backgroundColor: order === 1 ? (
                                         root.down ? __app__.style.palette.controls.accent_1 : __app__.style.palette.controls.accent
                                     ) : (
                                         root.down ? __app__.style.palette.controls.background_1 : (
                                             root.hovered ? __app__.style.palette.controls.background : __app__.style.palette.background
                                         )
                                     )
    property color _borderColor: __app__.style.palette.controls.background
    property real _borderWidth: order === 2 && !root.down && !root.hovered ? 2 : 0
    property real _radius: !_round ? 8 : Math.max(width, height)/2
    property real _elevation: order === 1 ? (
                                  root.down ? 1 : 2
                              ) : 0
    property real _height: 40
    property real _opacity: !root.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration
    property bool _round: root.text.length === 0

    width: root.text.length > 0 ? contentItem.width + leftPadding + rightPadding : _height
    height: _height
    opacity: _opacity
    layer.enabled: !root.enabled

    property int order: 1 // 1 = primary, 2 = secondary, 3 or anything else = tertiary

    Behavior on _backgroundColor {
        ColorAnimation {
            duration: _duration;
            easing.type: _easing
        }
    }

    Behavior on _textOpacity {
        NumberAnimation {
            duration: _duration;
            easing.type: _easing
        }
    }

    Behavior on _borderWidth {
        NumberAnimation {
            duration: _duration;
            easing.type: _easing
        }
    }

    Bon.Elevation {
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

        Bon.Icon {
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
            font: __app__.style.text.button
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
