import QtQuick 2.0
import "Component"

Column{
    id: root

    spacing: 10

    TreeView{
        title: qsTr("Device management")
        width: root.width

        model: ListModel{
            ListElement{
                title: qsTr("device1")
            }
        }

        delegate: TreeViewDelegate{}
    }
    TreeView{
        title: qsTr("Camera management")
        width: root.width

        model: ListModel{
            ListElement{
                title: qsTr("camera1")
            }
        }

        delegate: TreeViewDelegate{}
    }
    TreeView{
        title: qsTr("Room management")
        width: root.width

        model: ListModel{
            ListElement{
                title: qsTr("room1")
            }
        }

        delegate: TreeViewDelegate{}
    }
    TreeView{
        title: qsTr("Profiles management")
        width: root.width

        model: ListModel{
            ListElement{
                title: qsTr("profiles1")
            }
        }

        delegate: TreeViewDelegate{}
    }
}

