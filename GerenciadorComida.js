Qt.include("/Js/Funcoes.js");

var comidas = [];
var dir = ">";

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

    for(var i = 0 ; i< comidas.length; i++){
        if(dir === ">"){
            comidas[i].x+=5;
        }else if(dir === "<"){
            comidas[i].x-=5;
        }else if(dir === "A"){
            comidas[i].y-=5;
        }else{
            comidas[i].y+=5;
        }
    }
}
