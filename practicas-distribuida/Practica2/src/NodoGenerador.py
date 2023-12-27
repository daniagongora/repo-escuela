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
        ''' Atributos extra dados en clase'''
        self.mensajes_esperados = None
        self.padre = None
        self.hijos = list()

    def genera_arbol(self, env):
        
        ''' Algoritmo 4 que construye el arbol generador'''
        
        '''Empezamos la ejecución en el nodo distinguido
        Definimos los parametros'''
        
        if self.id_nodo == 0:
            yield env.timeout(TICK)
            self.padre = self.id_nodo
            self.mensajes_esperados = len(self.vecinos)
            self.canal_salida.envia([self.id_nodo,'GO'],self.vecinos)
        
        while True:
            
            mensaje = yield self.canal_entrada.get()
            id_recibido = mensaje[0]
            tipo_mensaje = mensaje[1]

            '''En el caso de GO'''
            if tipo_mensaje == 'GO': 
                
                '''En caso de no tener padre asignamos uno'''
                if self.padre == None : 
                    self.padre = id_recibido
                    self.mensajes_esperados = len(self.vecinos) - 1
                    
                    ''' En caso de no esperar mensajes regresamos el id del padre'''
                    if self.mensajes_esperados == 0:
                        yield env.timeout(TICK)
                        self.canal_salida.envia([self.id_nodo,'BACK'],[self.padre])
                    else:
                        ''' En otro caso enviamos el id a sus vecinos (n-1 vecinos)'''
                        yield env.timeout(TICK)
                        nodos_a_enviar = set(self.vecinos)
                        nodos_a_enviar.remove(self.padre)
                        nodos_a_enviar = list(nodos_a_enviar)
                        self.canal_salida.envia([self.id_nodo,'GO'],nodos_a_enviar)
                else: 
                    ''' Si hay un padre regresamos NONE al emisor'''
                    yield env.timeout(TICK)
                    self.canal_salida.envia([None,'BACK'],[id_recibido])
            
            '''En el caso de BACK reducimos la cantidad de mensajes'''
            if tipo_mensaje == 'BACK':
                self.mensajes_esperados = self.mensajes_esperados - 1
                
                if id_recibido != None:
                    self.hijos.append(id_recibido)
                ''' En caso de ya no esperar mensajes verificamos 
                que el mensaje regrese a la raíz'''
                if self.mensajes_esperados == 0:
                    
                    if self.padre != self.id_nodo:
                        yield env.timeout(TICK)
                        self.canal_salida.envia([self.id_nodo,'BACK'],[self.padre])
                

        
        


            
