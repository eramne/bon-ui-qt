import QtQuick
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import bon as B

T.Slider {
    id: root
    width: 220
    height: 20

    from: 0
    to: 1

    property color color: "transparent"
    property Gradient gradient: Gradient {
        orientation: Gradient.Horizontal

        GradientStop { position: 0; color: Qt.hsva(0,0,0,0) }
        GradientStop { position: 1; color: Qt.hsva(0,0,0,0) }
    }

    B.Elevation {
        anchors.fill: handle
        radius: handle.radius
        elevation: root.pressed ? 1 : 2
        z: -1
    }

    handle: Rectangle {
        radius: 8
        width: 16
        height: 16
        x: (root.position * (root.width-root.height)) + (root.height - width)/2
        anchors.verticalCenter: parent.verticalCenter

        color: "white"

        Image {
            anchors.fill: parent
            id: checkerboardImage2
            fillMode: Image.Tile

            source: "../assets/checkerboard.svg"
            visible: false
        }

        Rectangle {
            id: maskRect2
            anchors.fill: parent
            color: "black"
            radius: parent.radius
        }

        ShaderEffectSource {
            id: maskRectSource2
            anchors.fill: maskRect2
            sourceItem: maskRect2
            hideSource: true
            visible: false
        }

        OpacityMask {
            anchors.fill: checkerboardImage2
            source: checkerboardImage2
            maskSource: maskRectSource2
            opacity: 0.125
        }

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            border.width: root.hovered && !root.pressed ? 4 : 2
            border.color: Qt.hsla(0,0,((1-root.color.hslLightness)*root.color.a) > 0.3 ? 1 : 0,root.pressed ? 0.8 : 1)
            color: root.color

            Behavior on border.width {
                NumberAnimation {
                    duration: B.Theme.animations.basic.duration;
                    easing.type: B.Theme.animations.basic.type;
                }
            }

            Behavior on border.color {
                ColorAnimation {
                    duration: B.Theme.animations.basic.duration;
                    easing.type: B.Theme.animations.basic.type;
                }
            }
        }
    }

    background: Rectangle {
        anchors.fill: parent
        radius: height/2
        color: "white"

        Image {
            anchors.fill: parent
            id: checkerboardImage
            fillMode: Image.Tile

            source: "../assets/checkerboard.svg"
            visible: false
        }

        Rectangle {
            id: maskRect
            anchors.fill: parent
            color: "black"
            radius: parent.radius
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

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            gradient: root.gradient
        }
    }
}
