.pragma library

//DEFINES DAS DIRECOES

var LEFT = "<";
var RIGHT = ">";
var UP = "A";
var DONW = "V";


var cobra = []
var mousePositionX = 0;
var mousePositionY = 0;
var direcao = RIGHT;



function startGame(){
    var novoNodo = Qt.createComponent("Node.qml");
    novoNodo.x = mousePositionX;
    novoNodo.y = mousePositionY;
    cobra.push(novoNodo);
}

function adicionar(){
    var novoNodo = Qt.createComponent("Node.qml");
    var xUltima = cobra[cobra.length-1].x;
    var yUltima = cobra[cobra.length-1].y;

    var proxX, proxY = dir();
    update(0,proxX, proxY);

    novoNodo.x = xUltima;
    novoNodo.y = yUltima;
    cobra.push(novoNodo);
}

function remover(){
    cobra.pop();
}


function dirX(){
    var proxX = cobra[0].x;

    if(mousePositionX > cobra[0].x){
        proxX++;
        direcao = RIGHT;
    }else if(mousePositionX < cobra[0].x){
        proxX--;
        direcao = LEFT;
    }else if(mousePositionX === cobra[0].x){
        if(direcao === RIGHT){
            proxX++;
        }else if(direcao === LEFT){
           proxX--;
        }
    }
    return proxX;
}

function dirY(){
    var proxY = cobra[0].y;
    if(mousePositionY > cobra[0].y){
        proxY++;
        direcao = DONW;
    }else if(mousePositionY < cobra[0].y){
        proxY--;
        direcao = UP;
    }else  if(mousePositionY === cobra[0].y){
        if(direcao === DONW){
            proxY++;
        }else if(direcao === UP){
            proxY--;
        }
    }
    return proxY;
}

function update(index){
    apagaNode(cobra[cobra.length-1]);
    var x = dirX();
    var y = dirY();
   // console.log(x + "@" + y);

    var xTemp = cobra[index].x
    var yTemp = cobra[index].y

    mover(cobra[index], x, y);

    for(var i = 1; i< cobra.length ; i++){
        var xTemp2 = cobra[i].x;
        var yTemp2 = cobra[i].y;

        mover(cobra[i], xTemp, yTemp);
        xTemp = xTemp2;
        yTemp =  yTemp2;

    }
}

function apagaNode(node){
    //node.destroy();
}

function mover(node, x, y){
    node.x = x;
    node.y = y;
}

function setPosicao(x, y){
    mousePositionX = x;
    mousePositionY = y;
}

function paint(Campo){
    for(var i = 0 ; i < cobra.length; i++){
        cobra[i].createObject(Campo, {"x":cobra[i].x,"y":cobra[i].y});
    }

    console.log(cobra.length);
}
