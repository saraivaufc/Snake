import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id:comida
    width: 20
    height: 20
    state: estado;
    color: "transparent";
    property var sourceImagem : "/Img/Imagens/rato.png"
    property var dir: ">";
    property var  estado: "NORMAL";

    signal morreu();

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
                height:40;
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
        },
        Transition {
            from: "NORMAL"; to: "GRANDE";
            NumberAnimation {
                target: containerImagem;
                properties: "width, height";
                duration: 100;
                easing.type: Easing.InOutBounce;

            }
            onRunningChanged: {
                sourceImagem  = "/Img/Imagens/aguia.png";
            }
        }
    ]



    Behavior on x {
        NumberAnimation{ duration: 100; easing.type: Easing.Linear}
    }
    Behavior on y {
        NumberAnimation{ duration: 100; easing.type: Easing.Linear}
    }


    AnimatedSprite {
        id: explosao
        anchors.centerIn: parent
        width: 20
        height: 20
        visible: false
        source: "/Img/Imagens/explosao.png"
        frameWidth: 85
        frameHeight: 85
        frameCount: 9
        frameRate: 9
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
            comida.estado="NORMAL";
            explosao.visible = true;
            containerImagem.visible = false;
            audioMorreu.play();
        }
    }

    onMorreu: {
        comida.state = "MORRENDO";
    }
}
