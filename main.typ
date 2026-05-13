#set document(title: "Análise de Complexidade de Algoritmos", author: "Vitor Daniel")
#set text(font: "Liberation Sans", lang: "pt")
#set heading(numbering: "1.")

#align(center)[
  #text(18pt, weight: "bold")[Análise Empírica de Algoritmos] \
  #v(0.5em)
  Vitor Daniel Lopes dos Santos
]

#v(1em)

= O que foi feito
Neste trabalho, foi testado o tempo que alguns algoritmos levam para rodar. O objetivo foi verificar se a teoria sobre o "custo" deles (complexidade) condiz com o que acontece na prática quando são processados volumes diferentes de dados.

= Algoritmos Escolhidos
Foram escolhidos quatro algoritmos conhecidos para o estudo:
- *Busca Sequencial:* Procura um por um na lista. Espera-se que o tempo suba de forma linear ($O(n)$).
- *Busca Binária:* Procura dividindo a lista ordenada ao meio. É extremamente rápida ($O(log n)$).
- *Insertion Sort:* Ordena inserindo cada item na posição correta. Tende a apresentar lentidão para listas grandes ($O(n^2)$).
- *Merge Sort:* Ordena dividindo a lista em partes menores e juntando-as posteriormente. É muito eficiente ($O(n log n)$).

= Interface do Sistema
Para facilitar a execução dos testes, foi desenvolvida uma interface web utilizando o framework Streamlit. A ferramenta permite que o usuário selecione o tipo de algoritmo (Busca ou Ordenação) e faça o upload de múltiplos arquivos `.cpp` simultaneamente.

#figure(
  image("screenshot_interface.png", width: 90%),
  caption: [Interface do sistema de análise empírica],
)

O sistema automatiza o processo de:
1. Receber os arquivos fonte.
2. Compilar o código C++ com otimização `-O3`.
3. Executar os benchmarks para diferentes tamanhos de entrada ($n$).
4. Gerar gráficos comparativos em tempo real.

= Metodologia de Teste
Foi utilizado C++ para implementar os algoritmos e Python para gerenciar as medições. Para garantir que os resultados fossem representativos, foram adotados os seguintes passos:
1. Cada teste foi executado 3 vezes para a extração de uma média.
2. Utilizou-se o tempo de CPU do processo para a medição.
3. Foram realizados testes com listas de 1.000 até 100.000 números gerados aleatoriamente.

= Resultados

== Algoritmos de Busca
Abaixo, a comparação entre os dois métodos de busca:

#figure(
  image("grafico_busca.png", width: 80%),
  caption: [Comparação entre Busca Sequencial e Busca Binária],
)

Nesta visualização, nota-se que os tempos de execução ficaram muito próximos, apresentando um comportamento similar. Isso ocorre por possíveis motivos que serão abordados nas próximas seções deste relatório.

== Algoritmos de Ordenação
Abaixo, a comparação entre os métodos de ordenação:

#figure(
  image("grafico_ordenaçao.png", width: 80%),
  caption: [Comparação entre Insertion Sort e Merge Sort],
)

O Insertion Sort apresenta uma curva acentuada, típica de algoritmos quadráticos, enquanto o Merge Sort mantém um crescimento muito mais controlado.

= Problemáticas e Limitações
Como mencionado anteriormente, a análise empírica possui desafios que podem impactar a visualização dos dados, especialmente no caso dos algoritmos de busca:

1. *Custo de Carregamento:* É possível que o tempo gasto para ler os dados da entrada influencie significativamente o tempo total capturado. Como a leitura é uma operação linear ($O(n)$), ela pode acabar dominando a medição, fazendo com que a eficiência da busca binária não seja tão evidente no gráfico.
2. *Escala de Medição:* Como a execução da busca é extremamente rápida em processadores modernos, é possível que pequenas interferências do sistema ou o próprio "overhead" de iniciar o programa tornem os tempos muito próximos em escalas menores.
3. *Interferências Externas:* Outros programas rodando no computador podem causar variações nos tempos. Embora o uso de médias ajude, variações mínimas ainda podem ocorrer e influenciar a precisão dos dados.

= Conclusão
Os resultados auxiliam na compreensão de como a teoria se aplica na prática. Fica claro que para grandes volumes de dados, algoritmos com melhor complexidade (como o Merge Sort) são fundamentais para manter a eficiência do sistema.

#v(1em)
*Código-fonte:* Todo o código desenvolvido para este trabalho está disponível publicamente em: #link("https://github.com/vadolasi/trabalho1-edb1")
