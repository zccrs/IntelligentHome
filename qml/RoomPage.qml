import QtQuick 2.0


StackPage{
    pageName: "RoomManagement"

    ListView{
        anchors.fill: parent
        clip: true
        model: ListModel{
            ListElement{
                imageSource: "qrc:/images/lighting_icon.png"
                title: qsTr("lighting")
            }
            ListElement{
                imageSource: "qrc:/images/air-conditioner_icon.png"
                title: qsTr("air conditioner")
            }
            ListElement{
                imageSource: "qrc:/images/camera_icon.png"
                title: qsTr("camera")
            }
            ListElement{
                imageSource: "qrc:/images/curtain_icon.png"
                title: qsTr("curtain")
            }
            ListElement{
                imageSource: "qrc:/images/jack_icon.png"
                title: qsTr("jack")
            }
            ListElement{
                imageSource: "qrc:/images/television_icon.png"
                title: qsTr("television")
            }
        }
        delegate: Item{
            width: root.width
            height: icon.implicitHeight+30

            Rectangle{
                anchors{
                    fill: parent
                    margins: 10
                }

                color: "#069bcd"
                visible: mouse.pressed
            }

            Image{
                id: icon
                source: imageSource
                sourceSize.width: parent.width/5
                anchors.verticalCenter: parent.verticalCenter
                x: 20
            }
            Text{
                anchors{
                    verticalCenter: icon.verticalCenter
                    left: icon.right
                    right: parent.right
                    margins: 20
                }
                font.pointSize: 22
                text: title
            }
            Rectangle{
                anchors{
                    left: icon.left
                    right: parent.right
                    rightMargin: 20
                    bottom: parent.bottom
                }
                height: 1
                color: "#b0b0b0"
            }

            MouseArea{
                id: mouse

                anchors.fill: parent
            }
        }
    }

}
