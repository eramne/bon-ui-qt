import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property QtObject target: parent
    anchors.fill: target
    property real fadeLength: 40
    property int orientation: Qt.Horizontal
    property real startContainerPos: 0
    property real endContainerPos: orientation === Qt.Horizontal ? target.width : target.height
    required property real startContentPos
    required property real endContentPos

    function updateDimensions() { gradientContainer.updateDimensions() } //because sometimes it has problems with notifying property changes and bindings for some reason

    ShaderEffectSource {
        id: targetSource
        anchors.fill: parent
        sourceItem: root.target
        hideSource: true
        visible: false
    }

    Item {
        id: gradientMask
        anchors.fill: parent

        Item {
            id: gradientContainer
            x: root.orientation === Qt.Horizontal ? Math.min(-startContentPos-root.fadeLength,0) : 0
            y: root.orientation === Qt.Horizontal ? 0 : Math.min(-startContentPos-root.fadeLength,0)
            width: root.orientation === Qt.Horizontal ?
                        Math.max((2*(root.endContainerPos-root.startContainerPos))-endContentPos+root.fadeLength,(root.endContainerPos-root.startContainerPos)) - x : parent.width
            height: root.orientation === Qt.Horizontal ? parent.height :
                        Math.max((2*(root.endContainerPos-root.startContainerPos))-endContentPos+root.fadeLength,(root.endContainerPos-root.startContainerPos)) - y

            function updateDimensions() {
                //keep synced with gradientContainer.x, y, width, height
                x = root.orientation === Qt.Horizontal ? Math.min(-startContentPos-root.fadeLength,0) : 0
                y = root.orientation === Qt.Horizontal ? 0 : Math.min(-startContentPos-root.fadeLength,0)
                width = root.orientation === Qt.Horizontal ?
                            Math.max((2*(root.endContainerPos-root.startContainerPos))-endContentPos+root.fadeLength,(root.endContainerPos-root.startContainerPos)) - x : parent.width
                height = root.orientation === Qt.Horizontal ? parent.height :
                            Math.max((2*(root.endContainerPos-root.startContainerPos))-endContentPos+root.fadeLength,(root.endContainerPos-root.startContainerPos)) - y
            }

            LinearGradient {
                x: 0
                y: 0
                width: root.orientation === Qt.Horizontal ? parent.width/2 : parent.width
                height: root.orientation === Qt.Horizontal ? parent.height : parent.height/2
                start: Qt.point(0, 0)
                end: root.orientation === Qt.Horizontal ? Qt.point(root.fadeLength,0) : Qt.point(0,root.fadeLength)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#00FFFFFF" }
                    GradientStop { position: 1.0; color: "#FFFFFFFF" }
                }
            }

            LinearGradient {
                x: root.orientation === Qt.Horizontal ? parent.width/2 : 0
                width: root.orientation === Qt.Horizontal ? parent.width/2 : parent.width
                y: root.orientation === Qt.Horizontal ? 0 : parent.height/2
                height: root.orientation === Qt.Horizontal ? parent.height : parent.height/2
                start: root.orientation === Qt.Horizontal ? Qt.point(width-root.fadeLength, 0) : Qt.point(0, height-root.fadeLength)
                end: root.orientation === Qt.Horizontal ? Qt.point(width, 0) : Qt.point(0, height)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FFFFFFFF" }
                    GradientStop { position: 1.0; color: "#00FFFFFF" }
                }
            }
        }
    }

    ShaderEffectSource {
        id: gradientSource
        anchors.fill: gradientMask
        sourceItem: gradientMask
        hideSource: true
        visible: false
    }

    OpacityMask {
        anchors.fill: targetSource
        source: targetSource
        maskSource: gradientSource
        visible: true
    }
}
