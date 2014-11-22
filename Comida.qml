import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id:comida
    width: 40
    height: 40
    color: "transparent"
    property var sourceImagem : "/Img/Imagens/rato.png"
    property var dir: ">";

    Rectangle{
        id: containerImagem;
        width: parent.width/2
        height: parent.height/2
        color: "transparent"
        Image {
            id: imagemComida
            anchors.fill: parent
            source: sourceImagem;
        }
    }


    Audio{

    }


    states: [
        State{
            name:"MORRENDO"
            PropertyChanges {
                target: containerImagem
                width: 50
                height:50
            }
        },
        State {
            name: "NORMAL"
            PropertyChanges{
                target: containerImagem;
                width: 20;
                height:20
            }
        }

    ]

    transitions: Transition {
        NumberAnimation {
            target: containerImagem;
            properties: "width, height";
            duration: 100;
        }
        onRunningChanged: {
            morte.running = true;
        }
    }



    Behavior on x {
        NumberAnimation{ duration: 50; easing.type: Easing.Linear}
    }
    Behavior on y {
        NumberAnimation{ duration: 50; easing.type: Easing.Linear}
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
        interval: 100;
        repeat: true;
        running: true;
        onTriggered: {
            parent.parent.updateComida();
        }
    }

    Timer {
        id: morte
        interval: 500
        running: false
        onTriggered: {
            comida.state="NORMAL";
            sourceImagem = "/Img/Imagens/ratoMorto.png";
        }
    }

    function morreu(){
        comida.state = "MORRENDO";
    }
}
