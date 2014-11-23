import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id:comida
    width: 20
    height: 20
    state: "NORMAL";
    color: "transparent";
    property var sourceImagem : "/Img/Imagens/rato.png"
    property var dir: ">";

    Rectangle{
        id: containerImagem;
        width: comida.width
        height: comida.height
        color: "transparent"
        Image {
            id: imagemComida
            anchors.fill: parent
            source: sourceImagem;
        }
    }


    Audio{
        id: audioMorreu
        source: "/Aud/Sons/Comeu.wav";
        autoLoad: true
    }


    states: [
        State{
            name:"MORRENDO"
            PropertyChanges {
                target: containerImagem
                width: 40
                height:40
            }
        },
        State {
            name: "NORMAL"
            PropertyChanges{
                target: containerImagem;
                width: 20;
                height:20
            }
        },
        State {
            name: "GRANDE"
            PropertyChanges{
                target: containerImagem;
                width: 40;
                height:40
            }
        }

    ]

    transitions:[
        Transition {
            from: "NORMAL"; to: "MORRENDO";
            NumberAnimation {
                target: containerImagem;
                properties: "width, height";
                duration: 100;
                easing.type: Easing.InOutBounce;
            }
            onRunningChanged: {
                morte.running = true;
            }
        },
        Transition {
            from: "GRANDE"; to: "MORRENDO";
            NumberAnimation {
                target: containerImagem;
                properties: "width, height";
                duration: 100;
                easing.type: Easing.InOutBounce;

            }
            onRunningChanged: {
                morte.running = true;
            }
        }
    ]



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
            audioMorreu.play();
        }
    }

    function morreu(){
        comida.state = "MORRENDO";
    }
}
