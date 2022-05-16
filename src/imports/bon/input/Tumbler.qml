import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import bon as B

T.Tumbler {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    width: orientation === Qt.Vertical ? 40 : (visibleItemCount * 40) + 80
    height: orientation === Qt.Vertical ? (visibleItemCount * 40) + 80 : 40

    visibleItemCount: 5

    property int orientation: Qt.Vertical

    delegate: Item {
        id: item
        required property string modelData
        required property int index

        T.ItemDelegate {
            anchors.centerIn: parent
            id: itemButton
            width: 32
            height: 24

            opacity: 1/Math.max(Math.pow(2,Math.abs(Tumbler.displacement)-1),0)
            layer.enabled: opacity < 1

            onReleased: {
                root.currentIndex = index
            }

            background: Rectangle {
                anchors.fill: parent
                radius: Math.max(width,height)/2
                color: root.currentIndex === item.index ? (
                           itemButton.pressed || itemButton.hovered ? B.Theme.palette.accent_1 : Qt.alpha(B.Theme.palette.accent, 0)
                       ) : (
                           itemButton.pressed ? B.Theme.palette.background_2 : (
                               itemButton.hovered ? B.Theme.palette.background_1 : Qt.alpha(B.Theme.palette.background, 0)
                           )
                       )

                Behavior on color {
                    ColorAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
                    }
                }
            }

            contentItem: B.BodyText {
                visible: parent.visible
                text: item.modelData
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                dark: root.currentIndex === item.index
            }
        }
    }

    contentItem: GridLayout {
        anchors.fill: parent

        flow: root.orientation === Qt.Vertical ? GridLayout.TopToBottom : GridLayout.LeftToRight

        B.Button {
            icon.name: root.orientation === Qt.Vertical ? "keyboard_arrow_up" : "keyboard_arrow_left"
            Layout.preferredWidth: 40
            Layout.preferredHeight: 40
            order: 3
            onReleased: {
                pathView.decrementCurrentIndex()
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                width: 40
                height: 40
                radius: Math.max(width, height)/2
                anchors.centerIn: parent
                color: B.Theme.palette.accent
            }

            PathView {
                id: pathView
                anchors.fill: parent
                model: root.model
                delegate: root.delegate
                pathItemCount: root.visibleItemCount
                highlightRangeMode: PathView.StrictlyEnforceRange
                highlightMoveDuration: 100
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5

                path: Path {
                    startX: root.orientation === Qt.Vertical ? pathView.width / 2 : 0
                    startY: root.orientation === Qt.Vertical ? 0 : pathView.height/2

                    PathLine {
                        x: root.orientation === Qt.Vertical ? pathView.width / 2 : pathView.width
                        y: root.orientation === Qt.Vertical ? pathView.height : pathView.height/2
                    }
                }

                maximumFlickVelocity: 4000
            }
        }

        B.Button {
            icon.name: root.orientation === Qt.Vertical ? "keyboard_arrow_down" : "keyboard_arrow_right"
            Layout.preferredWidth: 40
            Layout.preferredHeight: 40
            order: 3
            onReleased: {
                pathView.incrementCurrentIndex()
            }
        }
    }
}
