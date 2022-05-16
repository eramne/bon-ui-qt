import QtQuick
import QtQuick.Layouts
import bon as B

B.Pane {
    id: root
    visible: false
    elevation: 2
    height: layout.implicitHeight
    width: 500
    padding: 0

    required property string title
    required property string description
    property list<B.Button> actions
    //property string icon: ""
    property B.Iconprop icon: B.Iconprop {}

    property int variant: Alert.Variant.Neutral

    borderWidth: variant !== Alert.Variant.Neutral ? 2 : 0
    borderColor: variant === Alert.Variant.Info ? B.Theme.palette.info :
                     variant === Alert.Variant.Success ? B.Theme.palette.success :
                     variant === Alert.Variant.Warning ? B.Theme.palette.warning :
                     variant === Alert.Variant.Error ? B.Theme.palette.error : "transparent"

    function open() {
        root.visible = true;
    }
    function close() {
        root.visible = false;
    }

    enum Variant {
        Neutral,
        Info,
        Success,
        Warning,
        Error
    }

    ColumnLayout {
        id: layout
        width: parent.width

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
                    color: root.variant === Alert.Variant.Neutral ? B.Theme.palette.text.label : root.borderColor
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
                //height: implicitHeight
                Layout.alignment: Qt.AlignRight
                visible: root.actions.length > 0
            }
        }
    }
}
