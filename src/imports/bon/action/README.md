# Action

Controls for executing actions or triggering events, such as Buttons and Menus.

QML types:

[Button](#button)

[ContextMenu](#contextmenu)

[Menu](#menu)

[MenuItem](#menuitem)

[SmallIconButton](#smalliconbutton)

---

## Button

Inherits: [QtQuick.Controls.Button](https://doc.qt.io/qt-6/qml-qtquick-controls2-button.html)

Used to execute an action. Can have a label, an icon, or both. When used with only an icon, the button takes the shape of a circle, otherwise a rounded rectangle / pill shape, sized to fit the width of the label and icon. It has three different orders of contrast, specified by the `order` property. USe `icon.name` to set the icon.

> **Note:** It is recommended to use the `onReleased` signal handler for click events, rather than `onClicked`, and `onToggled` for check/toggle events.

### Properties

**`enableElevationEffects`** : **bool** - whether or not to show a shadow under the button. True by default.

**`order`** : **Button.Order** - Changes the appearance of the button by level of importance. See the `Button.Order` enum. `Button.Order.Primary` by default.

### Enums

**`Order`** - Represents a level of contrast or importance. See `Button.order`.

- *`Button.Order.Primary`* - Uses the accent color for the button's fill and stands out the most.
- *`Button.Order.Secondary`* - Uses the background color a border around the button.
- *`Button.Order.Tertiary`* - Uses the background color, only has the icon/label without a border.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-controls2-button-members.html)**

### Examples

```qml
import QtQuick;
import bon as B;

B.Button {
    order: B.Button.Order.Primary;
    text: "Click me!";
    onReleased: {
        console.log("Hello world!");
    }
}
```

```qml
B.Button {
    icon.name: "more_vert";
    order: B.Button.Order.Secondary;
    onReleased: menu.open();
}
```

## ContextMenu

Inherits: [QtQuick.Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)

Creates a [Menu](#menu) that will open on a right-click inside the item's dimensions. Anchors to the parent item by default, which allows a context menu to be opened on a right click anywhere in the parent item.

### Properties

**`actions`** : **default list\<[MenuItem](link needed), [Menu](#menu)\>** - A list of actions or submenus for the menu to be created with. Same as `Menu.actions`.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-item-members.html)**

### Examples

```qml
import QtQuick;
import bon as B;

B.Pane { //Will show a standard Cut/Copy/Paste menu on right click anywhere in the pane

    B.ContextMenu { //anchors to parent by default, no anchors.fill necessary

        B.MenuItem {
            text: "Cut";
            shortcut: StandardKey.Cut;
        }

        B.MenuItem {
            text: "Copy";
            shortcut: StandardKey.Copy;
        }

        B.MenuItem {
            text: "Paste";
            shortcut: StandardKey.Paste;
        }
    }
}
```

## Menu

Inherits: [B.Dropdown](link needed)

A popup menu which shows a list of actions or submenus, such as with the common right-click menu or in a desktop top menu bar.

### Properties

**`actions`** : **default list\<[MenuItem](link needed), [Menu](#menu)\>** - A list of actions or submenus for the menu to be created with.

**`list`** : **[List](link needed)** - An alias to the list view containing the menu's items.

**`showDivider`** : **bool** - Whether or not to show a divider above this item in the parent menu, if it is a submenu. Ignore for root menus. False by default.

**`title`** : **string** - The menu's name. Required for sub-menus, ignore for root menus. Shows as the text of the list item in the parent menu, if it is a submenu.

**[All inherited members](link needed)**

### Examples

```qml
import QtQuick;
import bon as B;

B.Menu {

    B.MenuItem {
        text: "Copy";
        shortcut: StandardKey.Copy;
        icon.name: "content_copy";
        onTriggered: {
            console.log("Copied!");
        }
    }

    B.MenuItem {
        text: "Paste";
        shortcut: StandardKey.Paste;
        enabled: false;
    }

    B.Menu {
        title: "Submenu";

        B.Menu {
            title: "SubSubmenu";

            B.MenuItem {
                text: "deeep action";
            }
        }

        B.MenuItem {
            text: "deep action";
        }
    }
}
```

## MenuItem

Inherits: [QtQuick.Controls.Action](https://doc.qt.io/qt-6/qml-qtquick-controls2-action.html)

An executable action shown as an item in a [Menu](#menu). Displays an icon and/or a key sequence if specified. If checkable, instead of the icon, displays a checkmark if checked and an empty space if unchecked.

### Properties

**`showDivider`** : **bool** - Whether or not to show a divider above this item in its menu. False by default.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-controls2-action-members.html)**

### Examples

```qml
import QtQuick;
import bon as B;

B.Menu {

    B.MenuItem {
        text: "Cut";
        shortcut: StandardKey.Cut;
        enabled: false;
    }

    B.MenuItem {
        text: "Copy";
        shortcut: StandardKey.Copy;
        icon.name: "content_copy";
        onTriggered: {
            console.log("Copied!");
        }
    }

    B.MenuItem {
        text: "Paste";
        shortcut: StandardKey.Paste;
        enabled: false;
    }

    B.MenuItem {
        text: "Toggle read-only mode";
        checkable: true;
        checked: true;
        onToggled: {
            console.log("read-only mode:", checked);
        }
    }
}
```

## SmallIconButton

Inherits: [QtQuick.Controls.AbstractButton](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html)

A smaller, round, simpler variant of [Button](#button). Doesn't have elevation effects, a label, or contrast variants. Only has an icon, and is either light or dark. Use `icon.name` to set the icon.

> **Note:** It is recommended to use the `onReleased` signal handler for click events, rather than `onClicked`, and `onToggled` for check/toggle events.

### Properties

**`dark`** : **bool** - whether the button's background color is light or dark.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton-members.html)**

### Examples

```qml
import QtQuick;
import bon as B;

B.SmallIconButton {
    icon.name: "star";
    enabled: false;
}

B.SmallIconButton {
    icon.name: checked ? "star" : "star_border";
    checkable: true;
    onToggled: {
        console.log(checked);
    }
}
```
