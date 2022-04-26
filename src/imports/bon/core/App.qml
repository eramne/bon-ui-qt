import QtQuick
import QtQuick.Window
import Qt5Compat.GraphicalEffects
import QtQuick.Templates as T
import bon as B

T.ApplicationWindow {
    id: root
    color: B.Theme.palette.background
    property bool dim: false
    default property alias contents: content.children
    property B.NavigationRail navRail

    B.Fonts {}

    Item {
        id: mainViewContainer
        anchors.fill: parent

        Item {
            id: navRailContainer
            width: 100
            height: parent.height
            visible: root.navRail
            Item {
                anchors.fill: parent
                anchors.margins: 20
                children: [root.navRail]
            }
        }

        Item {
            id: content
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: root.navRail ? navRailContainer.right : parent.left
            anchors.margins: 0
        }
    }

    Item {
        anchors.fill: parent
        visible: root.dim || opacityAnimation.running

        ShaderEffectSource {
            id: blurSource
            anchors.fill: parent
            hideSource: root.dim || opacityAnimation.running
            sourceItem: mainViewContainer
            visible: false
        }

        FastBlur {
            id: blurEffect
            anchors.fill: parent
            source: blurSource
            radius: root.dim ? 32 : 0
            visible: true
            Behavior on radius {
                NumberAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
        }

        Rectangle {
            id: modalRect
            anchors.fill: parent
            color: B.Theme.palette.modal
            visible: true
            opacity: root.dim ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    id: opacityAnimation
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }
        }
    }

    property alias toastContainer: _toastContainer
    property alias toastTimer: _toastTimer
    Item {
        id: _toastContainer
        x: parent.width/2 - width/2
        y: parent.height-height-20
        width: Math.min(root.width-40, 400)
        height: 100

        property list<B.Toast> tmpQueue;

        function showNewToast() {
            if (root.toastQueue.length > 0) {
                root.toastQueue[0].open();
                _toastTimer.start();
            }
        }

        function hideToast() {
            //hide visible toast
            root.toastQueue[0]._hide();
            root.toastQueue[0]._awaiting = false;

            //sort queue
            tmpQueue = [];
            for (let targetPriority = 1; targetPriority <= 9; targetPriority++) {
                for (let i = 1; i < root.toastQueue.length; i++) {
                    if (root.toastQueue[i].getPriority() === targetPriority) {
                        tmpQueue.push(root.toastQueue[i]);
                    }
                }
            }
            root.toastQueue = tmpQueue;

            if (root.toastQueue.length === 0) {
                _toastTimer.stop();
            }
        }

        Timer {
            id: _toastTimer
            interval: 5000

            onTriggered: {
                _toastContainer.hideToast();
            }
        }
    }
    property list<B.Toast> toastQueue;

}
