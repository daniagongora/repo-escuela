import simpy
from Nodo import *
from Canales.CanalRecorridos import *
from random import randint

class NodoDFS(Nodo):
    ''' Implementa la interfaz de Nodo para el algoritmo de Broadcast.'''

    def __init__(self, id_nodo, vecinos, canal_entrada, canal_salida, num_nodos):
        ''' Constructor de nodo que implemente el algoritmo DFS. '''
        # Tu implementación va aquí
        super().__init__(id_nodo,vecinos,canal_entrada,canal_salida)
        self.padre = self.id_nodo
        self.hijos = []
        self.eventos = []
        self.reloj = [0] * num_nodos

    def dfs(self, env):
        ''' Algoritmo DFS. '''
        # Tu implementación va aquí
        if self.id_nodo == 0: # Si es el nodo 0, envía el mensaje
            self.hijos = [self.vecinos[0]] # Guarda el mensaje
            yield env.timeout(randint(1, 5)) # Espera un tiempo aleatorio
            self.reloj[self.id_nodo] = self.reloj[self.id_nodo] + 1 # Aumenta el reloj
            self.eventos.append([self.reloj.copy(), 'E', str({self.id_nodo}), self.id_nodo, self.vecinos[0]]) # Guarda el evento
            self.canal_salida.envia(("GO", {self.id_nodo}, self.id_nodo, self.reloj), [self.vecinos[0]]) # Envía el mensaje
        while True: # Si no es el nodo 0, espera a recibir un mensaje
            yield env.timeout(randint(1, 5)) # Espera un tiempo aleatorio
            (typeof, visitados, p_j, reloj) = yield self.canal_entrada.get() # Recibe el mensaje
            for h in range(len(self.reloj)): # para cada nodo en el reloj
                self.reloj[h] = max(reloj[h],self.reloj[h]) # Actualiza el reloj
            self.reloj[self.id_nodo] = self.reloj[self.id_nodo] + 1 # Aumenta el reloj
            self.eventos.append([self.reloj.copy(), 'R', str(visitados), p_j, self.id_nodo]) # Guarda el evento
            if typeof == "GO": # Si el mensaje es de tipo GO
                self.padre = p_j # Guarda el padre
                if set(self.vecinos) <= visitados: # Si todos los vecinos ya fueron visitados
                    yield env.timeout(randint(1, 5)) # Espera un tiempo aleatorio
                    self.hijos = [] # No tiene hijos
                    self.reloj[self.id_nodo] = self.reloj[self.id_nodo] + 1 # Aumenta el reloj
                    self.eventos.append([self.reloj.copy(), 'E', str(visitados | {self.id_nodo}), self.id_nodo, p_j]) # Guarda el evento
                    self.canal_salida.envia(("BACK", visitados | {self.id_nodo}, self.id_nodo, self.reloj), [p_j]) # Envía el mensaje
                else: # Si no todos los vecinos han sido visitados
                    s = list(set(self.vecinos) - visitados)[0] # Elige un vecino que no haya sido visitado
                    yield env.timeout(randint(0, 10)) # Espera un tiempo aleatorio
                    self.hijos = [s] # Guarda el mensaje
                    self.reloj[self.id_nodo] = self.reloj[self.id_nodo] + 1 # Aumenta el reloj
                    self.eventos.append([self.reloj.copy(), 'E', str(visitados | {self.id_nodo}), self.id_nodo, s]) # Guarda el evento
                    self.canal_salida.envia(("GO", visitados | {self.id_nodo}, self.id_nodo, self.reloj), [s]) # Envía el mensaje
            else: # Si el mensaje es de tipo BACK
                if set(self.vecinos) <= visitados: # Si todos los vecinos ya fueron visitados
                    if self.padre == self.id_nodo: # Si es el nodo raíz
                        return #Clausula de escape
                    else: # Si no es el nodo raíz
                        yield env.timeout(randint(0, 10)) # Espera un tiempo aleatorio
                        self.reloj[self.id_nodo] = self.reloj[self.id_nodo] + 1 # Aumenta el reloj
                        self.eventos.append([self.reloj.copy(), 'E', str(visitados), self.id_nodo, self.padre]) # Guarda el evento
                        self.canal_salida.envia(("BACK", visitados, self.id_nodo, self.reloj), [self.padre]) # Envía el mensaje
                else: # Si no todos los vecinos han sido visitados
                    t = list(set(self.vecinos) - visitados)[0] # Elige un vecino que no haya sido visitado
                    yield env.timeout(randint(0, 10)) 
                    self.hijos.append(t) # Guarda el mensaje
                    self.reloj[self.id_nodo] = self.reloj[self.id_nodo] + 1 # Aumenta el reloj
                    self.eventos.append([self.reloj.copy(), 'E', str(visitados), self.id_nodo, t]) # Guarda el evento
                    self.canal_salida.envia(("GO", visitados, self.id_nodo, self.reloj), [t]) # Envía el mensaje