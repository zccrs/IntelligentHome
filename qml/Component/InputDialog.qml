import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

Window{
    id: root

    property alias title: title.text
    property alias contentText: input.text

    signal cancle
    signal ok

    flags: flags|Qt.WindowStaysOnTopHint
    color: "transparent"
    modality: Qt.WindowModal

    function open(){
        root.show()
    }

    Rectangle{
        anchors.fill: parent
        color: "black"
        opacity: 0.2

        MouseArea{
            anchors.fill: parent
            onClicked: {
                close()
                root.visible = false
            }
        }
    }

    RectangularGlow {
        id: effect
        anchors.fill: rect_dialog
        glowRadius: 8*screen.physicalDotsPerInch/160
        spread: 0.1
        color: "black"
        cornerRadius: rect_dialog.radius + glowRadius
    }

    Rectangle{
        id: rect_dialog

        width: Screen.width*2/3
        height: title.implicitHeight+input.height+button_cancle.height+40
        anchors.centerIn: parent

        radius: 10
        color: "white"

        Column{
            spacing: 10
            width: parent.width-20
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                id: title

                y:10
                width: parent.width
            }

            TextField{
                id: input

                width: parent.width
            }

            Row{
                width: parent.width
                spacing: 20

                Button{
                    id: button_cancle

                    text: qsTr("Cancle")
                    onClicked: {
                        root.cancle()
                        root.close()
                    }
                }

                Button{
                    text: qsTr("Ok")
                    width: button_cancle.width

                    onClicked: {
                        root.ok()
                        root.close()
                    }
                }
            }
        }
    }
}
