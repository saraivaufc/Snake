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
var nodeMeio = "/Img/node.png";
var nodeFim1 = "/Img/nodeFim1.png";
var nodeFim2 = "/Img/nodeFim2.png";
var nodeFim3 = "/Img/nodeFim3.png";

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

    adicionarCabeca(Campo, Campo.width/2,Campo.height/2);
    adiciona(Campo,0,0);
    adiciona(Campo,0,0);
    adiciona(Campo,0,0);



    criarComida(Campo);

    criarComida(Campo);

    for(var i=10 ; i>=1;i--){
        adiciona(Campo,0,0);
    }
    calcSpeed(cobra[0]);
}


function updateColor() {
    var increment = 1;

    for(var i = 0; i < 10; i++) {

        if(e1) {
            g += increment
            if(g % 100 >= (100 - increment)) {
                e1 = false
                e2 = true
            }
        }
        if(e2) {
            r += (100 - increment)
            if(r % 100 <= 0) {
                r = 0
                e2 = false
                e3 = true
            }
        }
        if(e3) {
            b += increment
            if(b % 100 >= (100 - increment)) {
                e3 = false
                e4 = true
            }
        }
        if(e4) {
            g += (100-increment)
            if(g % 100 <= 0) {
                g = 0
                e4 = false
                e5 = true
            }
        }
        if(e5) {
            r += increment
            if(r % 100 >= (100 - increment)) {
                e5 = false
                e6 = true
            }
        }
        if(e6) {
            b += (100 - increment)
            if(b % 100 <= 0){
                b = 0
                e6 = false
                e1 = true
            }
        }

        r %= 100
        g %= 100
        b %= 100

        //console.log(r+ " : " +g + " : " +b)
    }
}

function adiciona(Campo,xPosition , yPosition){
    updateColor();
    var component = Qt.createComponent("/Qml/Node.qml");
    var node = component.createObject(Campo, {"x":xPosition,
                                              "y":yPosition,
                                              "color":Qt.rgba(r/100, g/100,b/100 , 4)});


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
    move();
    for(var k = 1; k < cobra.length; k++){
        rotate(cobra[k], cobra[k-1]);
    }
    rotate(cobra[0], cobra[1]);
    moveNodes();
    if((cobra[0].x >= Campo.width || cobra[0].x <= 0) || (cobra[0].y >= Campo.height || cobra[0].y <= 0) ){
        gameOver(Campo);
    }
    for(var i = 4 ; i < cobra.length;i++){
        if(verificaColisao(cobra[0], cobra[i])){
            gameOver(Campo);
            return;
        }
    }

    for(var i=0 ; i< comidas.length ; i++){
        verificaColisaoParede(Campo);
        if(verificaColisao(cobra[0],comidas[i])){
            Campo.cobraComeu();
            cobra[0].state = "COMENDO";
            comeu(i);
            criarComida(Campo);
            crescer(Campo);
            aumentarNodos();
            return;
        }
    }

    if(cobra.length > 5 ){
        for(var k=1; k< (cobra.length-3); k++){
            cobra[k].sourceImagem = nodeMeio;
        }

        var color1 = cobra[cobra.length-1].color;
        var color2 = cobra[cobra.length-2].color;
        var color3 = cobra[cobra.length-3].color;

        cobra[cobra.length-1].sourceImagem = nodeFim1
        cobra[cobra.length-1].color = "transparent";


        cobra[cobra.length-2].sourceImagem = nodeFim2
        cobra[cobra.length-2].color = "transparent";

        cobra[cobra.length-3].sourceImagem = nodeFim3
        cobra[cobra.length-3].color = "transparent";

    }

}

function moveNodes(){

    for(var i = 1; i < cobra.length ; i++){
        cobra[i].x = cobra[i-1].x;
        cobra[i].y = cobra[i-1].y;
    }
}


function aumentarNodos(){
    var timer = 1;
    for(var i =1 ; i< cobra.length; i++){
        cobra[i].aumentar(timer);
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

function move(){
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
