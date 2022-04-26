import QtQuick
import bon as B

QtObject {
    id: root
    property string icon: "article"
    property string label: ""
    property int notifications: -1
    property Component contents: Component { Item {} }
    property Item contentLoader: Loader {
        anchors.fill: parent
        active: false
        sourceComponent: root.contents
    }
    function loadPage(parent) {
        contentLoader.parent = parent;
        contentLoader.active = true;
    }
    function unloadPage() {
        contentLoader.active = false;
    }
}