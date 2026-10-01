% Base de conhecimento: construção de itens de League of Legends
%
% direct_component(Componente, Item) registra uma relação direta
% de composição. A base representa a presença dos componentes,
% mas não suas quantidades nem os custos em ouro.
% As inferências se limitam aos itens cadastrados abaixo.


% Itens básicos.
basic_item(amplifying_tome).
basic_item(sapphire_crystal).
basic_item(glowing_mote).
basic_item(needlessly_large_rod).


% Itens intermediários: possuem componentes cadastrados.
intermediate_item(lost_chapter).
intermediate_item(hextech_alternator).
intermediate_item(fated_ashes).


% Itens tratados como finais.
final_item(ludens_echo).
final_item(rabadons_deathcap).
final_item(shadowflame).
final_item(blackfire_torch).


% Composição direta: o primeiro argumento faz parte da receita do segundo.
direct_component(amplifying_tome, lost_chapter).
direct_component(sapphire_crystal, lost_chapter).
direct_component(glowing_mote, lost_chapter).
direct_component(amplifying_tome, hextech_alternator).
direct_component(amplifying_tome, fated_ashes).
direct_component(lost_chapter, ludens_echo).
direct_component(hextech_alternator, ludens_echo).
direct_component(needlessly_large_rod, rabadons_deathcap).
direct_component(hextech_alternator, shadowflame).
direct_component(needlessly_large_rod, shadowflame).
direct_component(lost_chapter, blackfire_torch).
direct_component(fated_ashes, blackfire_torch).


% R1. Caso-base: um componente direto também pertence à árvore de construção do item.
component_of(Component, Item) :-
    direct_component(Component, Item).


% R2. Caso recursivo: o componente participa da construção de um item intermediário que, por sua vez, participa da construção de Item.
component_of(Component, Item) :-
    direct_component(Component, Intermediate),
    component_of(Intermediate, Item).


% R3. Seleciona componentes diretos de itens finais.
direct_final_component(Component, Item) :-
    final_item(Item),
    direct_component(Component, Item).


% R4. Relaciona um item final a seus componentes diretos ou indiretos.
final_item_uses(Item, Component) :-
    final_item(Item),
    component_of(Component, Item).


% R5. Identifica itens básicos presentes na árvore de construção de um item final.
basic_ingredient_of(Basic, Final) :-
    basic_item(Basic),
    final_item_uses(Final, Basic).


% R6. Identifica itens intermediários presentes na árvore de construção de um item final.
intermediate_ingredient_of(Intermediate, Final) :-
    intermediate_item(Intermediate),
    final_item_uses(Final, Intermediate).


% R7. Encontra um componente compartilhado por dois itens finais distintos, em qualquer nível das árvores.
shared_component(Item1, Item2, Component) :-
    final_item(Item1),
    final_item(Item2),
    Item1 \= Item2,
    component_of(Component, Item1),
    component_of(Component, Item2).


% R8. Encontra um componente presente na árvore de Item1, mas não na de Item2.
exclusive_component(Item1, Item2, Component) :-
    final_item(Item1),
    final_item(Item2),
    Item1 \= Item2,
    component_of(Component, Item1),
    \+ component_of(Component, Item2).


% R9. Encontra um componente direto de Item1 que também participa da construção de Item2, mas não diretamente.
direct_in_one_indirect_in_other(Component, Item1, Item2) :-
    final_item(Item1),
    final_item(Item2),
    Item1 \= Item2,
    direct_component(Component, Item1),
    component_of(Component, Item2),
    \+ direct_component(Component, Item2).


% R10. Identifica um componente que participa da construção de pelo menos dois itens finais distintos.
reusable_component(Component) :-
    final_item_uses(Item1, Component),
    final_item_uses(Item2, Component),
    Item1 \= Item2.


% R11. Confirma que um item cadastrado como intermediário possui pelo menos um componente direto na base.
crafted_intermediate(Item) :-
    intermediate_item(Item),
    direct_component(_, Item).


% R12. Identifica um item básico que participa da árvore de um item final, mas não diretamente de sua receita.
indirect_basic_ingredient(Basic, Final) :-
    basic_item(Basic),
    final_item(Final),
    component_of(Basic, Final),
    \+ direct_component(Basic, Final).