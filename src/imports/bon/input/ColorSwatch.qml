import QtQuick
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import bon as B

T.RadioButton {
    id: root

    implicitWidth: indicator.width + leftPadding + rightPadding
    implicitHeight: indicator.height + topPadding + bottomPadding

    hoverEnabled: enabled

    property color color: "transparent"

    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    padding: 0

    B.Elevation {
        anchors.fill: indicator
        radius: indicator.radius
        elevation: root.down ? 1 : 2
        z: -1
    }

    indicator: Rectangle {
        width: 20;
        height: 20;

        x: root.text ? (root.mirrored ? root.width - width - root.rightPadding : root.leftPadding) : root.leftPadding + (root.availableWidth - width) / 2
        y: root.topPadding + (root.availableHeight - height) / 2

        radius: Math.max(width,height)/2
        color: root.color

        border.width: root.checked ? (
                          root.pressed || root.hovered ? 6 : 4
                      ) : (
                          root.pressed || root.hovered ? 2 : 0
                      )
        border.color: root.pressed ? B.Theme.palette.accent_1 : B.Theme.palette.accent

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Behavior on border.width {
            animation: NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }
    }

    background: Rectangle {
        anchors.fill: indicator
        radius: indicator.radius
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
