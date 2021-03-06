import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0

import "/Js/GerenciadorCobra.js" as GCobra


ApplicationWindow {
    id:root
    width: Screen.width
    height: Screen.height
    visible: true
    color: "black";


    Rectangle{
        id: campo;
        visible: true
        width: root.width-20
        height: root.height-20
        anchors.centerIn: parent


        signal gameOver();
        signal cobraComeu();
        signal calPosComida();
        signal updateComida();


        Image {
            id: background
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            source: "/Img/Imagens/background.jpg"
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

        Timer{
            id:criarComida
            interval: 2000
            repeat: true
            running: true
            onTriggered: {
                GCobra.criarComida(campo);
            }

        }

        MouseArea{
            id:mouseAreaCampo;
            anchors.fill: parent;
            hoverEnabled: true
            onClicked:  {
                GCobra.setPosicao(mouse.x, mouse.y);
            }
        }

        Pontuacao{
            id: pontuacao
        }

        Component.onCompleted: {
            GCobra.startGame(campo);
        }

        onGameOver: {
            updateSnake.stop();
            criarComida.stop();
            GCobra.destroy();
            gameover.visible = true;
            pontuacao.parar();
        }

        onCobraComeu: {
            pontuacao.inclementaPontuacao();
        }

        onCalPosComida: {
            GCobra.calculaPosicaoComida();
        }

        onUpdateComida: {
            GCobra.atualizaComida();
        }



    }

    Image {
        id:gameover
        width: parent.width
        height:parent.height
        visible: false;
        source: "/Img/Imagens/gameover.png"

        Rectangle{
            id: sair
            width: 100
            height: 100
            smooth: true
            color: "transparent"
            y : (parent.height - imagemSair.height)-10 ;
            x : 10

            states: State {
                name: "VISIVEL";
                when: sair.visible === true
                PropertyChanges {target: sair}
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
                source: "/Img/Imagens/sair.png"
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
