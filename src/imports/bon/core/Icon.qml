import QtQuick 2.0

Item {
    id: root
    property string name: "settings"
    property real size: 24
    property color color: "black"
    property bool isValid: (__app__.icons[root.name] ?? "").length > 0
    width: size
    height: size

    Text {
        anchors.fill: root
        text: __app__.icons[root.name] ?? "\u0000"
        font.family: "Material Icons Round"
        font.pixelSize: root.size
        color: root.color
    }
}
