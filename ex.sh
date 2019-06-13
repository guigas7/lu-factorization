#!/bin/bash
cd ~/lu-factorization;
smp=($(ls matriz*.txt));

gcc seq.c -o Sequencial -msse3 -O3 > /dev/null 2>&1;
gcc seqSemSymd.c -o SeqSemSymd -fopenmp -msse3 -O3 > /dev/null 2>&1;
gcc paraleloC2.c -o Par-2 -fopenmp -msse3 -O3 > /dev/null 2>&1;
gcc paraleloC4.c -o Par-4 -fopenmp -msse3 -O3 > /dev/null 2>&1;
gcc paraleloC8.c -o Par-8 -fopenmp -msse3 -O3 > /dev/null 2>&1;
gcc paraleloC16.c -o Par-16 -fopenmp -msse3 -O3 > /dev/null 2>&1;
gcc par2-auto.c -o Par-2-auto -fopenmp -msse3 -O3 > /dev/null 2>&1;
gcc par4-auto.c -o Par-4-auto -fopenmp -msse3 -O3 > /dev/null 2>&1;
gcc par8-auto.c -o Par-8-auto -fopenmp -msse3 -O3 > /dev/null 2>&1;
gcc par16-auto.c -o Par-16-auto -fopenmp -msse3 -O3 > /dev/null 2>&1;

printf "%-20s" "version / size";
for key in "${smp[@]}"; do
    printf " - %dx%-7d" "$(head -n 1 $key)" "$(head -n 1 $key)";
done
echo;

execs=(Sequencial SeqSemSymd Par-2 Par-4 Par-8 Par-16 Par-2-auto Par-4-auto Par-8-auto Par-16-auto);
for key in "${execs[@]}"; do
    printf "%-20s" "$key";
    for sample in "${smp[@]}"; do
        sum=0;
        for ((i = 0; i < 20; i++)); do
            exec_time="$(/usr/bin/time -f %e ./$key result.txt < $sample 2>&1 1>/dev/null )"
            sum=$(bc -l <<<"$sum+$exec_time");
        done
        avg=$(bc -l <<<"$sum/$i");
        LC_NUMERIC=C printf " - %-12.5lf" "$avg";
    done
    printf "\n";
done

