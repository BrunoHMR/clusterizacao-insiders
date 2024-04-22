# Sistema de Fidelização de Clientes

## 1. Contexto

Uma determinada empresa comercializa produtos de segunda linha de diversas marcas a um preço menor, através de um e-commerce. Em pouco mais de um ano de venda, a equipe de marketing percebeu que uma parcela de clientes compram produtos mais caros e com maior frequência, o aque acaba contribuindo com uma parcela significativa no faturamento da empresa. Baseado nessa percepção, a empresa pretende criar um programa de fidelização de clientes, chamado *Insiders*. Então, o **objetivo deste projeto é determinar, através do comportamento de compra dos clientes, quais são elegíveis ao programa**, respondendo às seguintes perguntas:

1. Quais são as pessoas elegíveis para participar do programa de fidelização?
2. Quais as principais características destes clientes?
3. Qual a porcentagem de contribuição do faturamento total vem dos Insiders?
4. Quais as condições para uma pessoa ser elegível ou removível do Insiders?
5. Qual a garantia de que o programa Insiders é melhor do que o restante da base?
6. Quais ações o time de marketing pode executar para aumentar o faturamento?

## 2. Planejamento da Solução:

1. Entrega:
    - Arquivo .csv contendo os clientes elegíveis ao Insiders;
    - Notebook contendo análises e modelos;
    - Descritivo (README.md) contendo as respostas às perguntas de negócio.

2. Solução:
    - Agrupar os clientes de acordo com o comportamento de compra de cada um utilizando modelagem de Machine Learning, devido ao alto volume de compras, de clientes e de características de entrada.

3. Processo:
    1. Entendimento de negócio: contexto, problema e objetivo do projeto;
    2. Análise descritiva dos dados;
    3. Filtragem e derivação de novos atributos;
    4. Análise exploratória dos dados utilizando o Pandas Profiling;
    5. Preparação dos dados para modelagem;
    6. Modelos de clusterização e testes de performance;
    7. Análise do perfil dos clusters;
    8. Caracterização do grupo *Insiders* e comparação com o restante da base.

4. Premissa:
    - O principal critério considerado na hora de classificar os clientes como fiéis ou não será o valor que o cliente gasta com a empresa. Entretanto, para a realização do agrupamento todas as características foram levadas em consideração.

## 3. Arquitetura do Projeto

O projeto será executado com auxílio da AWS Cloud. Todos os dados necessários para o desenvolvimento do projeto, tais como planilhas, csvs, features e modelos serão alocados no serviço da armazenamento de baixo custo da AWS, o S3. Estes dados serão lidos por um notebook python executado no computador local. Os resultados, ou seja, a tabela com os clientes finais, suas características e seus respectivos clusters, serão alocados em um Banco de Dados PostgreSQL, criado utilizando o serviço RDS da AWS, para que possam ser feitas rápidas análises posteriores dos clusters em SQL ou utilizando alguma ferramenta de DataViz. A arquitetura do projeto pode ser vista na Figura abaixo:

![alt text](<Sem título-2024-04-22-0124.png>)

## 4. Descrição dos Dados

Dados de entrada:
- InvoiceNo: id da transação;
- StockCode: código do item;
- Description: descrição do item;
- Quantity: quantidade do item por transação;
- InvoiceDate: data da transação;
- UnitPrice: preço unitário do item;
- CustomerID: id do cliente;
- Country: país do cliente.

## 5. Resultados de Negócio

Respondendo às perguntas de negócio:

1. Quais são as pessoas elegíveis para participar do programa de fidelização?
    - Clientes contidos no arquivo 'insiders.csv', localizado dentro da pasta 'reports'.

2. Quais as principais características destes clientes?
    - Número de clientes: 672 (11,80% da base);
    - Faturamento médio: US\$ 8680,03;
    - Recência média: 63 dias desde a última compra;
    - Frequência média: aproximadamente 1 compra a cada 3 dias;
    - Quantidade média de pedidos: 11 pedidos por cliente;
    - Quantidade média de devoluções: 104 devoluções por cliente;
    - Tamanho médio da cesta: 727 produtos por pedido;
    - Ticket médio: US\$ 67,54.

3. Qual a porcentagem de contribuição do faturamento total vem dos Insiders?
    - 52,53%.

4. Quais as condições para uma pessoa ser elegível ou removível do Insiders?

    As condições foram estabelecidas através de um teste estatístico de t-Student, o qual foi capaz de gerar intervalos de confiança para a variável correspondente ao faturamento médio com um nível de confiança de 95%. O valor correspondente ao limite inferior do faturamento foi de US\$ 7.168,64. Ou seja, caso o cliente tenha uma contribuição abaixo deste valor ele pode ser removido do *Insiders*. Caso contrário, pode ser mantido. 
    
    Nesta análise foi tomada como base apenas a variável correspondente ao faturmaneto total, por entender que o quanto o cliente gasta com a empresa é a principal métrica capaz de dizer se aquele cliente pode ser considerado fiel ou não. Porém, para uma análise mais completa, fica como sugestão para que em um pŕoximo ciclo de projeto sejam tomadas como base mais variáveis.

5. Qual a garantia de que o programa Insiders é melhor do que o restante da base?

    Para responder esta questão foi realizada uma comparação entre o grupo *Insiders* e o restante da base em relação a cada uma das variáveis, onde foram obtidos os seguintes resultados (à direita o *Insiders*, a esquerda a base):

        Faturamento médio: US$ 8680.03 vs US$ 1502.23;
        Frequência: 0.37 compras/dia vs 0.58 compras/dia;
        Recência: 63 dias vs 121 dias;
        Quantidade de pedidos: 11 vs 3;
        Quantidade de devoluções: 104 vs 33;
        Ticket médio: US$ 67,54 vs US$ 25,53;
        Tamanho da cesta: 727 vs 205.
    
    Como é possível observar, o Grupo *Insiders* obteve uma performance muito superior em diversas características analisadas, tais como:
        
        Faturamento médio mais de 5 vezes maior;
        Recência média aproximadamente 2 vezes menor;
        Quase 3 vezes mais pedidos por cliente;
        Ticket médio cerca de 2,5 vezes maior;
        Tamanho da cesta de produtos 3 vezes maior.
        
    Considerando que o faturamento médio foi o principal critério observado, conclui-se que o programa *Insiders* é melhor que o restante da base.
        
6. Quais ações o time de marketing pode executar para aumentar o faturamento?

    Em relação ao Grupo *Insiders*, a partir das análises, foram detectados gargalos relacionados à quantidade de devoluções (cerca de 3 vezes maior que no restante da base) e à frequência (cerca de 1 compra a cada 3 dias, enquanto a base compra mais de 1 vez a cada 2 dias).

    Para aumentar a frequência de compra, pode traçar uma estratégia de cross-sell, oferecendo produtos complementares ou relacionados aos produtos mais adquiridos pelos clientes. Para reduzir o número de devoluções, monitorar como está a qualidade e a entrega dos produtos através das avaliações (feedbacks) dos clientes e comunicar-se claramente em relação ao que está sendo vendido.

    O cross-sell é válido também para aumentar o ticket médio e o tamanho da cesta, assim como é válido também a implementação de um sistema de recomendação eficiente de produtos. Oferecer descontos e promoções especiais também são formas que podem aumentar a frequência e a recência média de compra.
