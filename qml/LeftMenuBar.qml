import QtQuick 2.0

Item{
    id: root

    height: parent.height*0.85
    Column{
        anchors.fill: parent
        spacing: width/20

        Item{
            id: item1

            width: parent.width
            height: logo.implicitHeight
            Image{
                id: logo

                fillMode: Image.PreserveAspectFit
                anchors{
                    left: parent.left
                    right: text_tianlidun.left
                    rightMargin: 10
                }

                source: "qrc:/images/侧滑框/logo背景.png"
                Image{
                    anchors{
                        fill: parent
                        margins: logo.width/5
                    }

                    source: "qrc:/images/home_page/logo.png"
                }
            }
            Text{
                id: text_tianlidun

                anchors{
                    verticalCenter: logo.verticalCenter
                    right: parent.right
                }

                text: "天力盾智能家居"
                color: "white"
                font.pointSize: 18
            }
        }

        Row{
            id: item2

            height: cellphoneicon.implicitHeight
            spacing: root.width/20
            Text{
                id: text_phone_number

                text: "免费电话：400-030-8767"
                color: "#b9b9c8"
                font.pointSize: 12
            }
            Image{
                source: "qrc:/images/侧滑框/电话竖线.png"
                height: text_phone_number.implicitHeight
                fillMode: Image.PreserveAspectFit
            }
            Image{
                id:cellphoneicon
                height: text_phone_number.implicitHeight
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/侧滑框/拨打图标.png"
            }
        }
        Image{
            id: item3

            source: "qrc:/images/侧滑框/山高任鸟飞.png"
            width: root.width
            fillMode: Image.PreserveAspectFit
        }

        ListView{
            id: menulist

            anchors.right: parent.right
            width: parent.width*0.8
            height: root.height-item1.height-item2.height-
                    item3.implicitHeight-item4.height-item5.height-width/4
            spacing: height/30
            clip: true

            model: ListModel{
                ListElement{
                    icon: "qrc:/images/侧滑框/01_r1_c2.png"
                    name: "设备搜索"
                }
                ListElement{
                    icon: "qrc:/images/侧滑框/01_r3_c1.png"
                    name: "背景音乐"
                }
                ListElement{
                    icon: "qrc:/images/侧滑框/01_r5_c3.png"
                    name: "房间"
                }
                ListElement{
                    icon: "qrc:/images/侧滑框/01_r7_c4.png"
                    name: "摄像头"
                }
                ListElement{
                    icon: "qrc:/images/侧滑框/01_r9_c4.png"
                    name: "情景模式"
                }
                ListElement{
                    icon: "qrc:/images/侧滑框/01_r11_c4.png"
                    name: "时间联动"
                }
                ListElement{
                    icon: "qrc:/images/侧滑框/01_r13_c5.png"
                    name: "空气质量"
                }
            }

            delegate: Column{
                width: parent.width
                spacing: root.width/20

                Item{
                    width: parent.width
                    height: menu_name.implicitHeight

                    Row{
                        spacing: root.width/20
                        Image{
                            source: icon
                            height: menu_name.implicitHeight
                            fillMode: Image.PreserveAspectFit
                        }
                        Text{
                            id: menu_name

                            text: name
                            color: "#b9b9c8"
                            font.pointSize: 14
                        }
                    }
                    Image{
                        source: "qrc:/images/侧滑框/》.png"
                        anchors.right: parent.right
                        height: menu_name.implicitHeight
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Image{
                    source: "qrc:/images/侧滑框/直线.png"
                    width: parent.width
                }
            }
        }

        Item{
            id: item4

            height: root.width/10
            width: parent.width
        }

        Row{
            id: item5

            height: settingsicon.implicitHeight
            anchors.left: menulist.left

            spacing: root.width/20
            Image{
                id: settingsicon

                source: "qrc:/images/侧滑框/01_r15_c4.png"
                height: text_setting.implicitHeight
                fillMode: Image.PreserveAspectFit
            }
            Text{
                id: text_setting

                text: "设置"
                color: "#b9b9c8"
                font.pointSize: 14
            }
        }
    }
}
