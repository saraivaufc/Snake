import QtQuick 2.2
import QtQuick.Controls 1.1

import "/Js/GerenciadorCobra.js" as GCobra
import "/Js/GerenciadorComida.js" as GComida


ApplicationWindow {
    id:root
    width: 640
    height: 480
    visible: true
    color: "black"

    visibility: "FullScreen";


    Rectangle{
        id: campo;
        visible: true
        width: root.width-20
        height: root.height-20
        anchors.centerIn: parent


        signal gameOver();
        signal cobraComeu();


        Image {
            id: background
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            source: "/Img/background.jpg"
        }

        Timer {
            id: updateSnake;
            interval: 1000/30;
            repeat: true;
            running: true;
            onTriggered: {
               GCobra.update(campo);
            }
        }

        MouseArea{
            id:mouseAreaCampo;
            anchors.fill: parent;
            onMouseXChanged: {
                GCobra.setPosicao(mouse.x, mouse.y);
            }
            onMouseYChanged: {
                GCobra.setPosicao(mouse.x, mouse.y);
            }

        }

        Component.onCompleted: {
            GCobra.startGame(campo);
        }



        onGameOver: {
            updateSnake.stop();
            GCobra.destroy();
            gameover.visible = true;
        }

        onCobraComeu: {
            pontuacao.inclementaPontuacao();
        }

        Pontuacao{
            id: pontuacao
        }

    }

    Image {
        id:gameover
        width: parent.width
        height:parent.height
        visible: false;
        source: "/Img/gameover.jpg"

        Rectangle{
            id: sair
            width: 200
            height: 100
            smooth: true
            antialiasing: true
            y : (parent.height/2);
            x : -300

            states: State {
                name: "VISIVEL";
                when: sair.visible === true
                PropertyChanges {target: sair; x: (parent.width/2)}
            }

            transitions:
                Transition {
                    NumberAnimation {
                        properties: "x";
                        duration: 1000;
                        easing.type: Easing.OutExpo;
                    }
                }

            Image {
                id: imagemSair
                width: parent.width
                height: parent.height
                anchors.fill: parent
                source: "/Img/sair.png"
            }

            MouseArea{
                id: mouseAreaSair
                anchors.fill: parent
                onClicked: {
                    root.close();
                }
            }
        }


    }


}
