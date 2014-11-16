import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0

import "GerenciadorCobra.js" as GCobra
import "GerenciadorComida.js" as GComida

Rectangle{
    id: campo;
    width: 500; height: 500
    visible: true

    Image {
        id: background
        anchors.fill: parent
        source: "background.png"
        fillMode: Image.PreserveAspectCrop
    }

    Timer {
        id: updateSnake;
        interval: 100;
        repeat: true;
        running: true;
        onTriggered: {
            GCobra.update(campo);
        }
    }

    MouseArea{
        id:mouseAreaCampo;
        anchors.fill: parent;
        onClicked : {
            GCobra.setPosicao(mouse.x, mouse.y);
        }
        onPressed: {
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
