import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import QtQuick.Shapes
import bon as B

T.ToolTip {
    id: root

    x: parent ? (parent.width - implicitWidth) / 2 : 0
    y: -implicitHeight - 12
    clip: false
    implicitWidth: Math.min(layout.implicitWidth,200)
    implicitHeight: layout.implicitHeight
    property bool _above: !(y > parent.height)
    margins: 20

    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent | T.Popup.CloseOnReleaseOutsideParent

    contentItem: RowLayout {
        id: layout
        width: parent.width

        Text {
            Layout.leftMargin: 12
            Layout.rightMargin: 12
            Layout.topMargin: 8
            Layout.bottomMargin: 8
            Layout.fillWidth: true

            text: root.text
            font: B.Theme.text.caption
            color: B.Theme.palette.text.label_dark
            wrapMode: Text.Wrap
            //horizontalAlignment: Text.AlignHCenter
            //verticalAlignment: Text.AlignVCenter
        }
    }

    background: B.Pane {
        anchors.fill: parent
        color: B.Theme.palette.accent
        elevation: 2
        radius: 4
        padding: 0
        clip: false

        Shape {
            x: root.parent.width/2 - root.x - width/2
            y: root._above ? parent.height : -height
            width: 10
            height: 10

            layer.enabled: true
            layer.samples: 8

            ShapePath {
                fillColor: B.Theme.palette.accent
                strokeWidth: -1
                startX: 5
                startY: 5
                PathLine { x: 10; y: root._above ? 0 : 10 }
                PathLine { x: 0; y: root._above ? 0 : 10 }
                PathLine { x: 5; y: 5 }
            }
        }
    }
}
