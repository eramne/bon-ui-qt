import QtQuick
import QtQuick.Layouts
import bon as B

B.Pane {
    id: root

    height: layout.implicitHeight

    property string overline: ""
    property string title: ""
    property string subtitle: ""
    property string description: ""
    property list<Item> leftActions
    property list<Item> rightActions
    property list<Item> media
    property string header: ""
    property string subheader: ""
    property string headerIcon: ""
    property string headerAvatar: ""
    property B.Menu menu

    padding: 0

    ColumnLayout {
        id: layout
        width: parent.width

        ColumnLayout {
            Layout.fillWidth: true

            RowLayout {
                id: headerRow
                visible: root.header || root.headerAvatar || root.headerIcon || root.subheader
                spacing: 15
                Layout.fillWidth: true
                Layout.topMargin: 10
                Layout.bottomMargin: 10
                Layout.leftMargin: 20
                Layout.rightMargin: 20

                B.Icon {
                    visible: root.headerIcon
                    name: root.headerIcon ?? "";
                    size: 24
                }

                B.Avatar {
                    visible: root.headerAvatar && !root.headerIcon;
                    source: root.headerAvatar ?? "";
                }

                ColumnLayout {
                    spacing: 0
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    B.BodyText {
                        visible: parent.visible && root.header
                        text: root.header
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                        lines: 1
                    }

                    B.CaptionText {
                        visible: parent.visible && root.subheader
                        text: root.subheader
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                        lines: 2
                    }
                }

                B.Button {
                    id: menuButtonHeader
                    visible: parent.visible && root.menu
                    onReleased: {
                        root.menu.parent = menuButtonHeader;
                        root.menu.open()
                    }
                    icon.name: "more_horiz"
                    order: B.Button.Order.Tertiary
                }
            }

            Item {
                id: mediaContainer
                implicitHeight: mediaRow.implicitHeight
                visible: root.media.length > 0
                Layout.fillWidth: true

                RowLayout {
                    id: mediaRow
                    anchors.fill: parent
                    children: root.media
                }

                B.Button {
                    id: menuButtonMedia
                    visible: parent.visible && root.menu && !headerRow.visible
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: 20
                    anchors.rightMargin: 20
                    onReleased: {
                        root.menu.parent = menuButtonMedia;
                        root.menu.open()
                    }
                    icon.name: "more_horiz"
                    order: B.Button.Order.Tertiary
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.margins: 20
                Layout.topMargin: headerRow.visible && !mediaContainer.visible ? 0 : 20
                spacing: 10

                RowLayout {
                    visible: root.overline || root.title || root.subtitle
                    spacing: 10

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 0

                        B.OverlineText {
                            visible: root.overline
                            text: root.overline
                            Layout.fillWidth: true
                            lines: 1
                        }

                        B.HeadingText {
                            visible: root.title
                            text: root.title
                            Layout.fillWidth: true
                        }

                        B.SubheadingText {
                            visible: root.subtitle
                            text: root.subtitle
                            Layout.fillWidth: true
                        }
                    }

                    B.Button {
                        id: menuButtonHeadline
                        visible: parent.visible && root.menu && root.media.length === 0 && !headerRow.visible
                        Layout.alignment: Qt.AlignTop
                        onReleased: {
                            root.menu.parent = menuButtonHeadline;
                            root.menu.open()
                        }
                        icon.name: "more_horiz"
                        order: B.Button.Order.Tertiary
                    }
                }

                B.BodyText {
                    visible: root.description
                    text: root.description
                    Layout.fillWidth: true
                }

                Item {
                    Layout.fillWidth: true
                    height: childrenRect.height
                    visible: root.leftActions.length + root.rightActions.length > 0

                    RowLayout {
                        spacing: 10
                        children: root.leftActions
                        height: Math.max(implicitHeight, parent.height)
                        anchors.left: parent.left
                    }

                    RowLayout {
                        spacing: 10
                        children: root.rightActions
                        height: Math.max(implicitHeight, parent.height)
                        anchors.right: parent.right
                    }
                }
            }
        }
    }
}
