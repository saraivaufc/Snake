import QtQuick 2.2
import QtQuick.Controls 1.1
import Qt3D 2.0
import Qt3D.Shapes 2.0

import "GerenciadorCobra.js" as GCobra
import "GerenciadorComida.js" as GComida


ApplicationWindow {
    id:root
    width: 500
    height: 500
    visible: true


    Viewport{
        id: campo;
        visible: true
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        property int largura: root.width;
        property int altura: root.height;

        camera: Camera { eye: Qt.vector3d(2,100,1000)}



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
