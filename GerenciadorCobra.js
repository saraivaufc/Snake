.pragma library

var cobra = [];
var mousePositionX = 200;
var mousePositionY = 200;

//DEFINE DOS MOVIMENTOS
var distanciaDefault = 10;
var distanciaX = 0;
var distanciaY = 0;


//COLORS
var R = 99;
var G = 0;
var B = 0;

var E1 = false;
var E2 = false;
var E3 = false;

function startGame(Campo){
    for(var i=100 ; i>=0;i--){
        adiciona(Campo, 0, 0);
    }
    calcSpeed(cobra[0]);
}


function adiciona(Campo,xPosition , yPosition){
    if(R >= 97 || E1 == true){
        R +=97;
        G +=3;
        E1 = true;
        E3 = false;
    }
    if(G >= 97 || E2 == true){
        G += 97;
        B +=3;
        E2 = true;
        E1 = false;
    }
    if(B >= 97 || E3 == true){
        B += 97;
        R +=3;
        E3 = true;
        E2 = false;
    }
    R %= 100;
    G %= 100;
    B %= 100;

    var component = Qt.createComponent("Node.qml");
    var node = component.createObject(Campo, {"x":xPosition,
                                              "y":yPosition,
                                              "color":Qt.rgba(R/100, G/100,B/100 , 4)});


    node.x = xPosition;
    node.y = yPosition;
    cobra.push(node);
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
}

function moveNodes(){

    for(var i = 1; i < cobra.length ; i++){
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
