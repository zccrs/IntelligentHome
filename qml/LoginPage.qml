import QtQuick 2.4
import QtQuick.Controls 1.3
import "Component"

StackPage{
    pageName: "Login"

    Flickable{
        id: root

        clip: true
        anchors.fill: parent
        Component.onCompleted: {
            contentHeight = imageLogo.height
                            +inputEmail.implicitHeight
                            +inputPassword.implicitHeight
                            +checkbox_al.height
                            +buttonLogin.height
                            +localLoginButton.height
                            +50
        }

        Image{
            id: imageLogo

            source: "qrc:/images/room.jpg"
            width: parent.width/3
            height: width
            anchors.top: parent.top
            anchors.topMargin: 10
            state: "notlogin"

            states: [
                State {
                    name: "logining"
                    AnchorChanges {
                        target: imageLogo
                        anchors.left: columnLayout1.left
                    }
                    PropertyChanges {
                        target: imageLogo
                        width: root.width/6
                        sourceSize.width: root.width/6
                    }
                },
                State {
                    name: "notlogin"
                    AnchorChanges {
                        target: imageLogo
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    PropertyChanges {
                        target: imageLogo
                        width: root.width/3
                        sourceSize.width: root.width/3
                    }
                }
            ]

            transitions: [
                Transition {
                    AnchorAnimation{
                        duration: 200
                    }
                    PropertyAnimation{
                        duration: 200
                        property: "width"
                    }
                }
            ]

            Connections{
                target: Qt.inputMethod
                onVisibleChanged:{
                    if(Qt.inputMethod.visible){
                        imageLogo.state = "logining"
                    }else{
                        timerStateChange.start()
                    }
                }
            }

            Timer{
                id: timerStateChange
                interval: 100
                onTriggered: {
                    if(!Qt.inputMethod.visible)
                        imageLogo.state = "notlogin"
                }
            }
        }

        Text{
            id: textLogin

            text: qsTr("Please Input")
            font.pointSize: 22
            anchors{
                left: imageLogo.right
                leftMargin: 10
                verticalCenter: imageLogo.verticalCenter
            }
            visible: imageLogo.state == "logining"
        }

        MouseArea{
            anchors.fill: parent

            onClicked: {
                Qt.inputMethod.hide()
                inputEmail.fold()
            }
        }

        Column{
            id: columnLayout1

            anchors.top: imageLogo.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.8
            z: 2

            MyComboBox{
                id: inputEmail

                placeholderText: qsTr("User Name")
                inputMethodHints: Qt.ImhEmailCharactersOnly
                width: parent.width
                KeyNavigation.down: inputPassword
                KeyNavigation.up: localLoginButton
                KeyNavigation.tab: inputPassword
                listHeight: root.height/3

                text: utility.value("current_account", "")
            }

            TextField{
                id: inputPassword

                width: parent.width
                placeholderText: qsTr("Password")
                KeyNavigation.down: buttonLogin
                KeyNavigation.up: inputEmail
                KeyNavigation.tab: buttonLogin
                echoMode: TextInput.Password

                text: {
                    var password = utility.value(inputEmail.text+"password", "")
                    if(password == "")
                        return ""

                    return utility.stringUncrypt(password, "xingxing")
                }
            }
        }

        Row{
            id: rowLayout

            spacing: 10
            anchors.top: columnLayout1.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

            CheckBox{
                id: checkbox_kp
                text: qsTr("Keep Password")

                checked: utility.value(inputEmail.text+"keep_password", "true") == "true"

                onCheckedChanged: {
                    if( !checked ){
                        checkbox_al.checked = false
                    }
                }
            }
            CheckBox{
                id: checkbox_al
                text: qsTr("Auto Login")

                checked: utility.value(inputEmail.text+"auto_login", "false")=="true"

                onCheckedChanged: {
                    if(checked){
                        checkbox_kp.checked = true
                    }
                }
            }
        }


        Column{
            id: columnLayout2

            anchors.top: rowLayout.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.6
            spacing: 10

            Button{
                id: buttonLogin

                enabled: inputEmail.text!=""&&inputPassword.text!=""
                text: qsTr("Remote Login")
                width: parent.width
                KeyNavigation.down: localLoginButton
                KeyNavigation.up: inputEmail
                KeyNavigation.tab: localLoginButton

                onClicked: {
                    Qt.inputMethod.hide()
                    main.online = true
                    view.push({item: Qt.resolvedUrl("MainPage.qml"), replace: true})

                    var listItem = utility.value("account_list", "")
                    if(listItem.indexOf(","+inputEmail.text)<0){
                        listItem += ","+inputEmail.text
                        utility.setValue("account_list", listItem)
                    }

                    utility.setValue(inputEmail.text+"keep_password", checkbox_kp.checked)
                    utility.setValue(inputEmail.text+"auto_login", checkbox_al.checked)
                    if(checkbox_kp.checked){
                        utility.setValue(inputEmail.text+"password",
                                         utility.stringEncrypt(inputPassword.text, "xingxing"))

                        var temp = utility.value(inputEmail.text+"password", "")
                    }else{
                        utility.setValue(inputEmail.text+"password",
                                         "")
                    }

                    utility.setValue("current_account", inputEmail.text)
                }
            }

            Button{
                id: localLoginButton

                width: parent.width
                //enabled: inputEmail.text!=""&&inputPassword.text!=""
                text: qsTr("Local Login")
                KeyNavigation.down: inputEmail
                KeyNavigation.up: buttonLogin
                KeyNavigation.tab: inputEmail

                onClicked: {
                    Qt.inputMethod.hide()
                    view.push({item: Qt.resolvedUrl("RegisterAccount.qml"), replace: true})
                }
            }
        }
    }
}
