import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import "Component"

StackPage{
    id: root

    pageName: "Profiles"


    GridView{
        id: gridview

        cellWidth: root.width/2
        cellHeight: cellWidth
        anchors.fill: parent
        clip: true
        highlight: Item{}

        model: ListModel{
            ListElement{
                title: "go home"
                imageSource: "qrc:/images/go_home_icon.jpg"
            }
            ListElement{
                title: "go out"
                imageSource: "qrc:/images/go_out_icon.jpg"
            }
            ListElement{
                title: "meeting"
                imageSource: "qrc:/images/meeting_icon.jpg"
            }
            ListElement{
                title: "rest"
                imageSource: "qrc:/images/rest_icon.jpg"
            }
            ListElement{
                title: "sleep"
                imageSource: "qrc:/images/sleep_icon.jpg"
            }
            ListElement{
                title: ""
                imageSource: "qrc:/images/add_icon.png"
            }
        }

        delegate: ToolButton{
            id: viewitemroot

            property bool editing: false
            property bool menuIsVisible: false

            width: root.width/2
            height: width

            Image{
                source: imageSource
                anchors.centerIn: parent
                sourceSize.width: root.width/3
            }

            Text{
                id: mytitle

                visible: !parent.editing
                anchors{
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                text: title
                font.pointSize: 20

                MouseArea{
                    enabled: parent.text!=""
                    anchors.fill: parent

                    onDoubleClicked: {
                        viewitemroot.editing = true
                        input.forceActiveFocus()
                    }
                }
            }

            TextField{
                id: input

                visible: parent.editing
                text: title
                width: parent.width-20
                anchors{
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Connections{
                target: viewitemroot.editing?Qt.inputMethod:null

                onVisibleChanged:{
                    if( !Qt.inputMethod.visible ){
                        mytitle.text = input.text
                        viewitemroot.editing = false
                        viewitemroot.focus = false
                    }
                }
            }

            Timer{
                id: timer

                interval: 1000
                onTriggered: {
                    contextMenu.popup()
                }
            }

            Menu{
                id: contextMenu

                MenuItem{
                    text: qsTr("remove")

                    onTriggered: {
                        gridview.model.remove(index)
                    }
                }

                MenuItem{
                    text: qsTr("replace icon")

                    onTriggered: {
                        //gridview.model.remove(index)
                    }
                }

                MenuItem{
                    text: qsTr("edit action")

                    onTriggered: {
                        view.push({item: Qt.resolvedUrl("ProfilesSettings.qml"),
                                       properties:{iconSource:imageSource, title: mytitle.text}})
                    }
                }

                MenuItem{
                    text: qsTr("Bound to a shortcut 1")
                }
                MenuItem{
                    text: qsTr("Bound to a shortcut 2")
                }
                MenuItem{
                    text: qsTr("Bound to a shortcut 3")
                }
                MenuItem{
                    text: qsTr("Bound to a shortcut 4")
                }

                onPopupVisibleChanged: {
                    viewitemroot.menuIsVisible = !viewitemroot.menuIsVisible
                }
            }

            onClicked: {
                if(menuIsVisible)
                    return

                if(index == gridview.count-1){
                    Qt.inputMethod.hide()
                    input_dialog.open()
                }else{
                    if( Qt.inputMethod.visible )
                        return
                    //main.switchPage("RoomPage.qml")
                }
            }

            onPressedChanged:{
                if(index == gridview.count-1)
                    return

                if(pressed){
                    timer.start()
                }else{
                    timer.stop()
                }
            }
        }
    }

    InputDialog{
        id: input_dialog

        title: qsTr("Plase input profiles name")

        onOk: {
            gridview.model.insert(gridview.model.count-1,
                                  {title: input_dialog.contentText,
                                  imageSource: "qrc:/images/room.jpg"})
        }
    }
}
