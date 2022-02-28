import QtQuick
import bon as B

B.TextBase {
    color: !dark ? B.Theme.palette.text.overline : B.Theme.palette.text.overline_dark
    font: B.Theme.text.overline
    lineHeight: 1.237
}
