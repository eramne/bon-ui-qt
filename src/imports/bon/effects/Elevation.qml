import QtQuick
import Qt5Compat.GraphicalEffects
import bon

Item {
    id: root
    property real elevation: 1
    property real radius: 0

    RectangularGlow {
        width: parent.width
        height: parent.height
        x: 0
        y: 0
        color: Theme.palette.elevation
        spread: 0.95
        opacity: 0.1
        glowRadius: elevation*1/5
        cornerRadius: root.radius + glowRadius
        visible: elevation > 0

        Behavior on glowRadius {
            NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }
    }

    RectangularGlow {
        color: Theme.palette.elevation
        width: parent.width
        height: parent.height
        x: 0
        y: elevation*(2/5)
        spread: 0.95
        opacity: (-1/(elevation/100 + 1)+1)
        glowRadius: elevation*2/3
        cornerRadius: root.radius + glowRadius
        visible: elevation > 0

        Behavior on glowRadius {
            NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }
    }

    RectangularGlow {
        color: Theme.palette.elevation
        width: parent.width
        height: parent.height
        x: 0
        y: elevation
        spread: 0.95
        opacity: 0.05
        glowRadius: elevation*6/5
        cornerRadius: root.radius + glowRadius
        visible: elevation > 0

        Behavior on y {
            NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Behavior on glowRadius {
            NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }
    }
}
