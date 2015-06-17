import QtQuick 2.0

Image{
    property alias title: text.text
    signal buttonClicked

    source: "qrc:/images/home_page/导航栏背景.png"
    width: parent.width
    fillMode: Image.PreserveAspectFit

    Image{
        anchors{
            left: parent.left
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
        height: parent.height-10
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/home_page/左画框图标.png"

        MouseArea{
            anchors.fill: parent

            onClicked: buttonClicked()
        }
    }

    Text{
        id: text

        anchors.centerIn: parent
        color: "white"
        font.pointSize: 18
    }
}
