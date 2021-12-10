import QtQuick
import QtQuick.Templates as T
import bon

T.Tumbler {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    width: orientation == Qt.Vertical ? 40 : 200
    height: orientation == Qt.Vertical ? 200 : 40

    visibleItemCount: 5

    property int orientation: Qt.Vertical

    delegate: Item {
        id: item
        property string name: index + 1
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
                           itemButton.pressed || itemButton.hovered ? Theme.palette.accent_1 : Qt.alpha(Theme.palette.accent, 0)
                       ) : (
                           itemButton.pressed ? Theme.palette.background_2 : (
                               itemButton.hovered ? Theme.palette.background_1 : Qt.alpha(Theme.palette.background, 0)
                           )
                       )

                Behavior on color {
                    ColorAnimation {
                        duration: Theme.animations.basic.duration
                        easing.type: Theme.animations.basic.type
                    }
                }
            }

            contentItem: Text {
                visible: parent.visible
                text: item.name
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font: Theme.text.body
                color: root.currentIndex === item.index ? Theme.palette.text.body_dark : Theme.palette.text.body
            }
        }
    }

    /*property ListModel model: ListModel {

    } */

    contentItem: PathView {
         id: pathView
         model: root.model
         delegate: root.delegate
         pathItemCount: root.visibleItemCount
         highlightRangeMode: PathView.StrictlyEnforceRange
         highlightMoveDuration: 100
         preferredHighlightBegin: 0.5
         preferredHighlightEnd: 0.5
         path: Path {
             startX: root.orientation == Qt.Vertical ? pathView.width / 2 : 0
             startY: root.orientation == Qt.Vertical ? 0 : pathView.height/2
             PathLine {
                 x: root.orientation == Qt.Vertical ? pathView.width / 2 : pathView.width
                 y: root.orientation == Qt.Vertical ? pathView.height : pathView.height/2
             }
         }

         maximumFlickVelocity: 4000
     }

    background: Rectangle {
        width: 40
        height: 40
        radius: 20
        x: root.orientation == Qt.Vertical ? 0 :  pathView.width/2 - width/2
        y: root.orientation == Qt.Vertical ? pathView.height/2 - height/2 : 0
        color: Theme.palette.accent
    }
}
