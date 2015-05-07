import QtQuick 2.4
import QtQuick.Controls 1.3

StackPage{
    pageName: "RegisterAccount"

    Flickable{
        clip: true
        anchors.fill: parent

        Component.onCompleted: {
            contentHeight = imageLogo.height
                    +inputUserNmae.implicitHeight
                    +inputPassword1.implicitHeight
                    +inputPassword2.implicitHeight
                    +inputEmail.implicitHeight
                    +inputPhoneNumber.implicitHeight
                    +inputCode.implicitHeight
                    +submitLoginButton.height
                    +columnLayout.spacing*6
                    +20
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
                        anchors.left: columnLayout.left
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
            anchors.left: imageLogo.right
            anchors.leftMargin: 10
            anchors.verticalCenter: imageLogo.verticalCenter
            visible: imageLogo.state == "logining"
        }

        MouseArea{
            anchors.fill: parent

            onClicked: {
                Qt.inputMethod.hide()
            }
        }

        Column{
            id: columnLayout

            anchors.top: imageLogo.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.6
            spacing: 10

            TextField{
                id: inputUserNmae

                placeholderText: qsTr("User Name")
                inputMethodHints: Qt.ImhEmailCharactersOnly
                width: parent.width
                KeyNavigation.down: inputEmail
                KeyNavigation.up: submitLoginButton
                KeyNavigation.tab: inputEmail

            }

            TextField{
                id: inputEmail

                placeholderText: qsTr("Email")
                inputMethodHints: Qt.ImhEmailCharactersOnly
                width: parent.width
                KeyNavigation.down: inputPassword1
                KeyNavigation.up: inputUserNmae
                KeyNavigation.tab: inputPassword1

            }

            TextField{
                id: inputPassword1

                width: parent.width
                placeholderText: qsTr("Password")
                KeyNavigation.down: inputPassword2
                KeyNavigation.up: inputEmail
                KeyNavigation.tab: inputPassword2
                echoMode: TextInput.Password

            }

            TextField{
                id: inputPassword2

                width: parent.width
                placeholderText: qsTr("Confirmation Password")
                KeyNavigation.down: inputPhoneNumber
                KeyNavigation.up: inputPassword1
                KeyNavigation.tab: inputPhoneNumber
                echoMode: TextInput.Password

            }

            TextField{
                id: inputPhoneNumber

                width: parent.width
                placeholderText: qsTr("Phone Number")
                KeyNavigation.down: inputCode
                KeyNavigation.up: inputPassword2
                KeyNavigation.tab: inputCode

            }

            TextField{
                id: inputCode

                width: parent.width
                placeholderText: qsTr("SMS Code")
                KeyNavigation.down: submitLoginButton
                KeyNavigation.up: inputPhoneNumber
                KeyNavigation.tab: submitLoginButton
            }

            Button{
                id: submitLoginButton

                width: parent.width
                //enabled: inputEmail.text!=""&&inputPassword.text!=""
                text: qsTr("Submit")
                KeyNavigation.down: inputUserNmae
                KeyNavigation.up: inputCode
                KeyNavigation.tab: inputUserNmae

                onClicked: {

                }
            }
        }
    }


}
