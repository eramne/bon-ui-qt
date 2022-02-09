import QtQuick
import QtQuick.Templates as T
import bon as B

T.Pane {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: 10

    width: 200
    height: 200

    property real elevation: 4
    property real radius: 8
    property color color: B.Theme.palette.background

    background: Item {

        B.Elevation {
            elevation: root.elevation
            anchors.fill: parent
            radius: root.radius
        }

        Rectangle {
            anchors.fill: parent
            radius: root.radius
            color: root.color
        }
    }
}
