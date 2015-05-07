import QtQuick 2.0
import QtQuick.Controls 1.2

Item{
    height:  mytitle.implicitHeight
    width: parent.width

    Text{
        id: mytitle

        anchors{
            left: parent.left
            right: edit_icon.left
            margins: 10
        }

        text: title
    }

    ToolButton{
        id: edit_icon

        width: parent.height
        height: width

        Image{
            anchors.centerIn: parent
            sourceSize.width: parent.height
            source: "qrc:/images/edit_icon.png"
        }

        anchors{
            right: parent.right
            margins: 10
            verticalCenter: mytitle.verticalCenter
        }
    }
}
