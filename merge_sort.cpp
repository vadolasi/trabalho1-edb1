#include <iostream>
#include <vector>

void merge(std::vector<int>& v, int e, int m, int d) {
    int n1 = m - e + 1, n2 = d - m;
    std::vector<int> L(n1), R(n2);
    for(int i=0; i<n1; i++) L[i] = v[e+i];
    for(int j=0; j<n2; j++) R[j] = v[m+1+j];
    int i=0, j=0, k=e;
    while(i<n1 && j<n2) v[k++] = (L[i] <= R[j]) ? L[i++] : R[j++];
    while(i<n1) v[k++] = L[i++];
    while(j<n2) v[k++] = R[j++];
}

void mergeSort(std::vector<int>& v, int e, int d) {
    if (e < d) {
        int m = e + (d - e) / 2;
        mergeSort(v, e, m);
        mergeSort(v, m + 1, d);
        merge(v, e, m, d);
    }
}

int main() {
    int n;
    if (!(std::cin >> n)) return 0;
    std::vector<int> vec(n);
    for (int i = 0; i < n; i++) std::cin >> vec[i];
    mergeSort(vec, 0, n - 1);
    return 0;
}
