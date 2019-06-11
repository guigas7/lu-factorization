#include <stdio.h>
#include <stdlib.h>

void printA(double **, int);
void getA(double **, int);
void division(double **, int, int);
void elimination(double **, int, int);

int main () {
    int n;
    scanf("%d", &n);
    double **a = malloc(n * sizeof(double *));
    for (int i = 0; i < n; i++) {
        a[i] = malloc(n * sizeof(double));
    }
    getA(a, n);
    for (int k = 0; k < n; k++) {
        division(a, k, n);
        elimination(a, k, n);
    }
    printA(a, n);
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

void division(double **a, int k, int n) {
    for (int i = k + 1; i < n; i++) {
        a[i][k] = a[i][k] / a[k][k];
    }
}

void elimination(double **a, int k, int n) {
    for (int i = k + 1; i < n; i++) {
        for (int j = k + 1; j < n; j++) {
            a[i][j] = a[i][j] - (a[i][k] * a[k][j]);
        }
    }
}

