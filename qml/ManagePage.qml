import QtQuick 2.0
import "Component"

StackPage{
    id: root

    pageName: "Manage"

    Flickable{
        anchors.fill: parent

        contentHeight: tree1.height+tree2.height+tree3.height+tree4.height

        Column{
            spacing: 20
            anchors.fill: parent

            TreeView{
                id: tree1

                title: qsTr("Device management")
                iconSource2: "qrc:/images/setting_icon.png"
                width: root.width

                model: ListModel{
                    ListElement{
                        title: qsTr("device1")
                    }
                }

                delegate: TreeViewDelegate{}
            }
            TreeView{
                id: tree2

                title: qsTr("Camera management")
                iconSource2: "qrc:/images/setting_icon.png"
                width: root.width

                model: ListModel{
                    ListElement{
                        title: qsTr("camera1")
                    }
                }

                delegate: TreeViewDelegate{}
            }
            TreeView{
                id: tree3

                title: qsTr("Room management")
                iconSource2: "qrc:/images/setting_icon.png"
                width: root.width

                model: ListModel{
                    ListElement{
                        title: qsTr("room1")
                    }
                }

                delegate: TreeViewDelegate{}
            }
            TreeView{
                id: tree4

                title: qsTr("Profiles management")
                iconSource2: "qrc:/images/setting_icon.png"
                width: root.width

                model: ListModel{
                    ListElement{
                        title: qsTr("profiles1")
                    }
                }

                delegate: TreeViewDelegate{}
            }
        }
    }
}

