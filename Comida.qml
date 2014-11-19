import QtQuick 2.0

Rectangle {
    id:comida
    width: 20
    height: 20
    color: "transparent"
    property var dir: ">";

    Image {
        id: imagemComida
        anchors.fill: parent
        source: "/Img/rato.png"
    }


    Behavior on x {
        NumberAnimation{ duration: 100; easing.type: Easing.Linear}
    }
    Behavior on y {
        NumberAnimation{ duration: 100; easing.type: Easing.Linear}
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
