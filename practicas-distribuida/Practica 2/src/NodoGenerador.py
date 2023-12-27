import simpy
from Nodo import *
from Canales.CanalBroadcast import *

TICK = 1

class NodoGenerador(Nodo):
    '''Implementa la interfaz de Nodo para el algoritmo de flooding.'''
    def __init__(self, id_nodo, vecinos, canal_entrada, canal_salida):
        '''Inicializamos el nodo.'''
        self.id_nodo = id_nodo
        self.vecinos = vecinos
        self.canal_entrada = canal_entrada
        self.canal_salida = canal_salida
        # Atributos extra
        self.mensajes_esperados = None
        self.padre = None
        self.hijos = list()

    def genera_arbol(self, env):
        ''' Algoritmo que construye el arbol generador de una grafica'''
        
        # El nodo distinguido comienza la ejecucion
        if self.id_nodo == 0:
            yield env.timeout(TICK)
            # El padre del nodo distinguido es él mismo.
            self.padre = self.id_nodo
            # Cantidad de mensajes esperados
            self.mensajes_esperados = len(self.vecinos)
            # Enviamos el id del nodo a sus vecinos
            self.canal_salida.envia([self.id_nodo,'GO'],self.vecinos)
        
        while True:
            
            # Extraemos el mensaje del canal de entrada
            mensaje = yield self.canal_entrada.get()

            # Extraemos el id del nodo que envio el  mensaje
            id_recibido = mensaje[0]

            # Extraemos el tipo de mensaje que recibimos
            tipo_mensaje = mensaje[1]

            # GO
            if tipo_mensaje == 'GO': 
                
                # Si no tenemos padre
                if self.padre == None : 
                    # Asignamos el padre
                    self.padre = id_recibido
                    # Reducimos la cantidad de mensajes esperados
                    self.mensajes_esperados = len(self.vecinos) - 1
                    # Si no esperamos mensajes
                    if self.mensajes_esperados == 0:
                        yield env.timeout(TICK)
                        # Regresamos el id del nodo al padre
                        self.canal_salida.envia([self.id_nodo,'BACK'],[self.padre])
                    else:
                        # Si esperamos mensajes
                        yield env.timeout(TICK)
                        # Enviamos el id del nodo a sus vecinos exceptuando al padre
                        nodos_a_enviar = set(self.vecinos)
                        nodos_a_enviar.remove(self.padre)
                        nodos_a_enviar = list(nodos_a_enviar)
                        self.canal_salida.envia([self.id_nodo,'GO'],nodos_a_enviar)
                else: # Si ya tenemos padre
                    yield env.timeout(TICK)
                    # Regresamos None al emisor del mensaje para que espere un mensaje menos
                    self.canal_salida.envia([None,'BACK'],[id_recibido])
            
            # BACK
            if tipo_mensaje == 'BACK':
                # Reducimos la cantidad de mensajes esperados
                self.mensajes_esperados = self.mensajes_esperados - 1
                # Hacemos hijo al nodo que nos regreso el mensaje
                if id_recibido != None:
                    self.hijos.append(id_recibido)
                # Si ya no esperamos mensaje
                if self.mensajes_esperados == 0:
                    # Verificamos que el mensaje regrese hasta la raiz
                    if self.padre != self.id_nodo:
                        yield env.timeout(TICK)
                        self.canal_salida.envia([self.id_nodo,'BACK'],[self.padre])
                

        
        


            
