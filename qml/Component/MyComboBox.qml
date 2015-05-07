import QtQuick 2.4
import QtQuick.Controls 1.3

TextField{
    id: root

    property alias model: listview.model
    readonly property bool isOpen: root.state == "open"
    property int listHeight: 50

    states: [
        State {
            name: "fold"
            PropertyChanges {
                target: listview
                height: 0
            }
        },
        State {
            name: "open"
            PropertyChanges {
                target: listview
                height: Math.max(Math.min(listHeight, listview.contentHeight), 30)
            }
        }
    ]
    z: 999
    state: "fold"

    transitions: Transition {
        NumberAnimation { properties: "height"; easing.type: Easing.InOutQuad }
    }

    function open(){
        model.clear()
        var listItem = utility.value("account_list", "")
        listItem = listItem.split(",")
        if(listItem!=""){
            for(var i=1; i<listItem.length; ++i){
                model.append({mytitle: listItem[i]})
            }
        }

        root.state = "open"
    }

    function fold(){
        root.state = "fold"
    }

    Image {
        source: "qrc:/images/unfold_icon"+(isOpen?"_pressed":"")+".png"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        sourceSize.height: parent.height/1.5
        anchors.margins: 10

        MouseArea{
            anchors.fill: parent

            onClicked: {
                if(isOpen){
                    fold()
                }else{
                    open()
                }
            }
        }
    }

    Rectangle{
        anchors.fill: listview
        color: "white"
        radius: 6
        opacity: 0.9
        border{
            color: "#b0b0b0"
            width: 2
        }
    }

    ListView{
        id: listview

        width: parent.width-20
        anchors{
            top: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        model: ListModel{}
        visible: isOpen
        clip: true

        delegate: Item{
            width: parent.width
            height: mytext.implicitHeight+10
            Rectangle{
                anchors.fill: parent
                radius: 6
                color: "#069bcd"
                visible: itemMouse.pressed
            }

            MouseArea{
                id: itemMouse
                anchors.fill: parent

                onClicked: {
                    root.text = mytext.text
                }
            }

            Text{
                id: mytext
                anchors{
                    left: parent.left
                    right: parent.right
                    margins: 10
                    verticalCenter: parent.verticalCenter
                }

                elide: Text.ElideRight
                text: mytitle
            }
            Rectangle{
                height: 1
                width: parent.width
                color: "#b0b0b0"
                anchors.bottom: parent.bottom
            }

            Image{
                source: "qrc:/images/delete_icon"
                        +(deleteButtonMouse.pressed?"_pressed":"")+".png"
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                sourceSize.height: parent.height

                MouseArea{
                    id: deleteButtonMouse
                    anchors.fill: parent

                    onClicked: {//清除此账户的记录
                        var listItem = utility.value("account_list", "")
                        listItem = listItem.replace(","+mytitle, "")
                        utility.setValue("account_list", listItem)
                        if(root.text == mytitle){
                            root.text = ""
                        }
                        if(utility.value("current_account", "")==mytitle){
                            utility.setValue("current_account", root.text)
                        }

                        listview.model.remove(index, 1)
                    }
                }
            }
        }
    }
}
