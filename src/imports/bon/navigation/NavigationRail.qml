import QtQuick
import QtQuick.Layouts
import bon as B

Item {
    id: root
    width: 80
    height: parent?.height ?? 100
    default property alias tabs: pagesNavColumn.children
    property alias _tabContainer: pagesNavColumn

    property bool showHomeButton: true
    property bool showTopButton: false
    property string topButtonIcon: "edit"

    property alias homeButton: homeButton

    signal homeButtonPressed()
    signal topButtonPressed()

    B.Pane {
        anchors.fill: parent
        radius: 8
        color: B.Theme.palette.accent
        elevation: 4
        leftPadding: 10
        rightPadding: 10
        topPadding: 20
        bottomPadding: 20
        clip: true

        contentItem: Item {

            Column {
                id: topNavSection
                spacing: 10

                ColumnLayout {
                    spacing: 0
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                    B.TabButton {
                        id: homeButton
                        visible: root.showHomeButton
                        icon.name: "home"
                        Layout.alignment: Qt.AlignHCenter
                        Component.onCompleted: {
                            onReleased.connect(root.homeButtonPressed);
                        }
                    }
                }

                B.Button {
                    visible: root.showTopButton
                    order: B.Button.Order.Tertiary
                    icon.name: root.topButtonIcon
                    width: parent.width
                    Component.onCompleted: {
                        onReleased.connect(root.topButtonPressed);
                    }
                }
            }

            B.OverflowArea {
                id: overflowArea
                anchors.left: parent.left
                anchors.right: parent.right
                height: Math.min(parent.height - topNavSection.height - 10, pagesNavColumn.implicitHeight)
                y: Math.max(topNavSection.y + topNavSection.height + 10, parent.height/2-height/2)
                margins: 0
                showScrollBars: false

                Column {
                    id: pagesNavColumn
                    Layout.alignment: Qt.AlignVCenter
                }
            }

            B.OverflowFadeEffect {
                target: overflowArea
                anchors.fill: overflowArea
                fadeLength: 80
                startContainerPos: 0
                endContainerPos: overflowArea.height
                startContentPos: -overflowArea.contentY
                endContentPos: -overflowArea.contentY + overflowArea.contentHeight
                orientation: Qt.Vertical

                function updateDimensions2() {
                    startContainerPos = 0
                    endContainerPos = overflowArea.height
                    startContentPos = -overflowArea.contentY
                    endContentPos = -overflowArea.contentY + overflowArea.contentHeight
                    updateDimensions();
                }

                Component.onCompleted: {
                    //because sometimes it has problems with notifying property changes and bindings for some reason
                    overflowArea.heightChanged.connect(updateDimensions2)
                    overflowArea.contentYChanged.connect(updateDimensions2)
                }
            }
        }
    }
}
