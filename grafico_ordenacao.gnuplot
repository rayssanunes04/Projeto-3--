set datafile separator ";"
set title "Comparação de Algoritmos de Ordenação (C vs Python)"
set xlabel "Número de Entradas"
set ylabel "Tempo de Execução (s)"
set logscale x 10
set logscale y 10
set grid
set key outside
set term pngcairo size 1000,700
set output "comparacao_ordenacao.png"

plot "tempos_ordenacao.csv" using 1:2 with linespoints title "C - BubbleSort", \
     "tempos_ordenacao.csv" using 1:3 with linespoints title "Python - BubbleSort", \
     "tempos_ordenacao.csv" using 1:4 with linespoints title "C - MergeSort", \
     "tempos_ordenacao.csv" using 1:5 with linespoints title "Python - MergeSort"
