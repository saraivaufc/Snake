import QtQuick 2.0

Rectangle {
    id: node
    width: 20
    height: 20
    color: "blue";
    visible: true

    signal updatePosition(real positionX, real positionY);

    Behavior on x { PropertyAnimation { easing.type: Easing.Linear; } }
    Behavior on y { PropertyAnimation { easing.type: Easing.Linear; } }

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
