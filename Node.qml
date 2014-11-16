import QtQuick 2.0

Rectangle {
    id: node
    width: 10
    height: 10
    color: "blue";
    visible: true
    antialiasing: true


    signal updatePosition(real positionX, real positionY);

    Behavior on x { NumberAnimation{ duration:50; easing.type: Easing.OutBounce; } }
    Behavior on y { NumberAnimation { duration:50; easing.type: Easing.OutBounce } }

    onUpdatePosition:{
        x = positionX - (width/2)
        y = positionY - (height/2)
    }

    Timer{
        id: timerCobrinha
        running: true
        interval: 23
        repeat: true
        onTriggered: {

        }
    }

}
