import simpy
import time
from Nodo import *
from Canales.CanalBroadcast import *

# La unidad de tiempo
TICK = 1

class NodoBroadcast(Nodo):
    ''' Implementa la interfaz de Nodo para el algoritmo de Broadcast.'''
    def __init__(self, id_nodo, vecinos, canal_entrada, canal_salida, mensaje=None):
        self.id_nodo = id_nodo
        self.vecinos = vecinos
        self.canal_entrada = canal_entrada
        self.canal_salida = canal_salida
        self.mensaje = mensaje
        # No hay atributos extra

    def broadcast(self, env):
        ''' Algoritmo de Broadcast. Desde el nodo distinguido (0)
            vamos a enviar un mensaje a todos los demás nodos.'''

        # El nodo distinguido comienza la ejecucion
        if self.id_nodo == 0:
            yield env.timeout(TICK)
            # Mensaje a enviar
            self.mensaje = "ola k ase"
            # Enviamos el mensaje a los vecinos del nodo
            self.canal_salida.envia(self.mensaje,self.vecinos)
        
        # Cuando el mensaje es recibido
        while True:
            # Extraemos el mensaje del canal de entrada del nodo
            self.mensaje = yield self.canal_entrada.get()
            yield env.timeout(TICK)
            # Enviamos el mensaje a los vecinos del nodo
            self.canal_salida.envia(self.mensaje,self.vecinos)
            
