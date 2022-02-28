import QtQuick
import bon as B

Text {
    property bool dark: false
    linkColor: !dark ? B.Theme.palette.text.link.body.light : B.Theme.palette.text.link.body.dark
    elide: Text.ElideRight
    //renderType: Text.NativeRendering
    property real lines: -1
    maximumLineCount: lines < 0 ? Number.MAX_SAFE_INTEGER : lines
    property bool md: false
    textFormat: md ? Text.MarkdownText : Text.AutoText
    wrapMode: Text.Wrap
    lineHeightMode: Text.ProportionalHeight
    verticalAlignment: Text.AlignVCenter
}
