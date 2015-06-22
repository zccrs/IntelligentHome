import QtQuick 2.0

Image{
    id: root

    source: "qrc:/images/home_page/标签栏背景.png"
    width: parent.width
    fillMode: Image.PreserveAspectFit

    Row{
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        spacing: parent.width/5

        Image{
            source: "qrc:/images/home_page/客服图标.png"
            fillMode: Image.PreserveAspectFit
            width: root.width/11
            anchors{
                verticalCenter: speech_icon.verticalCenter
                verticalCenterOffset: height/5
            }
        }

        Image{
            id: speech_icon
            source: "qrc:/images/home_page/语音图标.png"
            fillMode: Image.PreserveAspectFit
            width: root.width/6

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    utility.listenSpeech()
                    //开始录音
                }
            }
        }

        Image{
            source: "qrc:/images/home_page/摄像机图标.png"
            fillMode: Image.PreserveAspectFit
            width: root.width/11
            anchors{
                verticalCenter: speech_icon.verticalCenter
                verticalCenterOffset: height/5
            }
        }
    }
}



