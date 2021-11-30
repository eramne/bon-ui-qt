import QtQuick
import QtQuick.Controls as C
import bon as Bon

Flickable {
    id: root
    contentWidth: content.childrenRect.width
    contentHeight: content.childrenRect.height
    boundsBehavior: Flickable.DragOverBounds
    clip: true

    default property alias children: content.children

    C.ScrollBar.vertical: Bon.ScrollBar { }
    C.ScrollBar.horizontal: Bon.ScrollBar { }

    property real margins: 10

    leftMargin: margins
    topMargin: margins
    rightMargin: margins
    bottomMargin: margins

    Item {
        id: content
    }
}
