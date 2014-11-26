Qt.include("/Js/GerenciadorComida.js");
Qt.include("/Js/Funcoes.js");

var cobra = [];
var mousePositionX = 1000;
var mousePositionY = 1000;

//DEFINE DOS MOVIMENTOS
var distanciaDefault = 20;
var distanciaX = 0;
var distanciaY = 0;



//SOURCERS IMAGENS
var nodeMeio = "/Img/Imagens/node.png";
var nodeFim1 = "/Img/Imagens/nodeFim1.png";
var nodeFim2 = "/Img/Imagens/nodeFim2.png";
var nodeFim3 = "/Img/Imagens/nodeFim3.png";

//COLORS
var r = 99;
var g = 0;
var b = 0;

var e1 = true;
var e2 = false;
var e3 = false;
var e4 = false;
var e5 = false;
var e6 = false;


function startGame(Campo){

    adicionarCabeca(Campo, Campo.width/4,Campo.height/4);
    for(var i=5 ; i>=1;i--){
        adiciona(Campo,0,0);
    }
    calcSpeed(cobra[0]);
}

function updateColor() {

    for(var i = 0; i < 5; i++) {

        if(e1) {
            g++;
            if(g % 100 >= 99) {
                e1 = false
                e2 = true
            }
        }
        if(e2) {
            r += 99
            if(r % 100 <= 0) {
                r = 0
                e2 = false
                e3 = true
            }
        }
        if(e3) {
            b++;
            if(b % 100 >= 99) {
                e3 = false
                e4 = true
            }
        }
        if(e4) {
            g += 99
            if(g % 100 <= 0) {
                g = 0
                e4 = false
                e5 = true
            }
        }
        if(e5) {
            r++;
            if(r % 100 >= (99)) {
                e5 = false
                e6 = true
            }
        }
        if(e6) {
            b += 99
            if(b % 100 <= 0){
                b = 0
                e6 = false
                e1 = true
            }
        }
        r %= 100
        g %= 100
        b %= 100
    }
}

function adiciona(Campo,xPosition , yPosition){
    updateColor();
    var component = Qt.createComponent("/Qml/Node.qml");
    var node = component.createObject(Campo, {"x":xPosition,
                                              "y":yPosition,
                                              "colorNode":Qt.rgba(r/100, g/100,b/100 , 4)});


    node.x = xPosition;
    node.y = yPosition;
    cobra.push(node);
}

function adicionarCabeca(Campo,xPosition , yPosition){
    updateColor();
    var component = Qt.createComponent("/Qml/Cabeca.qml");
    var cabeca = component.createObject(Campo, {"x":xPosition,
                                              "y":yPosition,
                                              "z":1000000});
    cobra.push(cabeca);
}


function update(Campo){
    var xPos = cobra[0].x;
    var yPos = cobra[0].y;

    moveCabeca();
    rotacionaNodos(Campo);
    moveNodes(xPos, yPos);
    verificaColisaoCobraParede(Campo);
    verificaColisaoCobraCobra(Campo);
    verificaColisaoCabecaComida(Campo);
    verificaColisaoComidaNodes(Campo);
    verificaColisaoComidaComida(Campo);
    updateRabo();

}

function moveNodes(x, y){

    cobra[1].x = x;
    cobra[1].y = y;
    for(var i = 2; i < cobra.length ; i++){
        cobra[i].x = cobra[i-1].x;
        cobra[i].y = cobra[i-1].y;
    }
}


function aumentarNodos(tipo){
    var timer = 1;
    for(var i =1 ; i< cobra.length; i++){
        if(tipo === 1){
            cobra[i].aumentar1(timer);
        }else if(tipo === 2){
            cobra[i].aumentar2(timer);
        }

        timer +=20;
    }
}

function calcSpeed(node){
    var D = Math.sqrt(   Math.pow(mousePositionX-node.x,2) + Math.pow(mousePositionY-node.y,2)  );
    var DX = mousePositionX - node.x;
    var DY = mousePositionY - node.y;
    distanciaX = (distanciaDefault * DX)/D;
    distanciaY = (distanciaDefault * DY)/D;
}

function moveCabeca(){
    if(cobra.length <= 0){
        console.log("Cobra vazia!!");
        return;
    }
    cobra[0].x += distanciaX;
    cobra[0].y += distanciaY;
}

function gameOver(Campo){
    Campo.gameOver();
}


function setPosicao(x, y){
    mousePositionX = x;
    mousePositionY = y;
    calcSpeed(cobra[0]);

}


function destroy(){
    for(var i =0 ; i < cobra.length ; i++){
        cobra.pop().destroy();
    }
}

function crescer(Campo){
    adiciona(Campo, cobra[cobra.length-1].x, cobra[cobra.length-1].y);
}

function calculaPosicaoComida(){
    calcProxPos();
}

function atualizaComida(){
    updateComida();
}


function updateRabo(){
    if(cobra.length > 5){
        for(var i = 1; i<cobra.length-1; i++){
             cobra[i].sourceImagem = nodeMeio;
             cobra[i].color =  cobra[i].colorNode;
        }

        cobra[cobra.length-1].sourceImagem = nodeFim1;
        cobra[cobra.length-1].color = "transparent";

        cobra[cobra.length-2].sourceImagem = nodeFim2;
        cobra[cobra.length-2].color = "transparent";

        cobra[cobra.length-3].sourceImagem = nodeFim3;
        cobra[cobra.length-3].color = "transparent";
    }
}

function rotacionaNodos(Campo){
    for(var k = 1; k < cobra.length; k++){
        rotate(cobra[k], cobra[k-1]);
    }
    rotate(cobra[0], cobra[1]);
}

function verificaColisaoCobraParede(Campo){
    if((cobra[0].x >= Campo.width || cobra[0].x <= 0) || (cobra[0].y >= Campo.height || cobra[0].y <= 0) ){
        gameOver(Campo);
    }
}

function verificaColisaoCobraCobra(Campo){
    for(var i = 4 ; i < cobra.length;i++){
        if(verificaColisao(cobra[0], cobra[i])){
            gameOver(Campo);
        }
    }
}

function verificaColisaoCabecaComida(Campo){
    for(var i=0 ; i< comidas.length ; i++){
        if(verificaColisao(cobra[0],comidas[i])){
            cobra[0].state = "COMENDO";
            crescer(Campo);
            if(comidas[i].estado === "GRANDE"){
                console.log("Cobra Comeu um Gavião!!!");
                aumentarNodos(2);
                for(var p=0; p<10; p++){
                    Campo.cobraComeu();
                }
            }else{
                console.log("Cobra Comeu um Rato!!!");
                aumentarNodos(1);
                Campo.cobraComeu();
            }
            comeu(i);
        }
    }
    for(var i=0 ; i< comidasMortas.length ; i++){
        if(verificaColisao(cobra[0],comidasMortas[i])){
            gameOver(Campo);
        }
    }
}

function verificaColisaoComidaNodes(Campo){
    for(var i=0; i<comidas.length ; i++){
        for(var k=1; k< cobra.length;k++){
            if(verificaColisao(cobra[k],comidas[i])){
                var x = comidas.splice(i,1);
                if(x[0].estado === "GRANDE"){
                    console.log("Rato Grande Bateu na Cobra");
                    gameOver(Campo);
                }

                x[0].morreu();
                comidasMortas.push(x[0]);
            }
        }
    }
}

function verificaColisaoComidaComida(Campo){
    for(var i=0 ; i< comidas.length; i++){
        for(var k=i+1 ; k<comidas.length; k++){
            if(verificaColisao(comidas[i],comidas[k])){
                comidas[i].estado = "GRANDE";
                comidas[k].estado = "GRANDE";
            }
        }
    }
}
