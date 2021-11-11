import QtQuick 2.0

Item {
    id: icon
    property string name: "settings"
    property real size: 24
    property color color: "black"
    width: size
    height: size

    Text {
        anchors.fill: icon
        text: __app__.icons[icon.name]
        font.family: "Material Icons Round"
        font.pixelSize: icon.size
        color: icon.color
    }
}
