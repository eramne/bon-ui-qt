import QtQuick
import QtQuick.Templates as T
import bon as B

B.Popup {
    id: root
    property Item target: parent

    closePolicy: T.Popup.CloseOnPressOutsideParent

    property bool autoAdjustPositionAroundTarget: true

    x: targetX
    y: targetY

    function _updatePopupPos() {
        if (autoAdjustPositionAroundTarget) {
            y = Qt.binding(function () {return !outOfBounds(x, (target?.height??0) + 10 + height) ? (target?.height??0) + 10 : -height - 10;})
        }
    }
    Component.onCompleted: {
        if (autoAdjustPositionAroundTarget) {
            _updatePopupPos()
        }
    }

    onAboutToShow: {
        if (autoAdjustPositionAroundTarget) {
            _updatePopupPos()
        }
    }

    Timer {
        repeat: true
        running: root.opened && root.autoAdjustPositionAroundTarget
        triggeredOnStart: true
        interval: 100
        onTriggered: {
            if (root.autoAdjustPositionAroundTarget) {
                root._updatePopupPos()
            }
        }
    }
}
