import QtQuick
import QtQuick.Window
import Qt5Compat.GraphicalEffects
import bon

Rectangle {
    id: __app__
    color: style.palette.background
    anchors.fill: parent

    property var style: {
        'palette': {
            'background': "#FEFBFA",
            'success': "#369AA0",
            'error': "#C17E86",
            'background-dark': "#0A2E45",
            'controls': {
                'accent': "#0A2E45",
                'accent_1': "#23607A",
                'background': "#E0CDCA",
                'background_1': "#D1B4B4",
                'highlight': "#FFFFFF",
                'highlight_1': "#CCFFFFFF" //80% opacity
            }
        },
        'animations': {
            'basic': {
                'type': Easing.OutQuad,
                'duration': 100
            },
            'progressStep': {
                'type': Easing.Linear,
                'duration': 800
            },
            'progressRotate': {
                'type': Easing.Linear,
                'duration': 100
            },
            'progressColor': {
                'type': Easing.OutQuad,
                'duration': 300
            }

        },
        'misc_values': {
            'disabled_opacity': 0.3
        }
    }
}
