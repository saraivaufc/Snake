import QtQuick 2.0

Rectangle {
    id: node
    width: 20
    height: 20
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
            PropertyChanges{target: cabeca; width: 40; height:40}
        },
        State {
            name: "COMENDO"
            PropertyChanges{target: cabeca; width:50; height:50}
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
        width: 40
        height: 40
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
