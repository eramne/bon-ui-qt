import QtQuick 2.0
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property real elevation: 1
    property real radius: 0

    property real _easing: Easing.OutQuad
    property real _duration: 100

    RectangularGlow {
        width: parent.width
        height: parent.height
        x: 0
        y: 0
        color: "#986578"
        spread: 0.95
        opacity: 0.1
        glowRadius: elevation*1/5
        cornerRadius: root.radius + glowRadius

        Behavior on glowRadius {
            NumberAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }
    }

    RectangularGlow {
        color: "#986578"
        width: parent.width
        height: parent.height
        x: 0
        y: elevation*(2/5)
        spread: 0.95
        opacity: (-1/(elevation/100 + 1)+1)
        glowRadius: elevation*2/3
        cornerRadius: root.radius + glowRadius

        Behavior on glowRadius {
            NumberAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }
    }

    RectangularGlow {
        color: "#986578"
        width: parent.width
        height: parent.height
        x: 0
        y: elevation
        spread: 0.95
        opacity: 0.05
        glowRadius: elevation*6/5
        cornerRadius: root.radius + glowRadius

        Behavior on y {
            NumberAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }

        Behavior on glowRadius {
            NumberAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }
    }
}
