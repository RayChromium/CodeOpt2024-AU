#include <stdio.h>

void minmax(int a[], int b[], int n) {
    for (int i = 0; i < n; i++) {
        if (a[i] > b[i]) {
            int tmp = a[i];
            a[i] = b[i];
            b[i] = tmp;
        }
    }
}


void minmax_non_branching(int a[], int b[], int n) {
    for (int i = 0; i < n; i++) {
        int diff = a[i] - b[i];
        
        // Create a mask based on the sign of the difference
        int mask = diff >> (sizeof(int) * 8 - 1);
        
        // If a[i] > b[i], diff will be positive, mask will be 0
        // If a[i] <= b[i], diff will be negative, mask will be -1

        // Apply the mask to swap the values if needed without branching
        int min = b[i] + (diff & mask);
        int max = a[i] - (diff & mask);
        
        a[i] = min;
        b[i] = max;
    }
}

int main() {
    int a[] = {5, 2, 9, 3};
    int b[] = {3, 4, 1, 8};
    int n = sizeof(a) / sizeof(a[0]);

    minmax(a, b, n);

    int a2[] = {5, 2, 9, 3};
    int b2[] = {3, 4, 1, 8};

    minmax_non_branching(a2, b2, n);

    for (int i = 0; i < n; i++) {
        printf("minmax: a[%d] = %d, b[%d] = %d\n", i, a[i], i, b[i]);
        printf("non-branching: a2[%d] = %d, b2[%d] = %d\n", i, a2[i], i, b2[i]);
    }

    return 0;
}