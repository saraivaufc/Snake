.pragma library

var cobra = []
var mousePositionX = 0;
var mousePositionY = 0;


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
    }else if(mousePositionX < cobra[0].x){
        proxX--;
    }
    return proxX;
}

function dirY(){
    var proxY = cobra[0].y;
    if(mousePositionY > cobra[0].y){
        proxY++;
    }else if(mousePositionY < cobra[0].y){
        proxY--;
    }
    return proxY;
}
function update(index){
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
        console.log(cobra[i].x + " === " + cobra[i].y);
    }
}
