% 1)
% Creer
cree(gabriel,campanita).
cree(gabriel,elMagoDeOz).
cree(gabriel,cavenaghi).
cree(juan,conejoDePascua).
cree(macarena,reyesMagos).
cree(macarena,elMagoCapria).
cree(macarena,campanita).

% Tipos de sueños
quiere(gabriel,ganarLoteria([5,9])).
quiere(gabriel,serFutbolista(arsenal)).
quiere(juan,serCantante(100000)).
quiere(macarena,serCantante(10000)).
quiere(santi,serCantante(600000)). % -> Prueba

persona(Persona):- quiere(Persona,_). % -> Persona que tiene suenio

% 2)
ambiciosa(Persona):-
    dificultadTotalSuenios(Persona,Cantidad),
    Cantidad > 20.

dificultadTotalSuenios(Persona,Cantidad):-
    persona(Persona),
    findall(Dificultad,dificultadPorSuenio(Persona,Dificultad),Dificultades),
    sumlist(Dificultades,Cantidad).

dificultadPorSuenio(Persona,6):-
    quiere(Persona,serCantante(Cantidad)),
    Cantidad > 500000.

dificultadPorSuenio(Persona,4):-
    quiere(Persona,serCantante(Cantidad)),
    Cantidad =< 500000. 

dificultadPorSuenio(Persona,Dificultad):-
    quiere(Persona,ganarLoteria(Numeros)),
    length(Numeros, Cantidad),
    Dificultad is Cantidad * 10.

dificultadPorSuenio(Persona,3):-
    quiere(Persona,serFutbolista(Equipo)),
    esEquipoChico(Equipo).

dificultadPorSuenio(Persona,16):-
    quiere(Persona,serFutbolista(Equipo)),
    not(esEquipoChico(Equipo)).

esEquipoChico(arsenal).
esEquipoChico(aldosivi).

% 3)
tieneQuimica(campanita,Persona):-
    cree(Persona,campanita),
    dificultadPorSuenio(Persona,Dificultad),
    Dificultad < 5.

tieneQuimica(Personaje,Persona):-
    cree(Persona,Personaje),
    Personaje \= campanita,
    todosLosSueniosPuros(Persona),
    not(ambiciosa(Persona)).

todosLosSueniosPuros(Persona):-
    persona(Persona),
    forall(quiere(Persona,Suenio),esSuenioPuro(Suenio)).

esSuenioPuro(serFutbolista(_)).
esSuenioPuro(serCantante(Ventas)):- Ventas < 200000.

% 4)
amigo(campanita,reyesMagos).
amigo(campanita,conejoDePascua).
amigo(conejoDePascua,cavenaghi).
enfermo(campanita).
enfermo(conejoDePascua).

puedeAlegrar(Personaje,Persona):-
    persona(Persona),
    tieneQuimica(Personaje,Persona),
    not(enfermo(Personaje)).

puedeAlegrar(Personaje,Persona):-
    persona(Persona),
    tieneQuimica(Personaje,Persona),
    personajeBackUp(Personaje,PersonajeBackup),
    not(enfermo(PersonajeBackup)).

personajeBackUp(Personaje1,Personaje2):-
    amigo(Personaje1,Personaje2).

personajeBackUp(Personaje1,Personaje2):-
    amigo(Personaje1,Personaje3),
    personajeBackUp(Personaje3,Personaje2).







