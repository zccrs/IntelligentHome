import QtQuick 2.0

Item{
    id: root

    property alias model: list.model
    property alias delegate: list.delegate
    property alias title: title.text

    state: "close"

    states: [
        State {
            name: "spread"
            PropertyChanges {
                target: root
                height: title.implicitHeight+list.contentHeight+10
            }
        },
        State {
            name: "close"
            PropertyChanges {
                target: root
                height: title.implicitHeight
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

    Rectangle{
        anchors.fill: title

        color: "#069bcd"
        visible: root.state == "spread"
    }

    Text{
        id: title

        anchors{
            left: parent.left
            right: parent.right
            margins: 10
        }

        font.pointSize: 24
    }

    MouseArea{
        anchors.fill: parent

        onClicked: {
            if(root.state == "close"){
                spread()
            }else{
                close()
            }
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
}

