import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0


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
        id: timerSnake;
        interval: 50;
        repeat: true;
        running: true;
    }

    MouseArea{
        id:mouseAreaCampo;
        anchors.fill: parent;
        onClicked: node.updatePosition(mouse.x, mouse.y);
    }

    Node{
        id: node
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
            onClicked: campo.criarComida();
        }

    }


}
