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

function verificaColisao(A, B){
    if(A.x > (B.x + B.width)){
        return false;
    }
    if((A.x + A.width) < B.x){
        return false;
    }
    if(A.y >(B.y + B.height)){
        return false;
    }
    if((A.y + A.height) < B.y){
        return false;
    }
    return true;
}
