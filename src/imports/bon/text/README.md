# Text

QML types for different text styles like heading, body, label, etc.

QML types:

[BodyText](#bodytext)

[ButtonText](#buttontext)

[CaptionText](#captiontext)

[DisplayText](#displaytext)

[Display2Text](#display2text)

[HeadingText](#headingtext)

[LabelText](#labeltext)

[OverlineText](#overlinetext)

[SectionText](#sectiontext)

[Section2Text](#section2text)

[Section3Text](#section3text)

[SubheadingText](#subheadingtext)

[SubtitleText](#subtitletext)

[TextBase](#textbase)

[TitleText](#titletext)

---

## BodyText

Inherits: [bon.TextBase](#textbase)

For the body of an article, list text, card descriptions, etc.

---

## ButtonText

Inherits: [bon.TextBase](#textbase)

For button labels.

---

## CaptionText

Inherits: [bon.TextBase](#textbase)

For small captions, like text field character counts, menu keyboard shortcut displays, divider labels, tab button labels, image captions, etc.

---

## DisplayText

Inherits: [bon.TextBase](#textbase)

For big stylish text, e.g. the logo.

---

## Display2Text

Inherits: [bon.TextBase](#textbase)

Smaller variant of [DisplayText](#displaytext).

---

## HeadingText

Inherits: [bon.TextBase](#textbase)

For a heading, e.g. the title of a popup, card, dialog, alert, or page.

---

## LabelText

Inherits: [bon.TextBase](#textbase)

For choice labels, text inputs, chip labels, tooltip, toast, dialog, and alert descriptions, etc.

---

## OverlineText

Inherits: [bon.TextBase](#textbase)

For overline text, like a category label over an article title or over a headline of a card.

---

## SectionText

Inherits: [bon.TextBase](#textbase)

For a section of an article.

---

## Section2Text

Inherits: [bon.TextBase](#textbase)

Smaller variant of [SectionText](#sectiontext). For a subsection of an article.

---

## Section3Text

Inherits: [bon.TextBase](#textbase)

Smaller variant of [Section2Text](#section2text). For a subsection of an article.

---

## SubheadingText

Inherits: [bon.TextBase](#textbase)

For a subheading, below/complementing a heading.

---

## SubtitleText

Inherits: [bon.TextBase](#textbase)

For the subtitle of an article.

---

## TextBase

Inherits: [QtQuick.Text](https://doc.qt.io/qt-6/qml-qtquick-text.html)

The base QML type for other text styles with some set defaults and properties added for convenience.

### Properties

**`dark`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the text should appear over a dark background and adjust its color to be lighter to add contrast. `false` by default.

**`lines`** : **[int](https://doc.qt.io/qt-6/qml-int.html)** - The maximum number of lines. `-1` means an unlimited amount of lines can be rendered. Set to `-1` by default.

**`markdown`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If markdown formatting should be enabled. `false` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.DisplayText {
    text: "Display"
}

B.Display2Text {
    text: "Display 2"
}

B.TitleText {
    text: "Title"
}

B.SubtitleText {
    text: "Subtitle"
}

B.SectionText {
    text: "Section"
}

B.Section2Text {
    text: "Section 2"
}

B.Section3Text {
    text: "Section 3"
}

B.HeadingText {
    text: "Heading"
}

B.SubheadingText {
    text: "Subheading"
}

B.BodyText {
    text: "Body"
}

B.LabelText {
    text: "Label"
}

B.CaptionText {
    text: "Caption"
}

B.OverlineText {
    text: "Overline"
}

B.ButtonText {
    text: "Button"
}
```

---

## TitleText

Inherits: [bon.TextBase](#textbase)

For the title of an article, or otherwise very large heading text.
