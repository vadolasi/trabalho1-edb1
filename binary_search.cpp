#include <iostream>
#include <vector>

int main() {
    int n, alvo;
    if (!(std::cin >> n)) return 0;
    std::vector<int> vec(n);
    for (int i = 0; i < n; i++) std::cin >> vec[i];
    std::cin >> alvo;

    int esq = 0, dir = n - 1;
    int resultado = -1;
    while (esq <= dir) {
        int meio = esq + (dir - esq) / 2;
        if (vec[meio] == alvo) {
            resultado = meio;
            break;
        }
        if (vec[meio] < alvo) esq = meio + 1;
        else dir = meio - 1;
    }
    return 0;
}
