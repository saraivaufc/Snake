import QtQuick 2.0

Rectangle {
    width: 20
    height: 20

    Component.onCompleted:{
        x = Math.random() * parent.width - width
        y = Math.random() * parent.height - height
        color = Qt.rgba(Math.random(), Math.random(), Math.random(), 2);
    }
}
