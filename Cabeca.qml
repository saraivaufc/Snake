import QtQuick 2.0

Rectangle {
    id: node
    width: 20
    height: 20
    color:"transparent";
    antialiasing: true
    state: "NORMAL"

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


    transitions:
        Transition {
        reversible: true
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
        source: "/Img/cabeca.png"
        frameWidth: 50
        frameHeight: 50
        frameCount: 50
        frameRate: 10


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
