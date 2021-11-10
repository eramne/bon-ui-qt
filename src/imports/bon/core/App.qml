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
        'text': {
            'display': Qt.font({
                'family': 'Quicksand',
                'pixelSize': 96,
                'weight': Font.Light,
                'capitalization': Font.AllLowercase
            }),
            'display_2': Qt.font({
                'family': 'Quicksand',
                'pixelSize': 48,
                'weight': Font.Light,
                'capitalization': Font.AllLowercase
            }),
            'title': Qt.font({
                'family': 'Kollektif',
                'pixelSize': 60,
                'weight': Font.Normal
            }),
            'subtitle': Qt.font({
                'family': 'Inter',
                'pixelSize': 18,
                'weight': Font.Medium,
                'letterSpacing': -0.014
            }),
            'section': Qt.font({
                'family': 'Kollektif',
                'pixelSize': 48,
                'weight': Font.Normal
            }),
            'section_2': Qt.font({
                'family': 'Kollektif',
                'pixelSize': 34,
                'weight': Font.Normal
            }),
            'section_3': Qt.font({
                'family': 'Kollektif',
                'pixelSize': 24,
                'weight': Font.Normal
            }),
            'heading': Qt.font({
                'family': 'Kollektif',
                'pixelSize': 20,
                'weight': Font.Bold
            }),
            'subheading': Qt.font({
                'family': 'Inter',
                'pixelSize': 16,
                'weight': Font.Medium,
                'letterSpacing': -0.011
            }),
            'body': Qt.font({
                'family': 'Inter',
                'pixelSize': 16,
                'weight': Font.Normal,
                'letterSpacing': -0.011
            }),
            'label': Qt.font({
                'family': 'Inter',
                'pixelSize': 14,
                'weight': Font.Medium,
                'letterSpacing': -0.006
            }),
            'caption': Qt.font({
                'family': 'Inter',
                'pixelSize': 12,
                'weight': Font.Medium,
                'letterSpacing': 0
            }),
            'overline': Qt.font({
                'family': 'Inter',
                'pixelSize': 14,
                'weight': Font.Medium,
                'letterSpacing': 1.994,
                'capitalization': Font.AllUppercase
            }),
            'button': Qt.font({
                'family': 'Quicksand',
                'pixelSize': 18,
                'weight': Font.Bold,
                'letterSpacing': -0.5,
            })
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
