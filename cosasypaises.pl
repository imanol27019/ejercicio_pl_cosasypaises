% tarea(Nivel, buscar(Objeto, Cuidad)). 
tarea(basico,buscar(libro,jartum)).
tarea(basico,buscar(arbol,patras)).
tarea(basico,buscar(roca,telaviv)).
tarea(intermedio,buscar(arbol,sofia)).
tarea(intermedio,buscar(arbol,bucarest)).
tarea(avanzado,buscar(perro,bari)).
tarea(avanzado,buscar(flor,belgrado)).

% nivelActual(Persona, Nivel).
nivelActual(pepe,basico).
nivelActual(lucy,intermedio).
nivelActual(juancho,avanzado).

% idioma(Cuidad, Idioma).
idioma(alejandria,arabe).
idioma(jartum,arabe).
idioma(patras,griego).
idioma(telaviv,hebreo).
idioma(sofia,bulgaro).
idioma(bari,italiano).
idioma(bucarest,rumano).
idioma(belgrado,serbio).

% habla(Persona, Lenguaje).
habla(pepe,bulgaro).
habla(pepe,griego).
habla(pepe,italiano).
habla(juancho,arabe).
habla(juancho,griego).
habla(juancho,hebreo).
habla(lucy,griego).

% capital(Persona, Dinero).
capital(pepe,1200).
capital(lucy,3000).
capital(juancho,500).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 1
%%%%%%%%%%%%%%%%%%%%%%%%%%

destinoPosible(Persona, Ciudad) :-
    nivelActual(Persona, Nivel), 
    ciudadEnNivel(Ciudad, Nivel).

idiomaUtil(Nivel, Idioma) :-
    idioma(Ciudad, Idioma),      
    ciudadEnNivel(Ciudad, Nivel).

ciudadEnNivel(Ciudad, Nivel) :-
    tarea(Nivel, buscar(_, Ciudad)).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 2
%%%%%%%%%%%%%%%%%%%%%%%%%%

excelenteCompaniero(Alguien, Otro) :-
    alguien(Alguien),
    alguien(Otro),
    hablaTodosIdiomasDelOtro(Alguien, Otro).

hablaTodosIdiomasDelOtro(Alguien, Otro) :-
    forall(destinoPosible(Otro, Ciudad), hablaEnEsaCiudad(Alguien, Ciudad)),
    Alguien\=Otro.

hablaEnEsaCiudad(Alguien, Ciudad) :- 
    idioma(Ciudad, Idioma), 
    habla(Alguien, Idioma).

alguien(Alguien) :- nivelActual(Alguien, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 3
%%%%%%%%%%%%%%%%%%%%%%%%%%

interesante(Nivel) :- 
    nivel(Nivel),
    forall(esteObjetoEstaEnElNivel(Objeto, Nivel), estaVivo(Objeto)).

interesante(Nivel) :-
    nivelActual(Persona, Nivel),
    destinoPosible(Persona, Ciudad),
    idioma(Ciudad, italiano).

nivel(Nivel) :- 
    nivelActual(_, Nivel).

esteObjetoEstaEnElNivel(Objeto, Nivel) :- 
    tarea(Nivel, buscar(Objeto,_)).

estaVivo(Objeto).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 4
%%%%%%%%%%%%%%%%%%%%%%%%%%

complicado(Alguien) :-
    not(hablaTodosIdiomasDelOtro(Alguien, Alguien)). % error

complicado(Alguien) :-
    not(estaEnBasico(Alguien)),
    capitalMenorQue(Alguien, 1500).

complicado(Alguien) :-
    estaEnBasico(Alguien),
    capitalMenorQue(Alguien, 500).

estaEnBasico(Alguien):-
    nivelActual(Alguien, Nivel),
    Nivel=basico.

capitalMenorQue(Alguien, Numero):-
    capital(Alguien, Cantidad),
    Cantidad < Numero.