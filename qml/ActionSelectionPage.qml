import QtQuick 2.0
import QtQuick.Controls 1.3

StackPage{
    pageName: "ActionSelection"

    Column{
        width: parent.width

        spacing: 20*screen.physicalDotsPerInch/160

        Item{
            width: parent.width-20*screen.physicalDotsPerInch/160
            height: 40*screen.physicalDotsPerInch/160
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                text: qsTr("type")
                anchors{
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
            }

            ComboBox {
                id: combobox_type

                model: [ "lighting", "air conditioner", "camera", "curtain", "jack", "television"]

                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }
        Item{
            width: parent.width-20*screen.physicalDotsPerInch/160
            height: 40*screen.physicalDotsPerInch/160
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                text: qsTr("name")
                anchors{
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
            }

            ComboBox {
                model: ["device1", "device2", "device3"]

                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
