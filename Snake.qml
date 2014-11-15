import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0

import "Game.js" as Game

Rectangle{
    id: campo;
    width: 500; height: 500
    visible: true


    signal criarComida();

    onCriarComida:{
        var comida = Qt.createComponent("Comida.qml");
        var status = comida.createObject(campo);
        if(status === null){
            console.log("Falha ao adicionar Comida!!");
        }
    }

    Timer {
        id: updateSnake;
        interval: 1;
        repeat: true;
        running: true;
        onTriggered: {
            Game.update(0);
            Game.paint(campo);
        }
    }

    MouseArea{
        id:mouseAreaCampo;
        anchors.fill: parent;
        onClicked : {
            Game.setPosicao(mouse.x, mouse.y);
        }
        onPressed: {
            Game.setPosicao(mouse.x, mouse.y);
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
                campo.criarComida();
            }

        }

    }

    Component.onCompleted: {
        Game.startGame();
    }


}
