import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: node
    width: 20
    height: 20
    visible: true
    antialiasing: true
    state: "NORMAL";

    property var sourceImagem : "/Img/Imagens/node.png";
    property int timerCrescer;


    Rectangle{
       id: containerImagem
       width: 20
       height: 20
       color: parent.color
       anchors.centerIn: parent
       Image {
           id: imagenNode
           anchors.fill: parent
           anchors.centerIn: parent
           source: sourceImagem;
           antialiasing: true

       }
    }



    signal updatePosition(real positionX, real positionY);

    Behavior on x { NumberAnimation{ duration:50; easing.type: Easing.Linear } }
    Behavior on y { NumberAnimation { duration:50; easing.type: Easing.Linear } }

    onUpdatePosition:{
        x = positionX - (width/2)
        y = positionY - (height/2)
    }

    states: [
        State{
            name:"CRESCENDO"
            when: timerAumentar.stop();
            PropertyChanges {
                target: containerImagem
                width: 35
                height:35
            }
        },
        State {
            name: "NORMAL"
            PropertyChanges{
                target: containerImagem;
                width: 20;
                height:20
            }
        }

    ]

    transitions: Transition {
        NumberAnimation {
            target: containerImagem;
            properties: "width, height";
            duration: 100;
        }
        onRunningChanged:{
            timerDiminuindo.running = true;
        }
    }

    Timer{
        id: timerDiminuindo
        interval: 100
        running: false
        onTriggered: {
            node.state = "NORMAL"
        }
    }

    Timer{
         id:timerAumentar
        interval: timerCrescer
        running: false
        onTriggered: {
            node.state="CRESCENDO"
        }
    }

    function aumentar(aumento){
        timerCrescer = aumento;
        timerAumentar.running = true;
    }

}
