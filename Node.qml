import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Shapes 2.0

Rectangle {
    id: node
<<<<<<< HEAD
    width: 20
    height: 20
    color: "blue";
    visible: true
    antialiasing: true
=======
>>>>>>> fd026fcf3f674747111cb172e5b15da46875a6ad


    property real largura;
    property real altura;

    Sphere{
        id:esfera
        scale: 20
    }
    width: 5
    height: 5

    scale: 2

    antialiasing: true

    signal updatePosition(real positionX, real positionY);

<<<<<<< HEAD
    Behavior on x { NumberAnimation{ duration:100; easing.type: Easing.OutBounce; } }
    Behavior on y { NumberAnimation { duration:100; easing.type: Easing.OutBounce } }
=======
    Behavior on x { NumberAnimation{ duration:60; easing.type: Easing.OutBounce; } }
    Behavior on y { NumberAnimation { duration:60; easing.type: Easing.OutBounce } }

    onXChanged: {
        esfera.position = Qt.vector3d(node.x - largura/2, esfera.y, esfera.z);

    }
    onYChanged: {
        esfera.position = Qt.vector3d(esfera.x, (0-node.y)-altura/2, esfera.z);
    }
>>>>>>> fd026fcf3f674747111cb172e5b15da46875a6ad

    onUpdatePosition:{
        x = positionX - (width/2)
        y = positionY - (height/2)
    }

    Timer{
        id: timerCobrinha
        running: true
        interval: 60
        repeat: true
        onTriggered: {

        }
    }

}
