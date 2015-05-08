import QtQuick 2.0
import QtQuick.Controls 1.2

ToolButton{
    id: root

    property alias model: list.model
    property alias delegate: list.delegate
    property alias title: title.text
    property alias iconSource2: image_icon.source

    state: "close"
    clip: true

    states: [
        State {
            name: "spread"
            PropertyChanges {
                target: root
                height: title.implicitHeight+list.contentHeight+20
            }
        },
        State {
            name: "close"
            PropertyChanges {
                target: root
                height: title.implicitHeight+20
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "height"; easing.type: Easing.InOutQuad }
        }
    ]

    function spread(){
        root.state = "spread"
    }
    function close(){
        root.state = "close"
    }

    Image{
        id: image_icon

        anchors{
            left: parent.left
            leftMargin: 10
            top: parent.top
            topMargin: 10
        }

        sourceSize.height: title.implicitHeight
    }

    Text{
        id: title

        anchors{
            left: image_icon.right
            right: image_unfold.left
            top: parent.top
            margins: 10
        }

        font.pointSize: 24
    }

    Image {
        id: image_unfold

        source: "qrc:/images/unfold_icon"+(root.state == "spread"?"_pressed":"")+".png"
        anchors{
            right: parent.right
            top: parent.top
            margins: 10
        }
        sourceSize.height: title.implicitHeight
    }

    onClicked: {
        if(root.state == "close"){
            spread()
        }else{
            close()
        }
    }

    ListView{
        id: list

        anchors{
            top: title.bottom
            topMargin: 10
            bottom: parent.bottom
            left: title.left
            leftMargin: 20
            right: title.right
        }
    }

    Rectangle{
        anchors{
            left: parent.left
            right: parent.right
            rightMargin: 10
            leftMargin: 10
            bottom: parent.bottom
        }
        height: 1
        color: "#b0b0b0"
    }
}

