import QtQuick 2.0

Rectangle {
    width: 10
    height: 10

    Component.onCompleted:{
        x = Math.random() * parent.width - width
        y = Math.random() * parent.height - height
        color = Qt.rgba(Math.random(), Math.random(), Math.random(), 4);
    }
}
