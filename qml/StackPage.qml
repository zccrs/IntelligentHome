import QtQuick 2.4

Item {
    id: root

    property string pageName: ""
    readonly property bool isActive: view.currentItem == root
}

