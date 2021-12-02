import QtQuick
import QtQuick.Templates as T
import bon

T.Switch {
    id: root

    implicitWidth: indicator.width + leftPadding + rightPadding
    implicitHeight: indicator.height + topPadding + bottomPadding

    opacity: !root.enabled ? Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    property real _width: 40
    property real _height: 20
    property real _radius: Math.max(_width, _height)
    property color _backgroundColor: !root.checked ? (
                                         root.pressed ? Theme.palette.background_2 : Theme.palette.background_1
                                     ) : (
                                         root.pressed ? Theme.palette.accent_1 : Theme.palette.accent
                                     )
    property real _thumbWidth: 16 + (root.pressed ? (_pressedThumbWidthAdjust) : 0)
    property real _thumbHeight: 16
    property real _pressedThumbWidthAdjust: 8
    property color _thumbColor: root.enabled && !root.hovered && !root.pressed ? Theme.palette.highlight : Theme.palette.highlight_1
    property real _thumbRadius: Math.max(_thumbWidth, _thumbHeight)
    property real _padding: 0
    property real _elevation: !root.pressed && root.checked ? 1 : 0
    property real _thumbElevation: root.pressed ? 1 : 2

    padding: _padding+Math.max(Math.max(0,thumb.width-indicator.width),Math.max(0,thumb.height-indicator.height))

    hoverEnabled: enabled

    Elevation {
        anchors.fill: indicator
        radius: indicator.radius
        elevation: _elevation
        z: -1
    }

    indicator: Rectangle {
        width: root._width;
        height: root._height;

        x: root.text ? (root.mirrored ? root.width - width - root.rightPadding : root.leftPadding) : root.leftPadding + (root.availableWidth - width) / 2
        y: root.topPadding + (root.availableHeight - height) / 2

        radius: _radius
        color: _backgroundColor

        Behavior on color {
            ColorAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
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
            x: (root.visualPosition * ((parent.width-(parent.thumbPadding*2)) - tmpWidth)) + parent.thumbPadding
            y: (parent.height - height) / 2
            width: tmpWidth
            height: _thumbHeight
            radius: _thumbRadius
            color: _thumbColor;

            property real tmpWidth: _thumbWidth

            Behavior on color {
                ColorAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }

            Behavior on x {
                enabled: root.focus;
                animation: NumberAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
            Behavior on width {
                enabled: root.focus;
                animation: NumberAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
        }
    }
}
