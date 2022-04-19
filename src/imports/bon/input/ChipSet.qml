import QtQuick
import QtQuick.Layouts
import bon as B

B.OverflowArea {
    id: root
    width: 400
    height: layout.implicitHeight
    margins: 0
    showScrollBars: false

    default property list<Item> chips
    property int variant: Chip.Type.Action
    property bool overflow: false
    property bool exclusive: false
    
    Flow {
        id: layout
        spacing: 10
        width: root.overflow ? childrenRect.implicitWidth : root.width
        //height: root.overflow ? implicitHeight : implicitHeight
        children: root.chips
    }
}
