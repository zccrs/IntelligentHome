import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import "Component"

ApplicationWindow {
    id: main

    property bool online: false
    title: view.currentItem.pageName
    visible: true

    /*menuBar: MenuBar {
        Menu {
            title: qsTr("&MenuList")

            MenuItem {
                enabled: online
                text: qsTr("&Devices")
                //onTriggered: utility.showNotify("hello android!", "my name is Qt!")
            }
            MenuItem {
                enabled: online&&title!="Profiles"
                text: qsTr("&Profiles")
                onTriggered: main.switchPage("ProfilesPage.qml")
            }
            MenuItem {
                enabled: online
                text: qsTr("&Security")
                //onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                enabled: online&&title!="Settings"
                text: qsTr("&Settings")
                onTriggered: {
                    switchPage("SettingsPage.qml")
                }
            }
            MenuItem {
                enabled: online&&title!="Manage"
                text: qsTr("&Manage")
                onTriggered: {
                    switchPage("ManagePage.qml")
                }
            }
            MenuItem{
                text: qsTr("Quit")
                onTriggered: {
                    utility.quit()
                    Qt.quit()
                }
            }
        }
    }

    toolBar:ToolBar {
        Row {
            anchors.verticalCenter: parent.verticalCenter

            ToolButton{
                visible: view.depth>1

                Image{
                    anchors.centerIn: parent
                    sourceSize.width: parent.height
                    source: "qrc:/images/back_icon.png"
                }

                onClicked: {
                    backAction()
                }
            }
        }
    }*/

    function backAction(){
        if(view.depth>1){
            view.pop()
        }else{
            utility.appToBack()
        }
    }

    function switchPage(pageName){
        if(view.depth<=1){
            view.push(Qt.resolvedUrl(pageName))
        }else{
            view.push({item: Qt.resolvedUrl(pageName), replace: true})
        }
    }

    Item{
        id: root_item

        width: screen.availableSize.width
        height: screen.availableSize.height

        function openOrCloseMenuBar(){
            if(main_item.x>leftmenubar.width/2){
                main_item_animation.to = leftmenubar.width
            }else{
                main_item_animation.to = 0
            }
            main_item_animation.start()
        }

        Image{
            anchors.fill: parent
            source: "qrc:/images/侧滑框/侧滑框大背景.png"
        }

        MouseArea{
            id: main_mouse

            anchors.fill: parent
            //propagateComposedEvents: true
            drag{
                target: main_item

                axis: Drag.XAxis
                minimumX: 0
                maximumX: leftmenubar.width
            }

            onReleased: root_item.openOrCloseMenuBar()
        }

        LeftMenuBar{
            id: leftmenubar

            scale: 0.75+main_item.x/leftmenubar.width/4

            width: parent.width*0.6
            anchors{
                bottom: parent.bottom
                bottomMargin: width/10
                left: parent.left
                leftMargin: width/10
            }
        }

        Rectangle{
            anchors.fill: parent
            color: "black"
            opacity: 1-main_item.x/leftmenubar.width
        }

        Item{
            id: main_item

            width: parent.width
            height: parent.height

            MouseArea{
                property real oldX

                anchors.fill: parent

                drag{
                    target: main_item

                    axis: Drag.XAxis
                    minimumX: 0
                    maximumX: leftmenubar.width
                }

                onPressed: {
                    oldX = mouseX
                }

                onReleased: {
                    if(oldX == mouseX){
                        main_item_animation.to = 0
                        main_item_animation.start()
                    }else{
                        root_item.openOrCloseMenuBar()
                    }
                }
            }

            NumberAnimation on x {
                id: main_item_animation

                duration: 300
                easing.type: Easing.InOutQuad
            }

            scale: 1-x/leftmenubar.width*0.17

            StackView{
                id: view

                focus: true
                width: parent.width
                anchors{
                    top: navigation_bar.bottom
                    bottom: toolbar.top
                }

                Keys.onBackPressed: {
                    event.accepted = true
                    backAction()
                }

                Component.onCompleted: {
                    push(Qt.resolvedUrl("MainPage.qml"))
                }
            }

            NavigationBar{
                id: navigation_bar

                title: main.title
                onButtonClicked: {
                    main_item_animation.to = leftmenubar.width
                    main_item_animation.start()
                }
            }

            ToolsBar{
                id: toolbar

                anchors.bottom: parent.bottom
            }
        }

        Timer{
            id: timer_quit

            property bool canQuit: false

            interval: 2000
            onTriggered: {
                canQuit = false
            }
        }

        MessageDialog{
            id: messageDialog

            function show(caption) {
                messageDialog.text = caption;
                messageDialog.open();
            }
        }
    }

    Component.onCompleted: {
        if(utility.value("StartServer", true))//判断是否启用了后台服务
            utility.showButtonNotify()
    }
}
