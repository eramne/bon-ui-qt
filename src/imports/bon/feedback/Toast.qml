import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

T.Popup {
    id: root
    width: Math.min(layout.implicitWidth, parent.width)
    height: Math.min(layout.implicitHeight, parent.height)
    parent: T.ApplicationWindow.window.toastContainer
    x: parent.width/2-width/2
    y: !_shown ? parent.height+height/2 : parent.height-height
    closePolicy: T.Popup.NoAutoClose

    required property string text
    property B.Button action
    property B.Iconprop icon: B.Iconprop {}
    property int variant: Toast.Variant.Neutral
    property bool _shown: false
    property bool _awaiting: false

    function getPriority() {
        return (action && variant === Toast.Variant.Error) ? 1 :        //Actionable, Error:    Priority 1
                   (variant === Toast.Variant.Error) ? 2 :              //Error:                Priority 2
                   (action && variant === Toast.Variant.Success) ? 3 :  //Actionable, Success:  Priority 3
                   (action && variant === Toast.Variant.Info) ? 4 :     //Actionable, Info:     Priority 4
                   (action && variant === Toast.Variant.Neutral) ? 5 :  //Actionable, Neutral:  Priority 5
                   (variant === Toast.Variant.Success) ? 6 :            //Success:              Priority 6
                   (variant === Toast.Variant.Info) ? 7 :               //Info:                 Priority 7
                   (variant === Toast.Variant.Neutral) ? 8 : 9;         //Neutral:              Priority 8
    }

    enum Variant {
        Neutral,
        Info,
        Success,
        Error
    }

    function _hide() {
        _shown = false;
        hideAnimation.start();
    }

    function queue() {
        if (!_awaiting) {
            T.ApplicationWindow.window.toastQueue.push(root);
            if (!T.ApplicationWindow.window.toastTimer.running) {
                T.ApplicationWindow.window.toastContainer.showNewToast();
            }

            _awaiting = true;
        }
    }

    onOpened: {
        _shown = true;
        showAnimation.start();
    }

    NumberAnimation on y {
        id: showAnimation
        from: parent.height+height/2
        to: parent.height-height
        duration: B.Theme.animations.dialog.duration;
        easing.type: B.Theme.animations.dialog.type;
    }

    NumberAnimation on y {
        id: hideAnimation
        from: parent.height-height
        to: parent.height+height/2
        duration: B.Theme.animations.dialog.duration;
        easing.type: B.Theme.animations.dialog.type;

        onFinished: {
            if (!root._shown && root.visible) {
                root.T.ApplicationWindow.window.toastContainer.showNewToast();
                root.close();
            }
        }
    }


    contentItem: Item {
        id: container
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            onClicked: {
                T.ApplicationWindow.window.toastContainer.hideToast();
            }
        }

        ColumnLayout {
            id: layout
            Layout.maximumWidth: root.parent.width
            Layout.maximumHeight: root.parent.height

            RowLayout {
                spacing: 0
                Layout.margins: 2

                RowLayout {
                    spacing: 10
                    Layout.leftMargin: 16;
                    Layout.rightMargin: 16;
                    Layout.topMargin: 8;
                    Layout.bottomMargin: 8;
                    Layout.fillWidth: true

                    B.Icon {
                        Layout.alignment: Qt.AlignRight
                        name: root.icon.name
                        visible: root.icon.name
                        color: root.variant === Toast.Variant.Neutral ? B.Theme.palette.text.label : root.background.borderColor
                    }

                    B.LabelText {
                        text: root.text
                        lines: 2
                        Layout.fillWidth: true
                    }
                }

                RowLayout {
                    spacing: 0
                    children: [root.action]
                    visible: root.action
                }
            }
        }
    }

    background: B.Pane {
        elevation: 6
        anchors.fill: parent

        borderWidth: variant !== Toast.Variant.Neutral ? 2 : 0
        borderColor: variant === Toast.Variant.Info ? B.Theme.palette.info :
                         variant === Toast.Variant.Success ? B.Theme.palette.success :
                         variant === Toast.Variant.Error ? B.Theme.palette.error : "transparent"
    }
}
