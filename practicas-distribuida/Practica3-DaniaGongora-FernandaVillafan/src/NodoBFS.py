import simpy
from Nodo import *
from Canales.CanalRecorridos import *
from math import inf as infinito

# La unidad de tiempo.
TICK = 1

class NodoBFS(Nodo):
    ''' Implementa la interfaz de Nodo para el algoritmo de Broadcast. '''
    def __init__(self, id_nodo, vecinos, canal_entrada, canal_salida):
        ''' Constructor de nodo que implemente el algoritmo BFS. '''
        self.id_nodo = id_nodo
        self.vecinos = vecinos
        self.canal_entrada = canal_entrada
        self.canal_salida = canal_salida

        # Atributos extras para la función.
        self.padre = 0
        self.distancia = infinito

    def bfs(self, env):
        ''' Algoritmo BFS. '''
        # Por convención el nodo distinguido es 0.

        if (self.id_nodo == 0): # Si soy el nodo distinguido...

            yield env.timeout(TICK)
            self.distancia = 0
            # Enviamos el valor de distancia a los vecinos.
            self.canal_salida.envia((self.id_nodo, self.distancia), self.vecinos)

        while True:

            # Obtenemos el mensaje del canal.
            mensaje = yield self.canal_entrada.get()

            id_remitente = mensaje[0]
            valor_distancia = mensaje[1]

            # Verificamos el valor recibido con nuestro valor de distancia.
            if ((valor_distancia + 1) < self.distancia):
                self.padre = id_remitente
                self.distancia = valor_distancia + 1

                yield env.timeout(TICK)
                # Enviamos el valor de distancia a los vecinos.
                self.canal_salida.envia((self.id_nodo, self.distancia), self.vecinos)