import simpy
from Nodo import *
from Canales.CanalBroadcast import *

class NodoVecinos(Nodo):
    ''' Implementa la interfaz de Nodo para el algoritmo de conocer a los
        vecinos de tus vecinos.'''

    def __init__(self, id_nodo, vecinos, canal_entrada, canal_salida):
        
        self.id_nodo = id_nodo
        self.vecinos = vecinos
        self.canal_entrada = canal_entrada
        self.canal_salida = canal_salida
        ''' Atributo extra dado en clase'''
        self.identifiers = set()

    def conoceVecinos(self, env):
        
        ''' Algoritmo 1 hace que un  nodo conozca a los vecinos de sus vecinos.
        '''

        self.canal_salida.envia(self.vecinos,self.vecinos)

        ''' Siempre que el mensaje sea recibido
        recibimos el canal de entrada y guardamos 
        los identificadores de los vecinos del nodo'''
        while True:

            mensaje = yield self.canal_entrada.get()
            self.identifiers.update(mensaje)


            


