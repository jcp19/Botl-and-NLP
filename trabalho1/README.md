# scripting_natural_language_processing
Scripting for Natural Language Processing

Neste trabalho, criaram-se programas para dado um texto, apresentar as interações entre os nomes próprios presentes no texto.
Em primeiro lugar, fez-se um script que dado um texto, cria um grafo de relacionamentos com o graphviz. A partir daqui é possível encontrar 
as relações principais num texto. No entanto, são encontrados muitos falsos-positivos. 

Para reduzir o número de falsos positivos, apresentaram-se apenas as relações mais fortes, i.e. as que surgem mais frequenteente tendo em conta 
o número de ocurrências dos seus intervenientes.

Embora seja interessante, achamos que é demasiado estático e pouco poderoso. Resolvemos então criar um script que gera automaticamente um
script para criação de uma BD Neo4j. Uma vez executado o script, temos acesso a toda a informação identificada e podemos fazer queries à mesma.
Para além disso, o Neo4j apresenta uma interface bastante agradável para navegar no grafo.

Por fim, o grupo pretendeu parametrizar os scripts desenvolvidos de forma a poder mudar o tamanho da janela e do threshold de força das relações.
Outro objetivo seria de apresentar para cada nome, os nomes e adjetivos que mais surgem no contexto esquerdo de cada nome de forma a conseguir caracterizar os nomes.
No entanto, os membros do grupo não tiveram tempo de fazer tudo o que queriam. 
O script de análise do contexto esquerdo e identificação das palavras mais comuns foi no entanto totalemente desenvolvido, faltando conjugar com o restante trabalho.

No futuro, pretende-se usar o Freeling de forma a eliminar ainda mais Falsos Positivos.

