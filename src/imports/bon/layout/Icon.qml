import QtQuick
import bon as B

Item {
    id: root
    property string name: "settings"
    property real size: 24
    property bool dark: false
    property color color: !dark ? B.Theme.palette.text.label : B.Theme.palette.text.label_dark
    property bool isValid: name === "blank" || (B.Utils.icons[root.name] ?? "").length > 0
    width: size
    height: size

    Component {
        id: textComponent
        Text {
            anchors.fill: root
            text: root.name === "blank" ? "" : (B.Utils.icons[root.name] ?? "\u0000")
            font.family: "Material Icons Round"
            font.pixelSize: root.size
            color: root.color
        }
    }

    Component.onCompleted: {
        //textComponent.incubateObject(root);
    }
}
