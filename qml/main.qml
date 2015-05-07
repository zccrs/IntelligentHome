import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: main

    property bool online: false

    visible: true
    title: view.currentItem.pageName

    menuBar: MenuBar {
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
    }

    function backAction(){
        if(view.depth>1){
            view.pop()
        }else if( timer_quit.canQuit ){
            Qt.quit()
        }else{
            timer_quit.canQuit = true
            utility.showMessage(qsTr("Click again to exit"))
            timer_quit.start()
        }
    }

    function switchPage(pageName){
        if(view.depth<=1){
            view.push(Qt.resolvedUrl(pageName))
        }else{
            view.push({item: Qt.resolvedUrl(pageName), replace: true})
        }
    }

    StackView{
        id: view

        focus: true
        anchors.fill: parent

        Keys.onBackPressed: {
            event.accepted = true
            backAction()
        }

        Component.onCompleted: {
            push(Qt.resolvedUrl("LoginPage.qml"))
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

    Component.onCompleted: {
        if(utility.value("StartServer", true))//判断是否启用了后台服务
            utility.showButtonNotify()
    }
}
