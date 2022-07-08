# Effects

Graphical effects, such as elevation/shadows or color gradients.

QML types:

[Elevation](#elevation)

---

## Elevation

Inherits: [QtQuick.Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)

Used to create a shadow under an object, filling a rounded rectangular or circular shape.

### Properties

**`elevation`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - How big and prevalent the shadow should be. Recommended range from `0.0` to `24.0`. Set to `1.0` by default.

**`radius`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The corner radius used to draw a rounded rectangle. `0` by default.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-item.html)**

### Examples

```qml
import QtQuick
import QtQuick.Templates as T
import bon as B

T.Pane {

    background: Item {

        B.Elevation {
            elevation: 4
            anchors.fill: parent
            radius: 8
        }

        Rectangle {
            anchors.fill: parent
            radius: 8
            color: B.Theme.palette.background
        }
    }
}
```
