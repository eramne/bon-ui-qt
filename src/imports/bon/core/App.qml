import QtQuick
import QtQuick.Window
import Qt5Compat.GraphicalEffects
import QtQuick.Templates as T
import bon as B

T.ApplicationWindow {
    id: root
    color: B.Theme.palette.background
    property bool dim: false
    default property alias contents: content.children

    B.Fonts {}

    Item {
        anchors.fill: parent
        visible: root.dim || opacityAnimation.running

        ShaderEffectSource {
            id: blurSource
            anchors.fill: parent
            hideSource: root.dim || opacityAnimation.running
            sourceItem: content
            visible: false
        }

        FastBlur {
            id: blurEffect
            anchors.fill: parent
            source: blurSource
            radius: root.dim ? 32 : 0
            visible: true
            Behavior on radius {
                NumberAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
        }

        Rectangle {
            id: modalRect
            anchors.fill: parent
            color: B.Theme.palette.modal
            visible: true
            opacity: root.dim ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    id: opacityAnimation
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
        }
    }

    Item {
        id: content
        anchors.fill: parent
    }
}
