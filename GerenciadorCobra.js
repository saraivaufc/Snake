.pragma library

//DEFINES DAS DIRECOES

var LEFT = "<";
var RIGHT = ">";
var UP = "A";
var DONW = "V";


var cobra = [];
var mousePositionX = 0;
var mousePositionY = 0;
var direcao = RIGHT;


//DEFINE DOS MOVIMENTOS
var distanciaMove = 20;

function startGame(Campo){
    adiciona(Campo, 0, 0);
    adiciona(Campo,0,0);
    adiciona(Campo,0,0);
    adiciona(Campo,0,0);
    adiciona(Campo,0,0);
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
    moveX();
    moveY();
    moveNodes(1,xPos, yPos);
}

function moveNodes(index , x, y){
    if(index >= cobra.length){
        return;
    }
    var m = cobra[index].x;
    var n = cobra[index].y;
    cobra[index].x = x;
    cobra[index].y = y;
    moveNodes(index+1, m, n);
}




function moveX(){
    if(cobra.length <= 0){
        console.log("Cobra vazia!!");
        return;
    }

    if(parseInt(mousePositionX,10) > parseInt(cobra[0].x,10)){
        cobra[0].x+= distanciaMove;
        direcao = RIGHT;
    }else if(parseInt(mousePositionX,10) < parseInt(cobra[0].x,10)){
        cobra[0].x-=distanciaMove;
        direcao = LEFT;
    }else if(parseInt(mousePositionX,10) === parseInt(cobra[0].x,10)){
        if(direcao === RIGHT){
            cobra[0].x+=distanciaMove;
        }else if(direcao === LEFT){
            cobra[0].x-=distanciaMove;
        }
    }
}

function moveY(){
    if(cobra.length <= 0){
        console.log("Cobra vazia!!");
        return;
    }

    if(parseInt(mousePositionY,10) > parseInt(cobra[0].y,10)){
        cobra[0].y+=distanciaMove;
        direcao = DONW;
    }else if(parseInt(mousePositionY,10) < parseInt(cobra[0].y,10)){
        cobra[0].y-=distanciaMove;
        direcao = UP;
    }else  if(parseInt(mousePositionY,10) === parseInt(cobra[0].y,10)){
        if(direcao === DONW){
            cobra[0].y+=distanciaMove;
        }else if(direcao === UP){
            cobra[0].y-=distanciaMove;
        }
    }
}

function setPosicao(x, y){
    mousePositionX = parseInt(x,10);
    mousePositionY = parseInt(y,10);
}
