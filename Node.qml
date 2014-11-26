import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: node
    width: 20
    height: 20
    visible: true
    antialiasing: true
    color: colorNode

    state: "NORMAL";

    property var sourceImagem : "/Img/Imagens/node.png";
    property var colorNode;
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
            name:"CRESCENDO1"
            when: timerAumentar1.stop();
            PropertyChanges {
                target: containerImagem
                width: 35
                height:35
            }
        },
        State{
            name:"CRESCENDO2"
            when: timerAumentar2.stop();
            PropertyChanges {
                target: containerImagem
                width: 60
                height:60
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
         id:timerAumentar1
        interval: timerCrescer
        running: false
        onTriggered: {
            node.state="CRESCENDO1"
        }
    }
    Timer{
        id:timerAumentar2
        interval: timerCrescer
        running: false
        onTriggered: {
            node.state="CRESCENDO2"
        }
    }

    function aumentar1(aumento){
        timerCrescer = aumento;
        timerAumentar1.running = true;
    }
    function aumentar2(aumento){
        timerCrescer = aumento;
        timerAumentar2.running = true;
    }

}
