var pontos = 0;
var tempo = new Date(0);

function  inclementaPontos(){
    pontos ++;
}

function inclementaTempo(){
    var x = tempo.getSeconds();
    x++;
    tempo.setSeconds(x);
}

function getPontos(){
    return pontos;
}

function getTempo(){
    var str = tempo.getMinutes().toString() + ":" + tempo.getSeconds().toString();
    return str;
}
