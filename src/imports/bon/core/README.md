# Core

Basic utility and framework classes, like the App window, the app theme, and other utilities.

QML types:

[App](#app)

[SelectionModel](#selectionmodel)

[Theme](#theme)

---

## App

Inherits: [QtQuick.Controls.ApplicationWindow](https://doc.qt.io/qt-6/qml-qtquick-controls2-applicationwindow.html)

The main window of the app, containing the navigation bar, pages, popups, and everything else required. The entry point for building an app in bonUI-QT.

### Properties

**`currentPage`** : **[Page](link needed)** - Contains the currently visible & active page. Set to the `homepage` by default, and can be set to another page for that page to be loaded and shown. This property is also used when an item in the `navRail` is clicked in order to load and show its associated page.

**`dim`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - Whether to blur & dim the app window. Used by modal popups. `false` by default.

**`homepage`** : **[Page](link needed)** - The main page that will be shown first when the app is started. Is accessible by the home button when the `navRail` is visible. Contains an empty item by default.

**`navRail`** : **[NavigationRail](link needed)** - The window's main navigation sidebar/rail, created automatically when `pages` is set. If `pages` is empty, it will not be visible.

**`pages`** : **[list](https://doc.qt.io/qt-6/qml-list.html)\<[Page](link needed)\>** - A list of the app's main [Pages](link needed) that will show as tabs in the `navRail` to be navigated between and used.

### Examples

```qml
import QtQuick;
import QtQuick.Templates as T;
import QtQuick.Layouts;
import bon as B;

B.App {
    width: 800;
    height: 600;
    visible: true;
    title: "bonUI demo application";

    homepage: B.Page {
        contents: Component {
            Item {
                B.HeadingText {
                    anchors.centerIn: parent;
                    text: "Homepage";
                }
            }
        }
    }

    pages: [
        B.Page {
            icon.name: "toggle_on";
            label: "Controls";
            contents: Component {
                B.OverflowArea {
                    /* ... */
                }
            }
        }
    ];
}
```

```qml
import QtQuick;
import QtQuick.Templates as T;
import bon as B;

T.Popup {
    id: root;

    onVisibleChanged: {
        B.App.window.dim = root.visible;
    }
}
```

---

## SelectionModel

Inherits: [QtQuick.QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)

A data model providing methods for selections with different modes/actions, like single, toggle, range, add, or clear. See `SelectionModel.SelectionType` for a description of each action. Useful for providing multi-selection support for listviews, with ctrl or shift-click.

### Properties

**`currentIndex`** : **[int](https://doc.qt.io/qt-6/qml-int.html)** - The currently active index. (Should be used by a list view to refer to or set the active element.)

**`selectedIndices`** : **[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)\<[int](https://doc.qt.io/qt-6/qml-int.html)\>** - An array of all the indices that are selected. (Can be used by a list view to alter the appearance of highlighted items, although `isSelected` would be preferable.)

### Functions

**[bool](https://doc.qt.io/qt-6/qml-bool.html)** **`isSelected`**(**[int](https://doc.qt.io/qt-6/qml-int.html)** `index`) - returns whether or not the specified `index` is included in `selectedIndices` or not. (Should be used by a list view to alter the appearance of highlighted items.)

**`select`**(**[int](https://doc.qt.io/qt-6/qml-int.html)** `index`, **SelectionModel.SelectionType** `mode` = *SelectionModel.SelectionType.One*) - Adds or removes items from `selectedIndices` depending on the index and action/mode specified. The behavior of each action is described in `SelectionModel.SelectionType`.

### Enums

**`SelectionType`** - Represents which type of action should be made towards a selection, like toggling, clearing, adding, etc.

- *`SelectionModel.SelectionType.Clear`* - Clear the selection. (e.g. clicking on the background to deselect everything.)
- *`SelectionModel.SelectionType.One`* - Clear the selection and select the specified index. (e.g. clicking without modifiers to select one.)
- *`SelectionModel.SelectionType.Range`* - Clear the selection and select everything from the `currentIndex` until the specified index. (e.g. shift-clicking to select a range.)
- *`SelectionModel.SelectionType.AddRange`* - Add everything from the `currentIndex` until the specified index to the selection. (e.g. ctrl+shift clicking to add a range to the selection.)
- *`SelectionModel.SelectionType.Toggle`* - Toggle the selection at the specified index. (e.g. control-clicking to toggle a single item.)

### Examples

```qml
import QtQuick;
import QtQuick.Templates as T;
import bon as B;

ListView {
    property bool shiftDown: /* ... */
    property bool ctrlDown: /* ... */

    B.SelectionModel {
        id: selectionModel;
    }

    delegate: T.ItemDelegate {
        id: listItem;
        required property int index;

        onReleased: {
            if (!root.ctrlDown && !root.shiftDown) {
                selectionModel.select(index);
            } else if (!root.ctrlDown && root.shiftDown) {
                selectionModel.select(index, B.SelectionModel.SelectionType.Range);
            } else if (root.ctrlDown && !root.shiftDown) {
                selectionModel.select(index, B.SelectionModel.SelectionType.Toggle);
            } else if (root.ctrlDown && root.shiftDown) {
                selectionModel.select(index, B.SelectionModel.SelectionType.AddRange);
            }
        }

        background: Rectangle {
            color: selectionModel.isSelected(listItem.index) ? B.Theme.palette.background_2 : B.Theme.palette.background;
        }
    }
}
```

---

## Theme

> **[Full Theme.qml documentation](/src/imports/bon/core/THEME.md)**
