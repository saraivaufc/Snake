import QtQuick 2.0

Rectangle {
    id: node
    width: 20
    height: 20
    color: "blue";
    visible: true
    antialiasing: true


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
        interval: 60
        repeat: true
        onTriggered: {

        }
    }

}
