import QtQuick
import QtQuick.Templates as T
import QtQuick.Window
import bon as B

T.Popup {
    id: root
    margins: 10
    property real targetX: 0
    property real targetY: 0
    property real targetWidth: contentItem.width
    property real targetHeight: contentItem.height
    x: targetX
    y: targetY
    width: Math.min(targetWidth, maxWidth)
    height: Math.min(targetHeight, maxHeight)
    property real maxWidth: (parent?.Window?.width??0) - leftMargin - rightMargin
    property real maxHeight: (parent?.Window?.height??0) - topMargin - bottomMargin

    function outOfBounds(x, y) {
        if (parent?.Window?.window) {
            var pos = parent.mapToGlobal(x,y);
            var windowPos = parent.Window.window.contentItem.mapToGlobal(0,0);
            var windowWidth = parent.Window.width;
            var windowHeight = parent.Window.height;
            if (pos.x < windowPos.x + leftMargin) {
                return false;
            }
            if (pos.x > windowPos.x + windowWidth - rightMargin) {
                return false;
            }
            if (pos.y < windowPos.y + topMargin) {
                return false;
            }
            if (pos.y > windowPos.y + windowHeight - bottomMargin) {
                return false;
            }
            return true;
        } else {
            return false;
        }
    }

    background: B.Pane {
        elevation: 8
        width: root.targetWidth
        height: root.targetHeight
    }
}
