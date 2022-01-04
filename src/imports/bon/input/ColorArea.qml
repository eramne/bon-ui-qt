import QtQuick
import QtQuick.Templates as T
import bon as B

T.Control {
    id: root

    width: 220
    height: 220

    property color color: Qt.hsva(hue, saturation, value, 1);
    property real hue: 0

    property real saturation: 0
    property real value: 0

    property point _position: Qt.point(saturation, 1-value)
    property alias position: root._position //using a private variable and an alias to make it read-only

    property bool pressed: mouseArea.pressed

    Item {
        id: handle
        x: (root.position.x * root.width) - width/2
        y: (root.position.y * root.height) - height/2
        width: 16
        height: 16

        B.Elevation {
            anchors.fill: indicator
            radius: indicator.radius
            elevation: root.pressed ? 1 : 2
            z: -1
        }

        Rectangle {
            id: indicator
            anchors.fill: parent
            color: root.color
            radius: Math.max(width,height)/2;

            border.width: mouseArea.containsMouse && !root.pressed ? 4 : 2
            border.color: Qt.hsla(0,0,((1-root.color.hslLightness)*root.color.a) > 0.3 ? 1 : 0,root.pressed ? 0.8 : 1)

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
        radius: 8
        layer.enabled: true
        layer.effect: ShaderEffect {
            anchors.fill: parent
            property real hue: root.color.hsvHue

            fragmentShader: '../effects/colorareagradient.frag.qsb'
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        hoverEnabled: true
        preventStealing: true

        onPositionChanged: function (mouse) {
            if (pressed) {
                setHandlePos(mouse);
            }
        }

        onPressed: function (mouse) {
            if (pressed) {
                setHandlePos(mouse);
            }
        }

        function setHandlePos(mouse) {
            var s = mouse.x/width;
            var v = 1 - mouse.y/height;
            if (s < 0) {
                s = 0;
            }
            if (s > 1) {
                s = 1;
            }
            if (v < 0) {
                v = 0;
            }
            if (v > 1) {
                v = 1;
            }
            root.saturation = s;
            root.value = v;
        }
    }
}
