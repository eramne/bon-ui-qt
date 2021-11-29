import QtQuick
import QtQuick.Templates as T
import bon as Bon

Bon.Popup {
    id: root
    property Item target: parent

    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    y: outOfBounds(x, target.height + 10 + height) ? target.height + 10 : -height - 10;
    closePolicy: T.Popup.CloseOnPressOutsideParent

    function updatePopupPos() {
        y = outOfBounds(x, target.height + 10 + height) ? target.height + 10 : -height - 10;
        contentItem.height = Math.min(target.maxContentHeight, contentItem.contentHeight);
    }

    onAboutToShow: {
        updatePopupPos();
    }

    Behavior on y {
        enabled: root.opened
        animation: NumberAnimation {
            duration: _duration;
            easing.type: _easing;
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
