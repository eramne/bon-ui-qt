import QtQuick
import bon as B

B.TextBase {
    color: !dark ? B.Theme.palette.text.heading : B.Theme.palette.text.heading_dark
    font: B.Theme.text.heading
    lineHeight: 1.336
}
