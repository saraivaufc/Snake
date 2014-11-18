var comidas = [];

function criarComida(Campo) {
    var comida = Qt.createComponent("/Qml/Comida.qml");
    var status = comida.createObject(Campo, {"x": Math.random() * Campo.width,
                                             "y": Math.random() * Campo.height});
    if(status === null){
        console.log("Falha ao adicionar Comida!!");
        return;
    }
    comidas.push(status);

}

function comeu(index){
    var element = comidas.splice(index,1);
    element[0].destroy();
}
