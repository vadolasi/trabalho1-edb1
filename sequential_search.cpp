#include <iostream>
#include <vector>

int main() {
    int n, alvo;
    if (!(std::cin >> n)) return 0;
    std::vector<int> vec(n);
    for (int i = 0; i < n; i++) std::cin >> vec[i];
    std::cin >> alvo;

    int resultado = -1;
    for (int i = 0; i < n; i++) {
        if (vec[i] == alvo) {
            resultado = i;
            break;
        }
    }
    return 0;
}
