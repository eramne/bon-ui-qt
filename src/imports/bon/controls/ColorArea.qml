import QtQuick
import QtQuick.Templates as T
import bon

T.Control {
    id: control

    width: 220
    height: 220

    property color color: Qt.hsva(0,0.5,0.5,1)

    property point _position: Qt.point(control.color.hsvSaturation, 1-control.color.hsvValue)
    property alias position: control._position

    property bool pressed: mouseArea.pressed

    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    Item {
        id: handle
        x: (control.position.x * control.width) - width/2
        y: (control.position.y * control.height) - height/2
        width: 16
        height: 16

        Elevation {
            anchors.fill: indicator
            radius: indicator.radius
            elevation: control.pressed ? 1 : 2
            z: -1
        }

        Rectangle {
            id: indicator
            anchors.fill: parent
            color: control.color
            radius: Math.max(width,height)/2;

            border.width: mouseArea.containsMouse && !control.pressed ? 4 : 2
            //border.color: control.pressed ? __app__.style.palette.controls.highlight_1 : __app__.style.palette.controls.highlight
            border.color: Qt.hsla(0,0,((1-control.color.hslLightness)*control.color.a) > 0.3 ? 1 : 0,control.pressed ? 0.8 : 1)

            Behavior on border.width {
                NumberAnimation {
                    duration: _duration;
                    easing.type: _easing;
                }
            }

            Behavior on border.color {
                ColorAnimation {
                    duration: _duration;
                    easing.type: _easing;
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
            property real hue: control.color.hsvHue

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
            control.color.hsvSaturation = s;
            control.color.hsvValue = v;
        }
    }
}
