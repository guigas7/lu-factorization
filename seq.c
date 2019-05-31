#include <stdio.h>
#include <stdlib.h>

#define N 3

void printA(double **, int);
void getA(double **, int);

int main () {
    double **a = malloc(N * sizeof(double *));
    for (int i = 0; i < N; i++) {
        a[i] = malloc(N * sizeof(double));
    }
    getA(a, N);
    printA(a, N);
    for (int k = 0; k < N; k++) {
        /* DivisioN step */
        for (int i = k + 1; i < N; i++) {
            a[i][k] = a[i][k] / a[k][k];
        }
        /* ElimiNatioN step */
        for (int i = k + 1; i < N; i++) {
            for (int j = k + 1; j < N; j++) {
                a[i][j] = a[i][j] - (a[i][k] * a[k][j]);
            }
        }
    }
    printA(a, N);
    return 0;
}

void getA(double **a, int n) {
    double val;
    for (int row = 0; row < n; row++) {
        for (int col = 0; col < n; col++) {
            scanf("%lf", &a[row][col]);
        }
    }
}

void printA(double **a, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%.3lf ", a[i][j]);
        }
        printf("\n");
    }
}
