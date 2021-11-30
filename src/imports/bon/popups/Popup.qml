import QtQuick
import QtQuick.Templates as T
import QtQuick.Window
import bon as Bon

T.Popup {
    id: root
    margins: 10
    property real _radius: 8
    property real targetX: 0
    property real targetY: 0
    property real targetWidth: contentItem.width
    property real targetHeight: contentItem.height
    x: targetX
    y: targetY
    width: Math.min(targetWidth, parent.Window.width - leftMargin - rightMargin)
    height: Math.min(targetHeight, parent.Window.height - topMargin - bottomMargin)

    function outOfBounds(x, y) {
        if (parent.Window.window) {
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

    background: Item {
        anchors.fill: parent

        Bon.Elevation {
            elevation: 8
            anchors.fill: parent
            radius: root._radius
        }

        Rectangle {
            anchors.fill: parent
            radius: root._radius
            color: __app__.style.palette.background
        }
    }
}
