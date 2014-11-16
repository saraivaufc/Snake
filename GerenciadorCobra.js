.pragma library

//DEFINES DAS DIRECOES

var LEFT = "<";
var RIGHT = ">";
var UP = "A";
var DONW = "V";


var cobra = [];
var mousePositionX = 100;
var mousePositionY = 100;
var direcao = RIGHT;


//DEFINE DOS MOVIMENTOS
var distanciaDefault = 20;
var distanciaX = 0;
var distanciaY = 0;


function startGame(Campo){
    adiciona(Campo, 0, 0);
    adiciona(Campo, 0, 0);
}


function adiciona(Campo,xPosition , yPosition){
    var component = Qt.createComponent("Node.qml");
    var node = component.createObject(Campo, {"x":xPosition,
                                              "y":yPosition,
                                              "color":Qt.rgba(Math.random(), Math.random(), Math.random(), 4)});
    node.x = xPosition;
    node.y = yPosition;
    cobra.push(node);
}

function update(Campo){
    var xPos = cobra[0].x;
    var yPos = cobra[0].y;
    move();
    for(var  k =0 ; k< cobra.length-1; k++){
        rotate(cobra[k], cobra[k+1]);
    }
    rotate(cobra[cobra.length-1], cobra[cobra.length-2]);
    moveNodes(1,xPos, yPos);
}

function moveNodes(index , x, y){

    for(var i = cobra.length-1 ; i >= 1 ; i--){
        cobra[i].x = cobra[i-1].x;
        cobra[i].y = cobra[i-1].y;
    }
}


function rotate(A, B){
    var catOp = B.y - A.y;
    var catAd = B.x - A.x;
    var hip = Math.sqrt(Math.pow(catOp,2) + Math.pow(catAd,2));

    var sin = catOp/hip;
    var cos = catAd/hip;

    var theta;
    if(cos < 0){
        theta = Math.PI -Math.asin(sin);
    }else{
        theta = Math.asin(sin);
    }

    A.rotation= (theta * 180)/Math.PI;
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

function setPosicao(x, y){
    mousePositionX = x;
    mousePositionY = y;
    calcSpeed(cobra[0]);
}
