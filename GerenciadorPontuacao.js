var pontos = 0;
var tempo = new Date(0);

function inclementaPontos(){
    pontos++;
}

function inclementaTempo(){
    var x = tempo.getSeconds();
    x++;
    tempo.setSeconds(x);
}

function getPontos(){
    return pontos.toString();
}

function getTempo(){
    var segundos = tempo.getSeconds().toString();
    if(segundos.length < 2){
        segundos = "0"+ segundos;
    }

    var minutos = tempo.getMinutes().toString();
    if(minutos.length < 2){
        minutos = "0"+ minutos;
    }

    var str = minutos + ":" + segundos;
    return str;
}
