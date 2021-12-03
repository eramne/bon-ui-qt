import QtQuick
import QtQuick.Controls as C
import bon

Flickable {
    id: root
    contentWidth: content.childrenRect.width
    contentHeight: content.childrenRect.height
    boundsBehavior: Flickable.DragOverBounds
    clip: true

    default property alias children: content.children

    ScrollBar.vertical: ScrollBar { }
    ScrollBar.horizontal: ScrollBar { }

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
