import QtQuick
import bon as B

Item {
    id: root
    property real elevation: 1
    property real radius: 0

    Rectangle {
        width: parent.width + glowRadius*2
        height: parent.height + glowRadius*2
        x: 0 - glowRadius
        y: 0 - glowRadius
        color: B.Theme.palette.elevation
        opacity: 0.1
        property real glowRadius: elevation*1/5
        radius: root.radius + glowRadius
        visible: elevation > 0

        Behavior on glowRadius {
            NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }
    }

    Rectangle {
        color: B.Theme.palette.elevation
        width: parent.width + glowRadius*2
        height: parent.height + glowRadius*2
        x: 0 - glowRadius
        y: elevation*(2/5) - glowRadius
        opacity: (-1/(elevation/100 + 1)+1)
        property real glowRadius: elevation*2/3
        radius: root.radius + glowRadius
        visible: elevation > 0

        Behavior on glowRadius {
            NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }
    }

    Rectangle {
        color: B.Theme.palette.elevation
        width: parent.width + glowRadius*2
        height: parent.height + glowRadius*2
        x: 0 - glowRadius
        y: elevation - glowRadius
        opacity: 0.05
        property real glowRadius: elevation*6/5
        radius: root.radius + glowRadius
        visible: elevation > 0

        Behavior on y {
            NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Behavior on glowRadius {
            NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }
    }
}
