Qt.include("/Js/Funcoes.js");

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


function verificaColisaoParede(Campo){
    for(var i = 0 ; i < comidas.length ; i++){
        var x = comidas[i].x;
        var y = comidas[i].y;
        if(!verificaColisao(comidas[i], Campo)){
            comidas[i].x = x;
            comidas[i].y = y;
        }
    }
}
