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

    leftPadding: 10
    rightPadding: 10

    hoverEnabled: enabled

    property color _textColor: checked ? (
                                   Theme.palette.text.label_dark
                               ) : (
                                   Theme.palette.text.label
                               )
    property real _textOpacity: root.down || root.hovered || !root.enabled ? Theme.highlight_hover_opacity : 1
    property color _backgroundColor: checked ? (
                                         root.down ? Theme.palette.accent_1 : Theme.palette.accent
                                     ) : (
                                         root.down ? Theme.palette.background_2 : (
                                             root.hovered ? Theme.palette.background_1 : Theme.palette.background
                                         )
                                     )
    property color _borderColor: Theme.palette.background_1
    property real _borderWidth: !checked && !root.down && !root.hovered ? 2 : 0
    property real _radius: Math.max(width, height)/2
    property real _elevation: checked ? (
                                  root.down ? 1 : 2
                              ) : 0

    height: 34
    opacity: !root.enabled ? Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

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

    background: Rectangle {
        anchors.fill: root
        color: _backgroundColor
        radius: _radius
        border.color: _borderColor
        border.width: _borderWidth
    }
}
