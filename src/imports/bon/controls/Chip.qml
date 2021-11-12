import QtQuick 2.0
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as Bon

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    icon.color: _textColor

    leftPadding: 10
    rightPadding: 10

    hoverEnabled: enabled

    property color _textColor: checked ? (
                                   __app__.style.palette.text.label_dark
                               ) : (
                                   __app__.style.palette.text.label
                               )
    property real _textOpacity: control.down || control.hovered || !control.enabled ? __app__.style.palette.controls.highlight_1.a : 1
    property color _backgroundColor: checked ? (
                                         control.down ? __app__.style.palette.controls.accent_1 : __app__.style.palette.controls.accent
                                     ) : (
                                         control.down ? __app__.style.palette.controls.background_1 : (
                                             control.hovered ? __app__.style.palette.controls.background : __app__.style.palette.background
                                         )
                                     )
    property color _borderColor: __app__.style.palette.controls.background
    property real _borderWidth: !checked && !control.down && !control.hovered ? 2 : 0
    property real _radius: Math.max(width, height)/2
    property real _elevation: checked ? (
                                  control.down ? 1 : 2
                              ) : 0
    property real _height: 34
    property real _opacity: !control.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    height: _height
    opacity: _opacity
    layer.enabled: !control.enabled

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

    background: Rectangle {
        anchors.fill: control
        color: _backgroundColor
        radius: _radius
        border.color: _borderColor
        border.width: _borderWidth
    }
}
