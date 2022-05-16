import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Templates as T
import bon as B

T.Popup {
    id: root
    modal: true
    width: 400
    height: contentItem.implicitHeight
    parent: T.Overlay.overlay
    x: Math.round((parent.width - width) / 2)
    y: !visible ? parent.height : Math.round((parent.height - height) / 2)

    required property string title
    required property string description
    required property list<B.Button> actions
    property B.Iconprop icon: B.Iconprop {}

    Behavior on y {
        animation: NumberAnimation {
            duration: B.Theme.animations.dialog.duration;
            easing.type: B.Theme.animations.dialog.type;
        }
    }

    contentItem: ColumnLayout {
        width: root.width

        ColumnLayout {
            width: parent.width
            spacing: 0
            Layout.margins: 10

            RowLayout {
                spacing: 15
                Layout.leftMargin: 16
                Layout.rightMargin: 16
                Layout.topMargin: 8
                Layout.fillWidth: true

                B.HeadingText {
                    text: root.title
                    lines: 2
                    Layout.alignment: Qt.AlignLeft
                    Layout.fillWidth: true
                }

                B.Icon {
                    Layout.alignment: Qt.AlignRight
                    name: root.icon.name
                    color: B.Theme.palette.text.label
                }
            }

            B.LabelText {
                text: root.description
                Layout.fillWidth: true
                Layout.leftMargin: 16
                Layout.rightMargin: 16
                Layout.bottomMargin: 8
            }

            RowLayout {
                spacing: 10
                children: root.actions
                Layout.alignment: Qt.AlignRight
                visible: root.actions.length > 0
            }
        }
    }

    onVisibleChanged: {
        T.ApplicationWindow.window.dim = root.visible
    }

    background: B.Pane {
        elevation: 24
        anchors.fill: parent
    }
}
