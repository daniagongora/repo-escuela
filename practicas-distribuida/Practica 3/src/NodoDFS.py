import simpy
from Nodo import *
from Canales.CanalRecorridos import *

# La unidad de tiempo
TICK = 1

class NodoDFS(Nodo):
    ''' Implementa la interfaz de Nodo para el algoritmo de Broadcast.'''
    def __init__(self, id_nodo, vecinos, canal_entrada, canal_salida):
        ''' Constructor de nodo que implemente el algoritmo DFS. '''
        # Tu implementación va aquí
        self.id_nodo = id_nodo
        self.vecinos = vecinos
        self.canal_entrada = canal_entrada
        self.canal_salida = canal_salida
        
        #atributos extra para la función
        self.padre = id_nodo
        self.hijos = [] #utilizaremos una lista para almacenarlos

    def menor(self, visitados):
        '''Para obtener el menor de los visitados'''
    
        diferencia_conj = list(set(self.vecinos).difference(visitados))
        menor = min(diferencia_conj)
    
        '''Regresa el vertice con el menor id'''
        return menor

    def dfs(self, env):
        ''' Algoritmo DFS. '''
        # Tu implementación va aquí
        #Por convención el nodo distinguido es 0
        
        if self.id_nodo == 0:

            yield env.timeout(TICK)
            self.canal_salida.envia(['GO',self.id_nodo,{0}],[self.menor(set())])
            self.hijos.append(self.menor(set()))

        while True:
            
            #Obtenemos el mensaje
            mensaje = yield self.canal_entrada.get()

            tipo_mensaje = mensaje[0]
            id_recibido = mensaje[1]
            visitados = mensaje[2]

            #Para el caso GO
            if (tipo_mensaje == 'GO'):

                self.padre = id_recibido

                #en caso de no haber visitado los vecinos
                if (set(self.vecinos).issubset(visitados)==False):
                    yield env.timeout(TICK)
                    min = self.menor(visitados)       
                    #enviamos GO
                    self.canal_salida.envia(['GO',self.id_nodo,visitados.union({self.id_nodo})],[min])
                    self.hijos = [min]
                    
                #si los vecinos ya han sido visitados
                else:
                    yield env.timeout(TICK)
                    self.canal_salida.envia(['BACK',self.id_nodo,visitados.union({self.id_nodo})],[id_recibido])
                    self.hijos = []

            #Para el caso BACK
            if (tipo_mensaje == 'BACK'):

                #en caso de no haber visitado los vecinos
                if (set(self.vecinos).issubset(visitados)==False):

                    yield env.timeout(TICK)
                    min = self.menor(visitados)
                    self.canal_salida.envia(['GO',self.id_nodo,visitados],[min])
                    self.hijos = list(set (self.hijos).union({min}))
                    
                #si los vecinos ya han sido visitados       
                else:
                    
                    #si estamos parados en el padre terminamos
                    if (self.padre == self.id_nodo):

                        print("Termino DFS")
                    
                    #en otro caso, que envie un mensaje 'BACK' a su padre.
                    else:
                        yield env.timeout(TICK)
                        self.canal_salida.envia(['BACK',self.id_nodo,visitados],[self.padre])