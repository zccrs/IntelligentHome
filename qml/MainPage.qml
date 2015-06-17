import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import "Component"

StackPage{
    id: root

    pageName: "首页"

    Image{
        anchors.fill: parent

        source: "qrc:/images/home_page/背景.png"
        sourceSize.width: width
        sourceSize.height: height
    }

    BorderImage {
        id: topbar

        source: "qrc:/images/点击房间页/白色框.png"
        width: parent.width
        visible: false
        anchors{
            top: parent.top
            bottom: disk.top
        }

        border.left: 15; border.top: 15
        border.right: 15; border.bottom: 15
    }


    Image{
        source: "qrc:/images/home_page/logo背景_左.png"
        width: parent.width/2
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
    }
    Image{
        id: disk

        source: "qrc:/images/home_page/logo背景_右.png"
        width: parent.width/2
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
        }

        fillMode: Image.PreserveAspectFit

        Image{
            anchors.centerIn: parent
            source: "qrc:/images/home_page/logo.png"
            height: parent.height/6
            fillMode: Image.PreserveAspectFit
        }

        PathView{
            id: pathview

            anchors.centerIn: parent
            height: parent.height*0.6
            width: height

            path: Path {
                startX: pathview.height/2; startY: 0
                PathArc {
                    x: pathview.height/2; y: pathview.height
                    direction: PathArc.Counterclockwise
                    radiusX: pathview.height/2; radiusY: radiusX
                    useLargeArc: true
                }
                PathArc {
                    x: pathview.height/2; y: 0
                    direction: PathArc.Counterclockwise
                    radiusX: pathview.height/2; radiusY: radiusX
                    useLargeArc: true
                }
            }

            model: ListModel{
                ListElement{
                    name: "回家"
                    icon: "qrc:/images/home_page/回家.png"
                }
                ListElement{
                    name: "情景模式"
                    icon : "qrc:/images/home_page/情景模式.png"
                }
                ListElement{
                    name: "房间"
                    icon: "qrc:/images/home_page/房间.png"
                }
                ListElement{
                    name: "设备"
                    icon: "qrc:/images/home_page/设备.png"
                }
                ListElement{
                    name: "背景音乐"
                    icon: "qrc:/images/home_page/背景音乐.png"
                }
                ListElement{
                    name: "布防"
                    icon: "qrc:/images/home_page/布防.png"
                }
                ListElement{
                    name: "智能感应"
                    icon: "qrc:/images/home_page/智能感知.png"
                }
            }
            delegate: Item{
                width: Math.max(item_icon.width, text.implicitWidth)
                height: item_icon.implicitHeight+text.implicitHeight+text.anchors.topMargin

                Image{
                    id: item_icon

                    source: icon
                    width: disk.width/7
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text{
                    id: text

                    anchors{
                        top: item_icon.bottom
                        topMargin: disk.width/15
                        horizontalCenter: item_icon.horizontalCenter
                    }
                    text: name
                    color: "white"
                    font.pointSize: 10
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(name == "房间"){

                        }else if(name == "情景模式"){

                        }

                        topbar.visible = true
                    }
                }
            }
        }
    }
}
