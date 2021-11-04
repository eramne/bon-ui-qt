import QtQuick
import QtQuick.Window
import bon as Bon

Window {
    width: 800
    height: 480
    visible: true
    title: qsTr("Hello World")

    Bon.App {
        id: __app__
        Flow {
            padding: 20
            anchors.fill: parent
            spacing: 20

            Bon.Switch {}

            Bon.Switch {checked: true}

            Bon.Switch {enabled: false}

            Bon.Switch {checked:true; enabled: false}

            Bon.RadioButton {}

            Bon.RadioButton {checked: true}

            Bon.RadioButton {mixed: true}

            Bon.RadioButton {enabled: false}

            Bon.RadioButton {checked:true; enabled: false}

            Bon.RadioButton {mixed:true; enabled: false}

            Bon.CheckBox {}

            Bon.CheckBox {checked: true}

            Bon.CheckBox {mixed: true}

            Bon.CheckBox {enabled: false}

            Bon.CheckBox {checked:true; enabled: false}

            Bon.CheckBox {mixed:true; enabled: false}
        }

        /*Flow {
            id: flow
            property var elevations: [1,2,3,4,6,8,9,12,16,24]
            padding: 20
            anchors.fill: parent
            spacing: 60
            Repeater {
                model: flow.elevations.length

                Item {
                    width: 40+40*(index/4)
                    height: width

                    Bon.Elevation {
                        anchors.fill: rect
                        radius: rect.radius
                        elevation: flow.elevations[index]
                        z: -1
                    }

                    Rectangle {
                        id: rect
                        radius: 8
                        anchors.fill: parent
                        //color: "#0A2E45"
                        color: "#FEFBFA"
                    }
                }
            }
        }*/
    }
}
