import QtQuick 2.2
import QtQuick.Controls 1.1

import "/Js/GerenciadorCobra.js" as GCobra
import "/Js/GerenciadorComida.js" as GComida


ApplicationWindow {
    id:root
    width: 500
    height: 500
    visible: true
    Rectangle{
        id: campo;
        visible: true
        width: root.width
        height: root.height
        anchors.centerIn: parent

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
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            hoverEnabled: true
            anchors.fill: parent;
            onMouseXChanged: {
                GCobra.setPosicao(mouse.x, mouse.y);
            }
            onMouseYChanged: {
                GCobra.setPosicao(mouse.x, mouse.y);
            }

        }

        Rectangle{
            id: botaoAdicionar
            width: 40
            height: 40
            x: parent.width - width
            y: parent.height - height
            color: "red"
            visible: true

            MouseArea{
                id: mouseAreaBotaoAdicionar
                anchors.fill: parent
                onClicked:{
                    GComida.criarComida(campo);
                }

            }

        }

        Component.onCompleted: {
            GCobra.startGame(campo);
        }


    }

}
