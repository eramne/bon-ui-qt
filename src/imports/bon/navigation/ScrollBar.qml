import QtQuick
import QtQuick.Templates as T
import bon as B

T.ScrollBar {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 4
    visible: root.policy !== T.ScrollBar.AlwaysOff && (root.policy === T.ScrollBar.AsNeeded ? root.size < 1 : true)
    minimumSize: orientation === Qt.Horizontal ? height / width : width / height

    opacity: root.active ? 1 : 0.0
    layer.enabled: opacity < 1

    Behavior on opacity {
        animation: NumberAnimation {
            duration: B.Theme.animations.basic.duration
            easing.type: B.Theme.animations.basic.type
        }
    }

    B.Elevation {
        anchors.fill: contentItem
        radius: contentItem.radius
        elevation: 2
        z: -1
    }

    contentItem: Rectangle {
        implicitWidth: 4
        implicitHeight: 4

        radius: 2
        color: root.pressed ? B.Theme.palette.background_2 : B.Theme.palette.background_1


        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }
    }
}
