import QtQuick
import bon as B

Item {
    id: root
    anchors.fill: parent
    default property list<QtObject> actions

    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        acceptedButtons: Qt.RightButton
        onClicked: function (mouse) {
            menu.targetX = mouse.x;
            menu.targetY = mouse.y;
            menu.open();
        }
    }

    B.Menu {
        id: menu
        autoAdjustPositionAroundTarget: false
        actions: root.actions
    }
}
