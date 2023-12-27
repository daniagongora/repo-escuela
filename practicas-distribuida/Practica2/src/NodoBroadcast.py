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
        

    def broadcast(self, env):
        ''' Utlizamos un nodo distinguido por el cual 
        comenzamos la difusión del mensaje'''

        '''Empezamos la ejecución en el nodo distinguido'''
        if self.id_nodo == 0:
            yield env.timeout(TICK)
            
            self.mensaje = "soy un mensaje"
            ''' Enviamos el mensaje a los vecinos '''
            self.canal_salida.envia(self.mensaje,self.vecinos)
        
        ''' Pasamos al caso donde recibimos un mensaje '''
        while True:
            
            self.mensaje = yield self.canal_entrada.get()
            yield env.timeout(TICK)
            ''' Enviamos el mensaje a los vecinos'''
            self.canal_salida.envia(self.mensaje,self.vecinos)
            
