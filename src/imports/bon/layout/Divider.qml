import QtQuick
import QtQuick.Layouts
import bon

Item {
    id: root
    property string name: ""
    property real leftInset: 0
    property real rightInset: 0
    property real textInset: -leftInset
    height: layout.implicitHeight

    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: root.leftInset
        anchors.rightMargin: root.rightInset

        Layout.topMargin: 10
        Layout.bottomMargin: 10
        spacing: 4

        Rectangle {
            Layout.fillWidth: true
            height: 2
            color: Theme.palette.background_1
        }

        Text {
            Layout.leftMargin: root.textInset
            visible: root.name
            text: root.name
            font: Theme.text.caption
            color: Theme.palette.text.label
        }
    }
}