import QtQuick 2.0

Rectangle {
    id: node
    width: 10
    height: 10
    color:"transparent";
    antialiasing: true
    state: "NORMAL"


    signal updatePosition(real positionX, real positionY);

    Timer{
        id: timerCobrinha
        running: true
        interval: 30
        repeat: true
        onTriggered: {

        }
    }

    Timer{
        id: comendo
        interval: 1000
        onTriggered: {
           node.state = "NORMAL";
        }
    }

    states: [
        State {
            name: "NORMAL"
            PropertyChanges{target: cabeca; width: 30; height:30}
        },
        State {
            name: "COMENDO"
            PropertyChanges{target: cabeca; width:40; height:40}
        }
    ]

    Behavior on x { NumberAnimation{ duration:50; easing.type: Easing.Linear } }
    Behavior on y { NumberAnimation { duration:50; easing.type: Easing.Linear } }


    transitions:
        Transition {
        from: "NORMAL"; to: "COMENDO";
            NumberAnimation {
                target: cabeca
                properties: "width, height"
                duration: 10;
            }
            onRunningChanged: {
                comendo.running = true

            }
        }


    AnimatedSprite {
        id: cabeca
        anchors.centerIn: parent
        width: 30
        height: 30
        rotation: -90
        source: "/Img/Imagens/cabeca.png"
        frameWidth: 50
        frameHeight: 50
        frameCount: 50
        frameRate: 10
    }



    onUpdatePosition:{
        x = positionX - (width/2)
        y = positionY - (height/2)
    }
}
