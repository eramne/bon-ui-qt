pragma Singleton
import QtQuick

QtObject {
    id: theme

    property bool dark: false

    property real disabled_opacity: 0.3
    property real highlight_hover_opacity: 0.8

    property QtObject palette: QtObject {
        property color background: !dark ? "#FEFBFA" : "#0A2E45"
        property color background_1: !dark ? "#E0CDCA" : "#23607A"
        property color background_2: !dark ? "#D1B4B4" : "#2A7C87"
        property color accent: !dark ? "#0A2E45" : "#FEFBFA"
        property color accent_1: !dark ? "#23607A" : "#E0CDCA"
        property color highlight: !dark ? "#FFFFFF" : "#0A2E45"
        property color highlight_1: Qt.alpha(highlight, theme.highlight_hover_opacity)
        property color success: "#369AA0"
        property color error: "#C17E86"
        property color warning: "#D9B390"
        property color info: "#6C92DC"
        property color notify: "#C17E86"
        property color selection_background: accent_1
        property color selection_text: highlight_1
        property color elevation: !dark ? "#986578" : "#7AC9CE"
        property color modal: Qt.alpha(!dark ? "#C17E86" : "#369AA0", 0.3)

        property QtObject text: QtObject {
            property color overline: !dark ? "#986578" : "#7AC9CE"
            property color overline_dark: !dark ? "#7AC9CE" : "#986578"
            property color heading: !dark ? "#0A2E45" : "#FEFBFA"
            property color heading_dark: !dark ? "#FEFBFA" : "#0A2E45"
            property color body: !dark ? "#061732" : "#FFFFFF"
            property color body_dark: !dark ? "#FFFFFF" : "#061732"
            property color label: !dark ? "#23607A" : "#F4EDEB"
            property color label_dark: !dark ? "#F4EDEB" : "#23607A"
            property color notify: "#F4EDEB"

            property QtObject link: QtObject {
                property QtObject body: QtObject {
                    property color light: !theme.dark ? "#2A7C87" : "#E0CDCA"
                    property color light_hover: !theme.dark ? "#1D5C75" : "#D1B4B4"
                    property color dark: !theme.dark ? "#E0CDCA" : "#2A7C87"
                    property color dark_hover: !theme.dark ? "#D1B4B4" : "#1D5C75"
                }

                property QtObject label: QtObject {
                    property color light: !theme.dark ? "#369AA0" : "#D1B4B4"
                    property color light_hover: !theme.dark ? "#2A7C87" : "#E0CDCA"
                    property color dark: !theme.dark ? "#D1B4B4" : "#369AA0"
                    property color dark_hover: !theme.dark ? "#E0CDCA" : "#2A7C87"
                }
            }
        }
    }

    property QtObject text: QtObject {
        property font display: Qt.font({
            'family': 'Quicksand',
            'pixelSize': 96,
            'weight': Font.Light,
            'capitalization': Font.AllLowercase
        })
        property font display_2: Qt.font({
            'family': 'Quicksand',
            'pixelSize': 48,
            'weight': Font.Light,
            'capitalization': Font.AllLowercase
        })
        property font title: Qt.font({
            'family': 'Kollektif',
            'pixelSize': 60,
            'weight': Font.Normal
        })
        property font subtitle: Qt.font({
            'family': 'Inter',
            'pixelSize': 18,
            'weight': Font.Medium,
            'letterSpacing': -0.014
        })
        property font section: Qt.font({
            'family': 'Kollektif',
            'pixelSize': 48,
            'weight': Font.Normal
        })
        property font section_2: Qt.font({
            'family': 'Kollektif',
            'pixelSize': 34,
            'weight': Font.Normal
        })
        property font section_3: Qt.font({
            'family': 'Kollektif',
            'pixelSize': 24,
            'weight': Font.Normal
        })
        property font heading: Qt.font({
            'family': 'Kollektif',
            'pixelSize': 20,
            'weight': Font.Bold
        })
        property font subheading: Qt.font({
            'family': 'Inter',
            'pixelSize': 16,
            'weight': Font.Medium,
            'letterSpacing': -0.011
        })
        property font body: Qt.font({
            'family': 'Inter',
            'pixelSize': 16,
            'weight': Font.Normal,
            'letterSpacing': -0.011
        })
        property font label: Qt.font({
            'family': 'Inter',
            'pixelSize': 14,
            'weight': Font.Medium,
            'letterSpacing': -0.006
        })
        property font caption: Qt.font({
            'family': 'Inter',
            'pixelSize': 12,
            'weight': Font.Medium,
            'letterSpacing': 0
        })
        property font overline: Qt.font({
            'family': 'Inter',
            'pixelSize': 14,
            'weight': Font.Medium,
            'letterSpacing': 1.994,
            'capitalization': Font.AllUppercase
        })
        property font button: Qt.font({
            'family': 'Quicksand',
            'pixelSize': 18,
            'weight': Font.Bold,
            'letterSpacing': -0.5
        })
    }

    property QtObject animations: QtObject {
        property QtObject basic: QtObject {
            property int type: Easing.OutQuad
            property real duration: 100
        }

        property QtObject progressStep: QtObject {
            property int type: Easing.Linear
            property real duration: 800
        }

        property QtObject progressColor: QtObject {
            property int type: Easing.OutQuad
            property real duration: 300
        }

        property QtObject dialog: QtObject {
            property int type: Easing.OutBack
            property real duration: 200
        }
    }
}
