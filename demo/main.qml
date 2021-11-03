import QtQuick as Quick
import QtQuick.Window
import bon as Bon

Window {
    width: 800
    height: 480
    visible: true
    title: qsTr("Hello World")

    Bon.App {
        id: __app__
        Quick.Column {
            padding: 20
            anchors.fill: parent
            spacing: 20

            // @disable-check M300
            Bon.Switch {}

            // @disable-check M300
            Bon.Switch {checked: true}

            // @disable-check M300
            Bon.Switch {enabled: false}

            // @disable-check M300
            Bon.Switch {checked:true; enabled: false}

            // @disable-check M300
            Bon.RadioButton {}

            // @disable-check M300
            Bon.RadioButton {checked: true}

            // @disable-check M300
            Bon.RadioButton {mixed: true}

            // @disable-check M300
            Bon.RadioButton {enabled: false}

            // @disable-check M300
            Bon.RadioButton {checked:true; enabled: false}

            // @disable-check M300
            Bon.RadioButton {mixed:true; enabled: false}
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
                    // @disable-check M300
                    Elevation {
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
