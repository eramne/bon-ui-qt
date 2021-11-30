import QtQuick
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import bon

T.RadioButton {
    id: root

    implicitWidth: indicator.width + leftPadding + rightPadding
    implicitHeight: indicator.height + topPadding + bottomPadding

    hoverEnabled: enabled

    property real _width: 20
    property real _height: 20
    property real _radius: Math.max(_width, _height)
    property color color: "transparent"
    property real _opacity: !root.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property color _borderColor: root.pressed ? __app__.style.palette.controls.accent_1 : __app__.style.palette.controls.accent
    property real _borderWidth: root.checked ? (
                                    root.pressed || root.hovered ? 6 : 4
                                ) : (
                                    root.pressed || root.hovered ? 2 : 0
                                )
    property real _padding: 0
    property real _elevation: root.down ? 1 : 2;
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    opacity: _opacity
    layer.enabled: !root.enabled

    padding: _padding

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
        color: root.color

        border.width: _borderWidth
        border.color: _borderColor

        Behavior on color {
            ColorAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }

        Behavior on border.width {
            animation: NumberAnimation {
                duration: _duration;
                easing.type: _easing;
            }
        }
    }

    background: Rectangle {
        anchors.fill: indicator
        color: "white"

        Image {
            anchors.fill: parent
            id: checkerboardImage

            source: "../assets/checkerboard.svg"
            visible: false
        }

        Rectangle {
            id: maskRect
            anchors.fill: parent
            color: "black"
            radius: indicator.radius
        }

        ShaderEffectSource {
            id: maskRectSource
            anchors.fill: maskRect
            sourceItem: maskRect
            hideSource: true
            visible: false
        }

        OpacityMask {
            anchors.fill: checkerboardImage
            source: checkerboardImage
            maskSource: maskRectSource
            opacity: 0.25
        }
    }
}
