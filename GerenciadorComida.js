function criarComida(Campo) {
    var comida = Qt.createComponent("Comida.qml");
    var status = comida.createObject(Campo);
    if(status === null){
        console.log("Falha ao adicionar Comida!!");
    }
}
