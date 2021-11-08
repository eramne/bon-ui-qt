import QtQuick
import QtQuick.Templates as T
import bon

T.Switch {
    id: control

    implicitWidth: indicator.width + leftPadding + rightPadding
    implicitHeight: indicator.height + topPadding + bottomPadding

    property real _width: 40
    property real _height: 20
    property real _radius: Math.max(_width, _height)
    property color _backgroundColor: !control.checked ? (
                                         control.pressed ? __app__.style.palette.controls.background_1 : __app__.style.palette.controls.background
                                     ) : (
                                         control.pressed ? __app__.style.palette.controls.accent_1 : __app__.style.palette.controls.accent
                                     )
    property real _opacity: !control.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property color _borderColor: "#000000"
    property real _borderWidth: 0
    property real _thumbWidth: 16 + (control.pressed ? (_pressedThumbWidthAdjust) : 0)
    property real _thumbHeight: 16
    property real _pressedThumbWidthAdjust: 8
    property color _thumbColor: control.enabled && !control.hovered && !control.pressed ? __app__.style.palette.controls.highlight : __app__.style.palette.controls.highlight_1
    property real _thumbRadius: Math.max(_thumbWidth, _thumbHeight)
    property real _padding: 0
    property real _elevation: !control.pressed && control.checked ? 1 : 0
    property real _thumbElevation: control.pressed ? 1 : 2
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    padding: _padding+Math.max(Math.max(0,thumb.width-indicator.width),Math.max(0,thumb.height-indicator.height))

    hoverEnabled: enabled

    Elevation {
        anchors.fill: indicator
        radius: indicator.radius
        elevation: _elevation
        z: -1
    }

    indicator: Rectangle {
        width: control._width;
        height: control._height;

        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        radius: _radius
        color: _backgroundColor
        opacity: _opacity;

        border.width: _borderWidth
        border.color: _borderColor

        Behavior on color {
            ColorAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }

        property int thumbPadding: (height - thumb.height)/2

        Elevation {
            anchors.fill: thumb
            radius: thumb.radius
            elevation: _thumbElevation
        }

        Rectangle {
            id: thumb
            x: (control.visualPosition * ((parent.width-(parent.thumbPadding*2)) - tmpWidth)) + parent.thumbPadding
            y: (parent.height - height) / 2
            width: tmpWidth
            height: _thumbHeight
            radius: _thumbRadius
            color: _thumbColor;

            property real tmpWidth: _thumbWidth

            Behavior on color {
                ColorAnimation {
                    duration: _duration;
                    easing.type: _easing
                }
            }

            Behavior on x {
                enabled: control.focus;
                animation: NumberAnimation {
                    duration: _duration;
                    easing.type: _easing;
                }
            }
            Behavior on width {
                enabled: control.focus;
                animation: NumberAnimation {
                    duration: _duration;
                    easing.type: _easing;
                }
            }
        }
    }
}
