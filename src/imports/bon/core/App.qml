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
            },
            'text': {
                'overline': "#986578",
                'heading': "#0A2E45",
                'body': "#061732",
                'label': "#23607A",
                'overline_dark': "#7AC9CE",
                'heading_dark': "#FEFBFA",
                'body_dark': "#FFFFFF",
                'label_dark': "#F4EDEB",
                'link': {
                    'body': {
                        'light': "#2A7C87",
                        'light_pressed': "#1D5C75",
                        'dark': "#E0CDCA",
                        'dark_pressed': "#D1B4B4"
                    },
                    'caption': {
                        'light': "#369AA0",
                        'light_pressed': "#2A7C87",
                        'dark': "#D1B4B4",
                        'dark_pressed': "#E0CDCA"
                    }
                }
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

    Fonts {}
}
