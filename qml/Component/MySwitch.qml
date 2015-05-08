import QtQuick 2.0
import QtQuick.Controls 1.2

Item{
    property string switch_text:""
    property alias checked: off_on.checked
    property alias textColor: switchText.color

    signal trigger(bool checked)

    width: parent.width
    height: off_on.height

    Text{
        id:switchText
        text:switch_text
        font.pointSize: 20
        anchors.left: parent.left
        height:off_on.height
        verticalAlignment: Text.AlignVCenter
    }

    Switch {
        id:off_on

        anchors{
            top: switchText.top
            right: parent.right
        }

        onClicked: {
            trigger(checked)
        }
    }
}
