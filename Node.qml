import QtQuick 2.0

Rectangle {
    id: node
    width: 20
    height: 20
    visible: true
    antialiasing: true

    property var sourceImagem : "/Img/node.png";

    Image {
        id: imagenNode
        anchors.fill: parent
        anchors.centerIn: parent
        source: sourceImagem;
    }

    signal updatePosition(real positionX, real positionY);

    Behavior on x { NumberAnimation{ duration:100; easing.type: Easing.OutBounce; } }
    Behavior on y { NumberAnimation { duration:100; easing.type: Easing.OutBounce } }

    onUpdatePosition:{
        x = positionX - (width/2)
        y = positionY - (height/2)
    }

    Timer{
        id: timerCobrinha
        running: true
        interval: 30
        repeat: true
        onTriggered: {

        }
    }

}
