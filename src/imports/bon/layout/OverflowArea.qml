import QtQuick
import bon as B

Flickable {
    id: root
    contentWidth: content.childrenRect.width
    contentHeight: content.childrenRect.height
    boundsBehavior: Flickable.DragOverBounds
    flickableDirection: Flickable.AutoFlickIfNeeded
    clip: true

    default property alias children: content.children

    B.ScrollBar.vertical: B.ScrollBar { }
    B.ScrollBar.horizontal: B.ScrollBar { }

    property real margins: 10

    leftMargin: margins
    topMargin: margins
    rightMargin: margins
    bottomMargin: margins

    maximumFlickVelocity: 4000

    Item {
        id: content
    }
}
