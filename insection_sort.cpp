#include <iostream>
#include <vector>

int main() {
    int n;
    if (!(std::cin >> n)) return 0;
    std::vector<int> vec(n);
    for (int i = 0; i < n; i++) std::cin >> vec[i];

    for (int i = 1; i < n; i++) {
        int chave = vec[i];
        int j = i - 1;
        while (j >= 0 && vec[j] > chave) {
            vec[j + 1] = vec[j];
            j--;
        }
        vec[j + 1] = chave;
    }
    return 0;
}
