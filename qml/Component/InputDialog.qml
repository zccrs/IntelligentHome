import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

MouseArea{
    id: root

    property alias title: title.text
    property alias contentText: input.text

    signal cancle
    signal ok

    anchors.fill: parent
    visible: false

    function open(){
        visible = true
    }

    Rectangle{
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
                        root.visible = false
                    }
                }

                Button{
                    text: qsTr("Ok")
                    width: button_cancle.width

                    onClicked: {
                        root.ok()
                        root.visible = false
                    }
                }
            }
        }
    }

    onClicked: {
        visible = false
    }
}
