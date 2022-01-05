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

    property real elevation: 2
    property real radius: 8

    background: Item {

        B.Elevation {
            elevation: root.elevation
            anchors.fill: parent
            radius: root.radius
        }

        Rectangle {
            anchors.fill: parent
            radius: root.radius
            color: B.Theme.palette.background
        }
    }
}
