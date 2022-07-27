# Layout

Page structure and layout elements, such as panes, cards, list views, scroll areas, popups, etc.

QML types:

[Avatar](#avatar)

[Card](#card)

[Divider](#divider)

[Dropdown](#dropdown)

[List](#list)

[listelement](#listelement)

[ListLeading](#listleading)

[ListTrailing](#listtrailing)

[OverflowArea](#overflowarea)

[Pane](#pane)

[Popup](#popup)

[Thumbnail](#thumbnail)

---

## Avatar

Inherits: [bon.Thumbnail](link needed)

For a small circular image, e.g. a user's profile picture.

### Properties

**`size`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The diameter of the circle, or the width and height of the item. `40.0` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.Avatar {
    source: "https://www.example.com/usr001-profile.png";
}

B.Avatar {
    size: 60;
    source: "https://www.example.com/usr001-profile.png";
}
```

---

## Card

Inherits: [bon.Pane](link needed)

For a rectangular item with a title and description, an image or other media, a menu, a header, or buttons, for example for posts, feeds, suggestions, etc.

### Properties

**`description`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A description, content or preview text below the title/subtitle and above the actions.

**`header`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A short text to be displayed at the very top of the card, above the media, title, description and actions.

**`headerAvatar`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A small circular image to be displayed beside the header and subheader.

**`headerIcon`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A small icon to be displayed beside the header and subheader.

**`leftActions`** : **[list](https://doc.qt.io/qt-6/qml-list.html)\<[Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)\>** - A list of buttons & items to be shown on the bottom-left of the card.

**`media`** : **[Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)** - An image or media item to be shown at the top of the card, spanning the full width.

**`menu`** : **[Menu](link needed)** - A popup menu to be shown by a button with three dots in the top-right corner of the card.

**`overline`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A short category or label directly above the title.

**`rightActions`** : **[list](https://doc.qt.io/qt-6/qml-list.html)\<[Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)\>** - A list of buttons & items to be shown on the bottom-right of the card.

**`subheader`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A small label below the header.

**`subtitle`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - The subtitle, below the title.

**`title`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - The title or headline of a card, below the header and media.

### Examples

```qml
import QtQuick;
import bon as B;

B.Card {
    width: 300
    menu: B.Menu {
        B.MenuItem {
            text: "Cut"
            shortcut: StandardKey.Cut
        }
        B.MenuItem {
            text: "Copy"
            shortcut: StandardKey.Copy
        }
        B.MenuItem {
            text: "Paste"
            shortcut: StandardKey.Paste
        }
    }

    media: B.Thumbnail {
        source: "image1.jpg"
    }
    overline: "tech"
    title: "Lorem Ipsum"
    subtitle: "by John Doe"
}

B.Card {
    width: 400
    title: "Lorem Ipsum"
    description: "Lorem ipsum dolor sit amet"
    leftActions: [
        B.Button {
            order: B.Button.Order.Primary
            text: "Action"
        },

        B.Button {
            order: B.Button.Order.Tertiary
            text: "Action"
        }
    ]
    rightActions: [
        B.Button {
            icon.name: checked ? "favorite" : "favorite_border"
            checkable: true
            order: B.Button.Order.Tertiary
        },

        B.Button {
            icon.name: "chat_bubble_outline"
            order: B.Button.Order.Tertiary
        },

        B.Button {
            icon.name: "share"
            order: B.Button.Order.Tertiary
        }
    ]
}

B.Card {
    width: 400
    header: "eramne"
    subheader: "2:32 PM, 7/12/2022"
    headerAvatar: "image2.jpg"
    description: "hello how are you today"
}
```

---

## Divider

Inherits: [QtQuick.Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)

For a line going across an area to visually separate two sections.

### Properties

**`leftInset`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - How far to inset the left edge of the line, or extend if the value is negative. Can be used to make the divider fill the whole width of a padded item or layout. `0.0` by default.

**`name`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - An optional caption to be shown below the line as the name of the section.

**`rightInset`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - How far to inset the right edge of the line, or extend if the value is negative. Can be used to make the divider fill the whole width of a padded item or layout. `0.0` by default.

**`textInset`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - How far away from the left edge of the line that the name of the divider should be positioned. Set to `-leftInset` by default, or the same position which would be set if `leftInset` was not set.

### Examples

```qml
import QtQuick;
import bon as B;

B.Divider {
    width: parent.width;
    name: "Buttons";
}
```

```qml
import QtQuick;
import bon as B;

B.Divider {
    Layout.fillWidth: true;
    name: "Buttons";
    leftInset: -Layout.leftMargin;
    rightInset: -Layout.rightMargin;
}
```

---

## Dropdown

Inherits: [bon.Popup](link needed)

A popup that follows a `target` item, either above or below it depending on how much space is available on either side.

### Properties

**`autoAdjustPositionAroundTarget`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the popup should automatically adjust its position to follow the `target` item, otherwise the position should be set manually. `true` by default.

**`target`** : **[Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)** - The item to appear beside. Set to `parent` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.Dropdown {
    targetWidth: parent.width
    targetHeight: Math.min(300, list.contentHeight + list.topMargin + list.bottomMargin)

    B.List {
        id: list
        anchors.fill: parent
        currentIndex: 0
        compact: true
        selectionMode: B.List.SelectionMode.Single

        onHeightChanged: {
            parent.height = height + parent.topPadding + parent.bottomPadding;
        }
    }
}
```

---

## List

Inherits: [QtQuick.ListView](https://doc.qt.io/qt-6/qml-qtquick-listview.html)

For an interactive list view based on a data model.

### Properties

**`compact`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the list should be shown with smaller compact items, for example in a context menu. `false` by default.

**`currentIndex`** : **[int](https://doc.qt.io/qt-6/qml-int.html)** - The currently active index.

**`model`** : **[list](https://doc.qt.io/qt-6/qml-list.html)\<[listelement](link needed)\>** - A list of the items to be displayed.

**`selectedIndices`** : **[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)\<[int](https://doc.qt.io/qt-6/qml-int.html)\>** - An array of all the indices that are selected.

**`selectionMode`** : **List.SelectionMode** - If the list should be used for selection, and how many items can be selected. See the `List.SelectionMode` enum. `List.SelectionMode.None` by default.

### Signals

**`itemActivated`**(**[int](https://doc.qt.io/qt-6/qml-int.html)** `index`, **[ItemDelegate](https://doc.qt.io/qt-6/qml-qtquick-controls2-itemdelegate.html)** `item`) - Emitted when an item is pressed or selected. Can be used to set an action when an item is clicked.
> **Note:** The corresponding handler is `onItemActivated`.

### Functions

**[bool](https://doc.qt.io/qt-6/qml-bool.html)** **`filter`**(**[listelement](link needed)** `item`) - Reassign to set a filter function to hide certain items based on their data, for example, only showing items which names start with "S". Used in combo boxes to add a "searching" functionality. Set to a function that always returns `true` by default, meaning no items get filtered out.

### Enums

**`SelectionMode`** - Represents how many items can be selected, or if no selection can be made at all.

- *`List.SelectionMode.None`* - The list cannot be used for making selections.
- *`List.SelectionMode.Single`* - Only one item can be selected at a time.
- *`List.SelectionMode.Multiple`* - Multiple items can be selected at a time, with keyboard modifiers like shift-clicking or ctrl-clicking.

### Examples

```qml
import QtQuick;
import bon as B;

B.List {
    id: list1
    width: 400

    model: [
        {name: "a", trailing: B.ListTrailing.item({component: listRadioButton}) },
        {name: "b", trailing: B.ListTrailing.item({component: listRadioButton}) },
        {name: "c", trailing: B.ListTrailing.item({component: listRadioButton}) },
        {name: "d", trailing: B.ListTrailing.item({component: listRadioButton}) },
        {name: "e", trailing: B.ListTrailing.item({component: listRadioButton}) }
    ]

    T.ButtonGroup {
        id: listButtonGroup
        exclusive: true
    }

    Component {
        id: listRadioButton

        B.RadioButton {
            T.ButtonGroup.group: listButtonGroup
        }
    }
}

B.List {
    id: list2
    width: 400

    model: [
        {name: "hi"},
        {name: "test", caption: "caption test", showDivider: true},
        {name: "the", overline: "tech"},
        {name: "an", leading: B.ListLeading.icon({name: "home"})},
        {name: "hi", showDivider: true, sectionName: "Heading"},
        {name: "test", trailing: B.ListTrailing.caption({text: "Caption"})},
        {name: "the", trailing: B.ListTrailing.icon({name: "arrow_right"})},
    ]
}
```

---

## listelement

Inherits: [Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)

An object containing data to be shown in a list view.

### Properties

**`name`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - The main title/name of the item.

**`overline`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A short category or label directly above the name.

**`caption`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - The a small caption, below the title.

**`showDivider`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the item should be shown with a divider above it, separating sections of the list. `false` by default.

**`sectionName`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - If `showDivider` is `true`, sets the caption of the divider. Blank by default.

**`enabled`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If this item should be fully shown and interactive, otherwise grayed out and unusable. `true` by default.

**`leading`** : **listleading** - Something to be shown to the left of the name, either an icon, avatar or thumbnail. Use the `ListLeading` type's functions to set.

**`trailing`** : **listtrailing** - Something to be shown to the right of the name, either an icon, caption or component. Use the `ListTrailing` type's functions to set.

---

## ListLeading

Inherits: [QtQuick.QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)

Functions to supply a list model with something to be shown at the left of an item in a list view.

### Functions

**listleading** **`avatar`**( {**[string](https://doc.qt.io/qt-6/qml-string.html)** source} ) - Shows a small circular image with the image source supplied in the options object.

**listleading** **`icon`**( {**[string](https://doc.qt.io/qt-6/qml-string.html)** name} ) - Shows an icon with the name supplied in the options object.

**listleading** **`thumbnail`**( {**[string](https://doc.qt.io/qt-6/qml-string.html)** source} ) - Shows a small image with the image source supplied in the options object.

### Examples

```qml
import QtQuick;
import bon as B;

B.List {
    id: list2
    width: 400

    model: [
        {name: "A", leading: B.ListLeading.icon({name: "home"})},
        {name: "B", leading: B.ListLeading.avatar({source: "https://www.example.com/avatar.png"})},
        {name: "C", leading: B.ListLeading.thumbnail({source: "https://www.example.com/image.png"})},
        {name: "D", trailing: B.ListTrailing.caption({text: "Caption"})},
        {name: "E", trailing: B.ListTrailing.icon({name: "arrow_right"})},
    ]
}
```

---

## ListTrailing

Inherits: [QtQuick.QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)

Functions to supply a list model with something to be shown at the right of an item in a list view.

### Functions

**listtrailing** **`caption`**( {**[string](https://doc.qt.io/qt-6/qml-string.html)** text} ) - Shows a small caption at the end of the item with its contents in the options object.

**listtrailing** **`icon`**( {**[string](https://doc.qt.io/qt-6/qml-string.html)** name} ) - Shows a small icon with the name supplied in the options object.

**listtrailing** **`item`**( {**[Component](https://doc.qt.io/qt-6/qml-qtqml-component.html)** component} ) - Loads an item from a component referenced in the options object.

### Examples

```qml
import QtQuick;
import bon as B;

B.List {
    id: list2
    width: 400

    model: [
        {name: "A", leading: B.ListLeading.icon({name: "home"})},
        {name: "B", leading: B.ListLeading.avatar({source: "https://www.example.com/avatar.png"})},
        {name: "C", leading: B.ListLeading.thumbnail({source: "https://www.example.com/image.png"})},
        {name: "D", trailing: B.ListTrailing.caption({text: "Caption"})},
        {name: "E", trailing: B.ListTrailing.icon({name: "arrow_right"})},
    ]
}
```

---

## OverflowArea

Inherits: [QtQuick.Flickable](https://doc.qt.io/qt-6/qml-qtquick-flickable.html)

An area in which its contents can be scrolled through if larger than the area itself.

### Properties

**`margins`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - Sets all the margin properties to the same value, so setting `leftMargin`, `topMargin`, etc. individually is not necessary. `10.0` by default.

**`showScrollBars`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the scroll bars can be visible, otherwise does not show scroll bars. `true` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.OverflowArea {
    margins: 40

    Column {
        spacing: 20

        /*contents*/
    }
}
```

---

## Pane

Inherits: [QtQuick.Controls.Pane](https://doc.qt.io/qt-6/qml-qtquick-controls2-pane.html)

A rectangular container with a background and optional shadow or border.

### Properties

**`borderWidth`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The thickness of the border. If set to `0.0`, no border is shown. `0.0` by default.

**`borderColor`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - The color of the border, if shown. Set to `"transparent"` by default.

**`color`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - The color of the pane's background. Set to `Theme.palette.background` by default.

**`elevation`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The intensity of the shadow shown under the pane. If `0.0`, the shadow will be hidden. `10.0` by default.

**`radius`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The corner radius used to draw a rounded rectangle. `8.0` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.Pane {

    B.Button {
        text: "Click me!"
    }
}
```

---

## Popup

Inherits: [QtQuick.Controls.Popup](https://doc.qt.io/qt-6/qml-qtquick-controls2-popup.html)

A pane shown above the rest of the app, positioned relative to the whole window.

### Properties

**`targetX`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The preferred horizontal position of the popup. Snaps to the closest valid position of this is outside of the bounds of the window. `0.0` by default.

**`targetY`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The preferred vertical position of the popup. Snaps to the closest valid position if this is outside of the bounds of the window. `0.0` by default.

**`targetWidth`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The preferred width of the popup. Snaps to the largest valid width if this is wider than the bounds of the window. Set to the width of the popup's contents by default.

**`targetHeight`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The preferred height of the popup. Snaps to the largest valid height if this is higher than the bounds of the window. Set to the height of the popup's contents by default.

### Functions

**[bool](https://doc.qt.io/qt-6/qml-bool.html)** **`outOfBounds`**(**[real](https://doc.qt.io/qt-6/qml-real.html)** `x`, **[real](https://doc.qt.io/qt-6/qml-real.html)** `y`) - Returns whether or not the position at (`x`, `y`) is outside the bounds & margins of the window, and an invalid position to be inside a popup.

---

## Thumbnail

Inherits: [QtQuick.Rectangle](https://doc.qt.io/qt-6/qml-qtquick-rectangle.html)

For a small rounded rectangular image.

### Properties

**`source`** : **[url](https://doc.qt.io/qt-6/qml-url.html)** - The source of the image file as a URL.

**`asynchronous`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the image is a local file, whether or not the image should be loaded asynchronously, separate from the user interface. `true` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.Thumbnail {
    radius: 8;
    source: "https://www.example.com/image.png";
}
```
