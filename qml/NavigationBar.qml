import QtQuick 2.0

Image{
    property alias title: text.text

    source: "qrc:/images/home_page/导航栏背景.png"
    width: screen.size.width
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
    }

    Text{
        id: text

        anchors.centerIn: parent
        color: "white"
        font.pointSize: 18
    }
}
