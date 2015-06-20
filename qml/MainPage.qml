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

        anchors{
            top: parent.top
            bottom: disk.top
        }

        border.left: 10; border.top: 10
        border.right: 10; border.bottom: 10

        GridView{
            id: gridview

            anchors{
                fill: parent
                topMargin: topbar.border.top
                leftMargin: topbar.border.left+30
                rightMargin: topbar.border.right
                bottomMargin: topbar.border.bottom
            }

            cellWidth: height
            cellHeight: height
            snapMode: GridView.SnapToRow
            flow: GridView.FlowTopToBottom
            clip: true

            footer: Item{
                width: gridview.cellWidth
                height: gridview.cellHeight

                Image{
                    source: "qrc:/images/点击房间页/00_r3_c9.png"
                    anchors{
                        fill: parent
                        margins: parent.width/10
                    }
                }
            }

            delegate: Item{
                width: gridview.cellWidth
                height: gridview.cellHeight

                Image{
                    anchors{
                        fill: parent
                        margins: parent.width/10
                    }
                    source: icon

                    Image{
                        width: parent.width
                        source: "qrc:/images/点击房间页/蓝条.png"
                        Text{
                            anchors.centerIn: parent
                            font.pointSize: 8
                            color: "white"
                            text: name
                        }
                    }

                    MouseArea{
                        anchors.fill: parent

                        onClicked: {

                        }
                    }
                }
            }

            model:ListModel{
                id: gridmodel
            }
        }
    }


    Image{
        source: "qrc:/images/home_page/logo背景_左.png"
        width: parent.width/2
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit

        Text{
            id: ffff
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: parent.height/20
                rightMargin: parent.height/8
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: parent.height/30
            }
            height: parent.implicitHeight/2.2

            text: pathmodel.get(pathview.currentIndex).title
            color: "white"
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }
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
                startX: 0; startY: pathview.height/2
                PathArc {
                    x: pathview.height; y: pathview.height/2
                    radiusX: pathview.height/2; radiusY: radiusX
                    useLargeArc: true
                }
                PathArc {
                    x: 0; y: pathview.height/2
                    radiusX: pathview.height/2; radiusY: radiusX
                    useLargeArc: true
                }
            }

            onCurrentItemChanged:{
                currentItem.setTopBarModel()
            }

            model: ListModel{
                id: pathmodel

                ListElement{
                    name: "房间"
                    icon: "qrc:/images/home_page/房间.png"
                    title: "房间内有各种设备存放"
                    modeldata: '{
                        "icons": [
                            "qrc:/images/点击房间页/客厅.png",
                            "qrc:/images/点击房间页/主卧.png",
                            "qrc:/images/点击房间页/次卧.png",
                            "qrc:/images/点击房间页/餐厅.png",
                            "qrc:/images/点击房间页/卫生间.png",
                            "qrc:/images/点击房间页/厨房.png",
                            "qrc:/images/点击房间页/书房.png"
                        ],
                        "names": ["客厅","主卧","次卧","餐厅","卫生间","厨房","书房"]
                    }'
                }
                ListElement{
                    name: "情景模式"
                    icon : "qrc:/images/home_page/情景模式.png"
                    modeldata:""
                }
                ListElement{
                    name: "回家"
                    icon: "qrc:/images/home_page/回家.png"
                    modeldata:""
                }
                ListElement{
                    name: "智能感应"
                    icon: "qrc:/images/home_page/智能感知.png"
                    modeldata:""
                }
                ListElement{
                    name: "布防"
                    icon: "qrc:/images/home_page/布防.png"
                    modeldata:""
                }
                ListElement{
                    name: "背景音乐"
                    icon: "qrc:/images/home_page/背景音乐.png"
                    modeldata:""
                }
                ListElement{
                    name: "设备"
                    icon: "qrc:/images/home_page/设备.png"
                    modeldata:""
                }
            }
            delegate: Item{
                width: Math.max(item_icon.width, text.implicitWidth)
                height: item_icon.implicitHeight+text.implicitHeight+text.anchors.topMargin

                function setTopBarModel(){
                    gridmodel.clear()

                    if(modeldata!=""){
                        var temp = JSON.parse(modeldata)
                        for(var i in temp.icons){
                            gridmodel.append({"icon": temp.icons[i],
                                                 "name": temp.names[i]})
                        }
                    }
                }

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
                        setTopBarModel()
                    }
                }
            }
        }
    }
}
