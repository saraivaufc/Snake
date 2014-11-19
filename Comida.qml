import QtQuick 2.0

Rectangle {
    id:comida
    width: 40
    height: 40
    color: "transparent"
    property var dir: ">";

    Rectangle{
        width: parent.width/2
        height: parent.height/2
        color: "transparent"
        Image {
            id: imagemComida
            anchors.fill: parent
            source: "/Img/rato.png"
        }
    }




    Behavior on x {
        NumberAnimation{ duration: 1000; easing.type: Easing.Linear}
    }
    Behavior on y {
        NumberAnimation{ duration: 1000; easing.type: Easing.Linear}
    }

    Timer {
        id: calculaPosicaoComida
        interval: 1000;
        repeat: true;
        running: true;
        onTriggered: {
            parent.parent.calPosComida();
        }
    }

    Timer {
        id:timerUpdateComida
        interval: 1000;
        repeat: true;
        running: true;
        onTriggered: {
            parent.parent.updateComida();
        }
    }
}
