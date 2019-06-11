#include <stdio.h>
#include <stdlib.h>

void printA(double **, int, FILE *);
void getA(double **, int);

int main (int argc, char *argv[]) {
    int n;
    FILE *fp;
    fp = fopen(argv[1], "w");
    scanf("%d", &n);
    double **a = malloc(n * sizeof(double *));
    for (int i = 0; i < n; i++) {
        a[i] = malloc(n * sizeof(double));
    }
    getA(a, n);
    for (int k = 0; k < n; k++) {
        /* DivisioN step */
        for (int i = k + 1; i < n; i++) {
            a[i][k] = a[i][k] / a[k][k];
        }
        /* ElimiNatioN step */
        for (int i = k + 1; i < n; i++) {
            for (int j = k + 1; j < n; j++) {
                a[i][j] = a[i][j] - (a[i][k] * a[k][j]);
            }
        }
    }
    printA(a, n, fp);
    fclose(fp);
    for (int i = 0; i < n; i++) {
        free(a[i]);
    }
    free(a);
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

void printA(double **a, int n, FILE *fp) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            fprintf(fp, "%.3lf ", a[i][j]);
        }
        fprintf(fp, "\n");
    }
}
