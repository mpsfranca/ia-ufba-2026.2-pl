# Construção de itens de League of Legends em Prolog

Projeto desenvolvido para a tarefa avaliativa N1 de **MATA64 — Inteligência Artificial**, da Universidade Federal da Bahia.

A base de conhecimento representa relações de construção entre um conjunto selecionado de itens de *League of Legends*. Ela registra quais componentes entram diretamente em cada receita e utiliza regras Prolog para inferir componentes indiretos, consultar os itens finais que utilizam determinado componente e comparar árvores de construção.

## Escopo

Os itens são classificados como **básicos**, **intermediários** ou
**finais**. Neste projeto, a relação
`direct_component(Component, Item)` significa que `Component`
participa **diretamente** da receita de `Item`.

A relação `direct_component/2` registra apenas a presença de um
componente na receita. Portanto, componentes repetidos são representados
por uma única relação; quantidades não fazem parte do modelo. O custo
dos itens também não é registrado.

As consultas dizem respeito apenas aos itens e às receitas cadastrados
nesta base; ela não representa toda a loja do jogo.

## Organização do repositório

```text
.
├── lol_items_knowledge_base.pl
├── README.md
├── relatorio.pdf                
├── consultas/                   # Pasta com os prints das consultas
└── receitas/                    # Pasta com as receitas dos itens intermediários e finais
```

## Como executar

Instale o [SWI-Prolog](https://www.swi-prolog.org/) e, no terminal, abra a pasta do projeto. Inicie o interpretador:

```sh
swipl
```

No prompt do Prolog, carregue a base:

```prolog
?- ['lol_items_knowledge_base.pl'].
```

Em seguida, execute uma consulta. Por exemplo:

```prolog
?- direct_component(X, ludens_echo).
```

Quando aparecer uma resposta, digite `;` para solicitar a próxima. Use `Enter` se não quiser continuar procurando alternativas.

## Consultas

| Nº | Consulta | Objetivo |
| ---: | --- | --- |
| 1 | `direct_component(X, ludens_echo).` | Encontrar os componentes diretos de um item. |
| 2 | `direct_component(X, Y).` | Encontrar pares de componente e item usando duas variáveis. |
| 3 | `component_of(X, ludens_echo).` | Encontrar componentes diretos e indiretos por recursão. |
| 4 | `final_item_uses(Item, amplifying_tome).` | Descobrir de quais itens finais um componente participa. |
| 5 | `crafted_intermediate(lost_chapter).` | Verificar se um item intermediário tem receita cadastrada. |
| 6 | `shared_component(ludens_echo, shadowflame, X).` | Encontrar componentes compartilhados por duas árvores. |
| 7 | `direct_final_component(Component, Item).` | Quais componentes entram diretamente na receita de cada item final. |
| 8 | `basic_ingredient_of(Basic, Final).` | De quais itens finais participa um item básico, direta ou indiretamente. |
| 9 | `intermediate_ingredient_of(Intermediate, Final).` | De quais itens finais participa um item intermediário. |
| 10 | `shared_component(ludens_echo, rabadons_deathcap, X).` | Se Luden e Rabadon compartilham algum componente na base cadastrada. |
| 11 | `exclusive_component(ludens_echo, rabadons_deathcap, X).` | Quais componentes aparecem na árvore de Luden, mas não na de Rabadon. |
| 12 | `direct_in_one_indirect_in_other(X, ludens_echo, shadowflame).` | Se algum componente direto de Luden aparece apenas indiretamente em Shadowflame. |
| 13 | `reusable_component(Component).` | Quais componentes participam de pelo menos dois itens finais distintos. |
| 14 | `indirect_basic_ingredient(Basic, ludens_echo).` | Quais itens básicos participam indiretamente da construção de Luden. |

## Base de conhecimento

A implementação completa está em
[`lol_items_knowledge_base.pl`](lol_items_knowledge_base.pl).

A relação `direct_component(Component, Item)` representa uma etapa
direta da receita. A regra recursiva `component_of/2` percorre essas
etapas para encontrar componentes indiretos. Por exemplo:

```prolog
direct_component(amplifying_tome, lost_chapter).
direct_component(lost_chapter, ludens_echo).
```

Esses fatos permitem inferir que `amplifying_tome` participa da
construção de `ludens_echo`, mesmo sem existir uma relação direta entre
os dois.

## Material complementar

- **Relatório:** [`relatorio.pdf`](assets/relatorio.pdf)
- **Capturas da execução:** [`consultas`](assets/consultas/)
- **Árvores de construção:** [`receitas`](assets/receitas/)