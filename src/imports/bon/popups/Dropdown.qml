import QtQuick
import QtQuick.Templates as T
import bon

Popup {
    id: root
    property Item target: parent

    y: outOfBounds(x, target.height + 10 + height) ? target.height + 10 : -height - 10;
    closePolicy: T.Popup.CloseOnPressOutsideParent

    function updatePopupPos() {
        y = outOfBounds(x, target.height + 10 + height) ? target.height + 10 : -height - 10;
    }

    onAboutToShow: {
        updatePopupPos();
    }

    Behavior on y {
        enabled: root.opened
        animation: NumberAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }

    Timer {
        repeat: true
        running: root.opened
        triggeredOnStart: true
        interval: 100
        onTriggered: {
            root.updatePopupPos();
        }
    }
}
