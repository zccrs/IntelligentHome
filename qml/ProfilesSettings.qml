import QtQuick 2.0
import QtQuick.Controls 1.2

StackPage{
    property alias iconSource: icon.source
    property alias title: mytitle.text

    Image{
        id: icon

        anchors{
            top: parent.top
            left: parent.left
            margins: 10*screen.physicalDotsPerInch/160
        }
    }
    Text{
        id: mytitle

        anchors{
            left: icon.right
            right: parent.right
            verticalCenter: icon.verticalCenter
            margins: 10*screen.physicalDotsPerInch/160
        }
        font.pointSize: 24
    }

    ListView{
        id: listview

        anchors{
            top: icon.bottom
            margins: 30*screen.physicalDotsPerInch/160
            bottom: add_button.top
        }
        width: parent.width
        spacing: 10*screen.physicalDotsPerInch/160
        clip: true

        model: ListModel{
            ListElement{
                actionName: "Douse the glim"
            }
            ListElement{
                actionName: "Close air conditioning"
            }
        }

        delegate: Item{
            width: parent.width
            height: text_actionName.implicitHeight+20
            Text{
                id: text_actionName

                anchors{
                    left: parent.left
                    right: delete_icon.left
                    margins: 10*screen.physicalDotsPerInch/160
                }
                font.pointSize: 22
                text: actionName
            }

            Image{
                id: delete_icon

                source: "qrc:/images/delete_icon"
                        +(deleteButtonMouse.pressed?"_pressed":"")+".png"
                anchors{
                    right: parent.right
                    rightMargin: 10*screen.physicalDotsPerInch/160
                    verticalCenter: parent.verticalCenter
                }
                sourceSize.height: parent.height

                MouseArea{
                    id: deleteButtonMouse
                    anchors.fill: parent

                    onClicked: {//清除此账户的记录
                        listview.model.remove(index, 1)
                    }
                }
            }

            Rectangle{
                anchors{
                    left: parent.left
                    right: parent.right
                    rightMargin: 10*screen.physicalDotsPerInch/160
                    leftMargin: 10*screen.physicalDotsPerInch/160
                    bottom: parent.bottom
                }
                height: 1
                color: "#b0b0b0"
            }
        }
    }

    Button{
        id: add_button

        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        text: qsTr("add action")

        onClicked: {
            view.push(Qt.resolvedUrl("ActionSelectionPage.qml"))
        }
    }
}
