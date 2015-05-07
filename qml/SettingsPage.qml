import QtQuick 2.4
import QtQuick.Controls 1.2
import "Component"

StackPage {
    id: root

    pageName: "Settings"

    Flickable{
        id:settingFlick

        anchors{
            top: parent.top
            bottom: parent.bottom
        }
        width: parent.width
        clip: true

        contentHeight: logo.height+textVersion.implicitHeight+checkForUpdateButton.height+860

        Image{
            id:logo

            source: "qrc:/images/setting_logo_background.png"
            sourceSize.width: parent.width
            width: parent.width
            height: parent.height/6

            Image{
                anchors.centerIn: parent

                source: "qrc:/images/setting_logo.png"
                sourceSize.height: parent.height*2/3
            }
        }

        Text{
            id:textVersion

            text: qsTr("Version:")+utility.appVersion()
            color: "black"
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: logo.bottom
            anchors.topMargin: 10
        }

        CuttingLine{
            id:divide1

            annotation: qsTr("General")

            anchors.top: textVersion.bottom
            anchors.topMargin: 10
            width: parent.width-20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MySwitch{
            id: back_service_switch

            anchors.top: divide1.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            switch_text: qsTr("Allow the background service")

            KeyNavigation.down: auto_updata_app
        }

        MySwitch{
            id:auto_updata_app

            anchors.top: back_service_switch.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            switch_text: qsTr("Automatic check for updates")

            KeyNavigation.up: back_service_switch
            //KeyNavigation.down: titleFontSize
        }


        CuttingLine{
            id:cut_off

            anchors.top: auto_updata_app.bottom
            anchors.topMargin: 10
            width: parent.width-20
            anchors.horizontalCenter: parent.horizontalCenter
            annotation: qsTr("Device")
        }

        CuttingLine{
            id:cut_off2

            anchors.top: cut_off.bottom
            anchors.topMargin: 10
            width: parent.width-20
            anchors.horizontalCenter: parent.horizontalCenter
            annotation: qsTr("Camera")
        }
        CuttingLine{
            id:cut_off3

            anchors.top: cut_off2.bottom
            anchors.topMargin: 10
            width: parent.width-20
            anchors.horizontalCenter: parent.horizontalCenter
            annotation: qsTr("Room")
        }
        CuttingLine{
            id:cut_off4

            anchors.top: cut_off3.bottom
            anchors.topMargin: 10
            width: parent.width-20
            anchors.horizontalCenter: parent.horizontalCenter
            annotation: qsTr("Profiles")
        }


        Button{
            id: checkForUpdateButton

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cut_off4.bottom
            anchors.topMargin: 10
            text: qsTr("Check for updates")
            width: parent.width*0.6

            onClicked: {

            }
        }

        Button{
            id: about_page

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: checkForUpdateButton.bottom
            anchors.topMargin: 10
            text: qsTr("About")
            width: parent.width*0.6

            onClicked: {
                view.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        Button{
            id: reset

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: about_page.bottom
            anchors.topMargin: 10
            text: qsTr("Reset")
            width: parent.width*0.6

            onClicked: {

            }
        }
    }
}

