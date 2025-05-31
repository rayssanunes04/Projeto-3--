#!/bin/bash

usage() {
    echo "Uso: $0 -l [c|python] -a [bubble] -n [n_execucoes] -t [tamanho_entrada]"
    exit 1
}

while getopts ":l:a:n:t:" opt; do
  case $opt in
    l) linguagem="$OPTARG"
    ;;
    a) algoritmo="$OPTARG"
    ;;
    n) execucoes="$OPTARG"
    ;;
    t) tamanho="$OPTARG"
    ;;
    \?) echo "Opção inválida: -$OPTARG" >&2; usage
    ;;
    :) echo "Opção -$OPTARG requer um argumento." >&2; usage
    ;;
  esac
done


if [[ -z "$linguagem" || -z "$algoritmo" || -z "$execucoes" || -z "$tamanho" ]]; then
    usage
fi

saida_csv="${algoritmo}_${linguagem}.csv"
> "$saida_csv" 

soma=0
for ((i=1; i<=$execucoes; i++)); do
    if [ "$linguagem" = "python" ]; then
        saida=$(python3 ${algoritmo}.py $tamanho)
    elif [ "$linguagem" = "c" ]; then
        ./a.out $tamanho > .temp_saida
        saida=$(cat .temp_saida)
    else
        echo "Linguagem inválida: $linguagem"
        exit 1
    fi

    tempo=$(echo "$saida" | cut -d';' -f2 | tr -d ';')
    echo "$tamanho;$tempo;" >> "$saida_csv"
    soma=$(echo "$soma + $tempo" | bc -l)
done

media=$(echo "$soma / $execucoes" | bc -l)
echo "Tamanho: $tamanho | Execuções: $execucoes | Tempo médio: $media s"
