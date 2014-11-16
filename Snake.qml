import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0

import "GerenciadorCobra.js" as GCobra
import "GerenciadorComida.js" as GComida

Rectangle{
    id:root
    width: parent.width
    height: parent.height
    border.color: "black";
    border.width: 10;

    Rectangle{
        id: campo;
        visible: true
        width: parent.width-10
        height: parent.height-10
        anchors.centerIn: parent

        Image {
            id: background
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            source: "background.jpg"
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
