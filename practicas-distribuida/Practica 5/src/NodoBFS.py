import math
import simpy
from Nodo import *
from Canales.CanalRecorridos import *

# La unidad de tiempo
TICK = 1

class NodoBFS(Nodo):
    ''' Implementa la interfaz de Nodo para el algoritmo de Broadcast.'''
    def __init__(self, id_nodo, vecinos, canal_entrada, canal_salida):
        ''' Constructor de nodo que implemente el algoritmo BFS. '''
        ''' Aquí va tu implementacion '''
        super().__init__(id_nodo,vecinos,canal_entrada,canal_salida)
        self.padre = id_nodo
        self.distancia = math.inf

    def bfs(self,env):
        if self.id_nodo == 0:
            yield env.timeout(TICK)
            self.distancia = 0
            self.canal_salida.envia((self.id_nodo,0), self.vecinos)

        while True:
            (padre,distancia) = yield self.canal_entrada.get()
            if distancia + 1 < self.distancia:
                self.distancia = distancia + 1
                self.padre = padre
                yield env.timeout(TICK)
                self.canal_salida.envia((self.id_nodo,self.distancia),self.vecinos)
