import QtQuick
import Qt5Compat.GraphicalEffects

Thumbnail {
    id: root

    property real size: 40

    width: size
    height: size
    radius: Math.max(width, height)/2
}
