# Theme

Inherits: [QtQuick.QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)

A singleton providing constants for theme and appearance values such as colors, fonts, animations, and other values.

---

## Properties

**`disabled_opacity`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - To be used as the opacity of disabled controls. `0.3` by default.

**`highlight_hover_opacity`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - To be used as the opacity of the highlight color of controls while the mouse is hovered. See `palette.highlight` and `palette.highlight_1`. Set to `0.8` by default.

**`palette`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - A group of color values to be referenced throughout the app as its color palette.

> **`background`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as the main background color of the app, e.g. a bright white background. `"#FEFBFA"` by default.
>
> **`background_1`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as a slightly darker variant of the `background` color, e.g. a secondary button's hovered color, an off-switch's or slider's rail color, or a border color of many components. `"#E0CDCA"` by default.
>
> **`background_2`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as an even darker variant of the `background` color, e.g. a secondary button's pressed color, an off-switch's or slider's rail color when pressed or active, or the border of a textbox when focused. `"#D1B4B4"` by default.
>
> **`accent`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as an accent color to complement or contrast sharply with the background, e.g. the background color of a primary button, or the color of a navigation rail, the background of an on-switch or the handle of a slider. `"#0A2E45"` by default.
>
> **`accent_1`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as a lighter variant of the `accent` color, e.g. the background color of a primary button while pressed, or the background of an on-switch or the handle of a slider while pressed or active. `"#23607A"` by default.
>
> **`highlight`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as a highlight on controls, e.g. the color of the handle of a switch or dial, or the color of an icon or label of a primary button. `"#FFFFFF"` by default.
>
> **`highlight_1`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as a darker variant of the `highlight` color, e.g. the color of the handle of a switch or dial while hovered, or the color of an icon or label of a primary button while hovered. Set to `Qt.alpha(highlight, Theme.highlight_hover_opacity)` by default.
>
> **`success`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To represent success or completion of a task, e.g. a progress bar at 100%, or the border and icon color of the success variant of an alert or toast. `"#369AA0"` by default.
>
> **`error`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To represent an error, e.g. a progress bar in an error state, or the border and icon color of the error variant of an alert or toast. `"#C17E86"` by default.
>
> **`warning`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To represent a warning, e.g. the border and icon color of the warning variant of an alert. `"#D9B390"` by default.
>
> **`info`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To represent an informational notification, e.g. the border and icon color of the info variant of an alert or toast. `"#6C92DC"` by default.
>
> **`notify`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as the color of notification-related things, e.g. a notification badge in a tab button. `"#C17E86"` by default.
>
> **`selection_background`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as the background color of highlighted/selected text in a text field/area. Same as `accent_1` by default.
>
> **`selection_text`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as the font color of highlighted/selected text in a text field/area. Same as `highlight_1` by default.
>
> **`elevation`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as the color of shadows/elevation effects, aside from opacity. `"#986578"` by default.
>
> **`modal`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used as the overlay color of the dimming effect, e.g. under a modal dialog. Set to `Qt.alpha("#C17E86",0.3)` by default.
>
> **`text`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - A group of colors to be used by text.
>>
>> **`overline`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by overline text. `"#986578"` by default.
>>
>> **`overline_dark`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by overline text over a dark background. `"#7AC9CE"` by default.
>>
>> **`heading`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by heading, section, or display text. `"#0A2E45"` by default.
>>
>> **`heading_dark`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by heading, section, or display text over a dark background. `"#FEFBFA"` by default.
>>
>> **`body`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by body text. `"#061732"` by default.
>>
>> **`body_dark`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by body text over a dark background. `"#FFFFFF"` by default.
>>
>> **`label`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by label or caption text. `"#23607A"` by default.
>>
>> **`label_dark`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by label or caption text over a dark background. `"#F4EDEB"` by default.
>>
>> **`link`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - A group of colors to be used by link text.
>>>
>>> **`body`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - A group of colors to be used by body links.
>>>>
>>>> **`light`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by links. `"#2A7C87"` by default.
>>>>
>>>> **`light_hover`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by links while hovered. `"#1D5C75"` by default.
>>>>
>>>> **`dark`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by links over a dark background. `"#E0CDCA"` by default.
>>>>
>>>> **`dark_hover`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by links while hovered over a dark background. `"#D1B4B4"` by default.
>>>
>>> **`label`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - A group of colors to be used by label or caption links.
>>>>
>>>> **`light`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by links. `"#369AA0"` by default.
>>>>
>>>> **`light_hover`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by links while hovered. `"#2A7C87"` by default.
>>>>
>>>> **`dark`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by links over a dark background. `"#D1B4B4"` by default.
>>>>
>>>> **`dark_hover`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - To be used by links while hovered over a dark background. `"#E0CDCA"` by default.

**`text`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - A group of font values for font and text styles.

> **`display`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For big stylish text, e.g. the logo. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Quicksand',
>     'pixelSize': 96,
>     'weight': Font.Light,
>     'capitalization': Font.AllLowercase
> })
> ```
>
> by default.
>
> **`display_2`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - Smaller variant of `display`. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Quicksand',
>     'pixelSize': 48,
>     'weight': Font.Light,
>     'capitalization': Font.AllLowercase
> })
> ```
>
> by default.
>
> **`title`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For the title of an article, or otherwise very large heading text. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Kollektif',
>     'pixelSize': 60,
>     'weight': Font.Normal
> })
> ```
>
> by default.
>
> **`subtitle`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For the subtitle of an article. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Inter',
>     'pixelSize': 18,
>     'weight': Font.Medium,
>     'letterSpacing': -0.014
> })
> ```
>
> by default.
>
> **`section`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For a section of an article. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Kollektif',
>     'pixelSize': 48,
>     'weight': Font.Normal
> })
> ```
>
> by default.
>
> **`section_2`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - Smaller variant of `section`. For a subsection of an article. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Kollektif',
>     'pixelSize': 34,
>     'weight': Font.Normal
> })
> ```
>
> by default.
>
> **`section_3`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - Smaller variant of `section_2`. For a subsection of an article. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Kollektif',
>     'pixelSize': 24,
>     'weight': Font.Normal
> })
> ```
>
> by default.
>
> **`heading`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For a heading, e.g. the title of a popup, card, dialog, alert, or page. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Kollektif',
>     'pixelSize': 20,
>     'weight': Font.Bold
> })
> ```
>
> by default.
>
> **`subheading`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For a subheading, below/complementing a heading. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Inter',
>     'pixelSize': 16,
>     'weight': Font.Medium,
>     'letterSpacing': -0.011
> })
> ```
>
> by default.
>
> **`body`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For the body of an article, list text, card descriptions, etc. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Inter',
>     'pixelSize': 16,
>     'weight': Font.Normal,
>     'letterSpacing': -0.011
> })
> ```
>
> by default.
>
> **`label`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For choice labels, text inputs, chip labels, tooltip, toast, dialog, and alert descriptions, etc. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Inter',
>     'pixelSize': 14,
>     'weight': Font.Medium,
>     'letterSpacing': -0.006
> })
> ```
>
> by default.
>
> **`caption`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For small captions, like text field character counts, menu keyboard shortcut displays, divider labels, tab button labels, image captions, etc. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Inter',
>     'pixelSize': 12,
>     'weight': Font.Medium,
>     'letterSpacing': 0
> })
> ```
>
> by default.
>
> **`overline`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For overline text, like a category label over an article title or over a headline of a card. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Inter',
>     'pixelSize': 14,
>     'weight': Font.Medium,
>     'letterSpacing': 1.994,
>     'capitalization': Font.AllUppercase
> })
> ```
>
> by default.
>
> **`button`** : **[font](https://doc.qt.io/qt-6/qml-font.html)** - For button labels. Set to:
>
> ```qml
> Qt.font({
>     'family': 'Quicksand',
>     'pixelSize': 18,
>     'weight': Font.Bold,
>     'letterSpacing': -0.5
> })
> ```
>
> by default.

**`animations`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - A group of animation styles providing values like easing type and duration.

> **`basic`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - A basic animation used for most things, such as slider or switch movement, color changes, elevation changes, etc.
>>
>> **`type`** : **[Easing](https://doc.qt.io/qt-6/qml-qtquick-propertyanimation.html#easing-prop)** - The type of easing curve to be used. `Easing.OutQuad` by default.
>>
>> **`duration`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The duration of the animation. `100` by default.
>
> **`progressStep`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - For animating value changes in a progress bar or circle.
>>
>> **`type`** : **[Easing](https://doc.qt.io/qt-6/qml-qtquick-propertyanimation.html#easing-prop)** - The type of easing curve to be used. `Easing.Linear` by default.
>>
>> **`duration`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The duration of the animation. `800` by default.
>
> **`progressColor`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - For animating state/color changes in a progress bar or circle.
>>
>> **`type`** : **[Easing](https://doc.qt.io/qt-6/qml-qtquick-propertyanimation.html#easing-prop)** - The type of easing curve to be used. `Easing.OutQuad` by default.
>>
>> **`duration`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The duration of the animation. `300` by default.
>
> **`progressColor`** : **[QtObject](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html)** - For animating a dialog moving into or out of view.
>>
>> **`type`** : **[Easing](https://doc.qt.io/qt-6/qml-qtquick-propertyanimation.html#easing-prop)** - The type of easing curve to be used. `Easing.OutBack` by default.
>>
>> **`duration`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The duration of the animation. `200` by default.

### Examples

```qml
import QtQuick;
import QtQuick.Templates as T;
import bon as B;

T.Button {
    id: root;
    property int order: B.Button.Order.Primary;

    background: Rectangle {
        anchors.fill: root;
        color: order === Button.Order.Primary ? (
                   root.down ? B.Theme.palette.accent_1 : B.Theme.palette.accent
               ) : (
                   root.down ? B.Theme.palette.background_2 : (
                       root.hovered ? B.Theme.palette.background_1 : B.Theme.palette.background
                   )
               );
        radius: Math.max(width, height)/2;
        border.color: B.Theme.palette.background_1;
        border.width: order === Button.Order.Secondary && !root.down && !root.hovered ? 2 : 0;

        Behavior on border.width {
            NumberAnimation {
                duration: B.Theme.animations.basic.duration;
                easing.type: B.Theme.animations.basic.type;
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration;
                easing.type: B.Theme.animations.basic.type;
            }
        }
    }
}
```
