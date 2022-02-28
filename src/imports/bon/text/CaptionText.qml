import QtQuick
import bon as B

B.TextBase {
    color: !dark ? B.Theme.palette.text.label : B.Theme.palette.text.label_dark
    linkColor: !dark ? B.Theme.palette.text.link.caption.light : B.Theme.palette.text.link.caption.dark
    font: B.Theme.text.caption
    lineHeight: 1.16
}
