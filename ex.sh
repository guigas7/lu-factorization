#!/bin/bash
cd ~/lu-factorization;
smp=($(ls matriz*.txt));
printf "%-20s" "version / size";
for key in "${smp[@]}"; do
    printf " - %dx%-7d" "$(head -n 1 $key)" "$(head -n 1 $key)";
done
echo;

execs=(Sequencial Par-Auto Paralelo-Dyn Paralelo-Symd-Auto Paralelo-Symd-Dyn)
for key in "${execs[@]}"; do
    printf "%-20s" "$key";
    for sample in "${smp[@]}"; do
        sum=0;
        for ((i = 0; i < 20; i++)); do
            exec_time=$(/usr/bin/time -f %e ./$exec result.txt < $smp);
            sum=$(bc -l <<<"$sum+$exec_time");
        done
        avg=$(bc -l <<<"$sum/$i");
        printf " - %-12d" "$avg";
    done
    printf "\n";
done

