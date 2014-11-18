import QtQuick 2.0

Rectangle {
    id:comida
    width: 20
    height: 20
    color: "transparent"

    property var dir: ">";

    Timer{
        id: timerUpdateDir
        interval:1000
        repeat: true
        running: true
        onTriggered: {
            calcProxPos();
        }
    }

    Timer{
        id:timerComida
        interval:100
        repeat: true
        running: true
        onTriggered: {
            updateComida();
        }
    }

    Image {
        id: imagemComida
        anchors.fill: parent
        source: "/Img/rato.png"
    }


    function calcProxPos(){
        var pos = parseInt(Math.random() * 4);
        if(pos === 0){
            dir = "<";
        }else if(pos === 1){
            dir = ">";
        }else if(pos === 2){
            dir = "A";
        }else{
            dir = "V";
        }

        console.log(pos);
    }

    function updateComida(){
        if(dir === ">"){
            comida.x+=5;
        }else if(dir === "<"){
            comida.x-=5;
        }else if(dir === "A"){
            comida.y-=5;
        }else{
            comida.y+=5;
        }
    }
}
