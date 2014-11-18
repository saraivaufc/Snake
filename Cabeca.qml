import QtQuick 2.0

Rectangle {
    id: node
    width: 20
    height: 20
    visible: true
    antialiasing: true
    state: "NORMAL"

    Timer{
        id: comendo
        interval: 1000
        onTriggered: {
           node.state = "NORMAL";
        }
    }

    states: [
        State {
            name: "NORMAL"
            PropertyChanges{target: cabeca; color: "green"}
        },
        State {
            name: "COMENDO"
            PropertyChanges{target: cabeca; color: "red"}
        }
    ]


    transitions:
        Transition {
        reversible: true
            NumberAnimation {
                target: cabeca
                properties: "color"
                duration: 1000;
            }
            onRunningChanged: {
                comendo.running = true

            }
        }


    Rectangle {
        id: cabeca
        anchors.centerIn: parent
        width: 40
        height: 40

    }


    signal updatePosition(real positionX, real positionY);

    Behavior on x { NumberAnimation{ duration:100; easing.type: Easing.OutBounce; } }
    Behavior on y { NumberAnimation { duration:100; easing.type: Easing.OutBounce } }

    onUpdatePosition:{
        x = positionX - (width/2)
        y = positionY - (height/2)
    }

    Timer{
        id: timerCobrinha
        running: true
        interval: 30
        repeat: true
        onTriggered: {

        }
    }


}
