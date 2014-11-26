import QtQuick 2.0



Rectangle {
    id:comida
    width: 30
    height: 30
    state: estado;
    color: "transparent";
    property var sourceImagem : "/Img/Imagens/rato.png"
    property var dir: ">";
    property var  estado: "NORMAL";

    signal morreu();

    Rotation{
        id: rotacaoLeft
        axis {y:0; x:0 ; z:0}
    }
    Rotation{
        id: rotacaoRigth
        origin.x: width/2;
        origin.y: height/2;
        axis { x: 0; y: 1; z: 0 }
        angle: 180
    }


    states: [
        State{
            name:"MORRENDO"
            PropertyChanges {
                target: comida
                width: 40
                height:40
            }
        },
        State {
            name: "NORMAL"
            PropertyChanges{
                target: comida;
                width: 30;
                height:30
            }
        },
        State {
            name: "GRANDE"
            PropertyChanges{
                target: comida;
                width: 40;
                height:40;
            }
        }

    ]

    transitions:[
        Transition {
            from: "NORMAL"; to: "MORRENDO";
            NumberAnimation {
                target: comida;
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
                target: comida;
                properties: "width, height";
                duration: 100;
                easing.type: Easing.InOutBounce;

            }
            onRunningChanged: {
                imagemComida.visible = false;
                aguia.visible = true
            }
        }
    ]



    Behavior on x {
        NumberAnimation{ duration: 100; easing.type: Easing.Linear}
    }
    Behavior on y {
        NumberAnimation{ duration: 100; easing.type: Easing.Linear}
    }

    Image {
        id: imagemComida
        anchors.fill: parent
        source: sourceImagem;
    }


    AnimatedSprite{
        id: aguia
        width: comida.width
        height: comida.height
        anchors.horizontalCenter: comida.horizontalCenter
        visible: false
        source: "/Img/Imagens/aguia.png";
        frameWidth: 40
        frameHeight: 40
        frameCount: 8
        frameRate: 4
    }


    AnimatedSprite {
        id: explosao
        anchors.centerIn: parent
        width: comida.width
        height: comida.height
        visible: false
        source: "/Img/Imagens/explosao.png"
        frameWidth: 85
        frameHeight: 85
        frameCount: 9
        frameRate: 9
    }
    Timer {
        id: updaterRotation
        interval: 10
        repeat: true
        running: true
        onTriggered: {
            if(dir === ">" || dir === "b" || dir === "d"){
                comida.transform = rotacaoRigth;
            }else if(dir === "<" || dir === "a" || dir === "c"){
                comida.transform = rotacaoLeft;
            }
        }
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
        interval: 1000/20;
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
            imagemComida.visible = false;
        }
    }

    onMorreu: {
        comida.state = "MORRENDO";
    }
}
