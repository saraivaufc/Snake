import QtQuick 2.0

Rectangle {
    id:comida
    width: 20
    height: 20
    color: "transparent"

    Image {
        id: imagemComida
        anchors.fill: parent
        source: "/Img/rato.png"
    }
}
