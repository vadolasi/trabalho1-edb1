# Análise de Complexidade de Algoritmos - Trabalho Unidade I

Este repositório contém os códigos desenvolvidos para o Trabalho I da disciplina de Estruturas de Dados Básicos I (EDB1).

## Estrutura de Arquivos

### Algoritmos (C++)
- `binary_search.cpp`: Implementação do algoritmo de Busca Binária
- `sequential_search.cpp`: Implementação do algoritmo de Busca Sequencial.
- `insection_sort.cpp`: Implementação do algoritmo Insertion Sort.
- `merge_sort.cpp`: Implementação do algoritmo Merge Sort.

### Script de Análise (Python)
- `main.py`: Interface web (Streamlit) para gerar relatórios com base em arquivos `.cpp`.

### Relatório (Typst)
- `main.typ`: Código-fonte do relatório.
- `main.pdf`: Versão compilada do relatório final.
- `screenshot_interface.png`: Captura de tela da interface do sistema.
- `grafico_busca.png`: Gráfico comparativo dos algoritmos de busca.
- `grafico_ordenacao.png`: Gráfico comparativo dos algoritmos de ordenação.

### Outros
- `pyproject.toml` / `uv.lock`: Configurações de ambiente Python e dependências.

## Como Executar a Interface
Para rodar a interface web, certifique-se de ter o Python instalado e execute:
```bash
streamlit run main.py
```
O sistema abrirá no seu navegador, permitindo o upload dos arquivos fonte C++ e a visualização dos gráficos de desempenho.
