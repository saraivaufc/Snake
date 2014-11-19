import QtQuick 2.0
import QtQuick.Controls 1.1

import "/Js/GerenciadorPontuacao.js" as GPontuacao

Rectangle {

    property alias tempo: tempo

    width: 175
    height: 60
    visible: true
    color:"transparent";
    border.color: "#00000000"
    opacity: 1
    border.width: 4
    z:100;

    property int segundos: 0 ;

    Timer{
        id: timePontos
        interval: 1000/5
        running: true
        repeat: true
        onTriggered: {
            pontuacao.text = GPontuacao.getPontos();
        }
    }

    Timer {
        id: timeTempo
        interval: 1000;
        running: true;
        repeat: true
        onTriggered:{
            GPontuacao.inclementaTempo();
            tempo.text = GPontuacao.getTempo();
        }
    }

    Text {
        id: text1
        x: 4
        y: 8
        width: 68
        height: 22
        text: qsTr("Tempo")
        font.italic: true
        clip: false
        style: Text.Normal
        font.underline: false
        font.bold: true
        font.family: "Times New Roman"
        font.pixelSize: 21
    }

    Text {
        id: text2
        x: 79
        y: 8
        width: 104
        height: 24
        text: qsTr("Pontuaçao")
        font.italic: true
        font.family: "Times New Roman"
        font.bold: true
        font.pixelSize: 21
    }

    Text {
        id: tempo
        x: 13
        y: 36
        width: 59
        height: 24
        text: qsTr("00:00")
        font.italic: true
        font.family: "Times New Roman"
        font.bold: true
        font.pixelSize: 21
    }

    Text {
        id: pontuacao
        x: 114
        y: 36
        width: 51
        height: 18
        text: qsTr("0")
        font.italic: true
        font.family: "Times New Roman"
        font.bold: true
        font.pixelSize: 21
    }

    function inclementaPontuacao(){
        GPontuacao.inclementaPontos();
    }
}
