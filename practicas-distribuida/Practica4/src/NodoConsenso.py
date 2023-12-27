import simpy
from Nodo import *
from Canales.CanalRecorridos import *

# La unidad de tiempo
TICK = 1

class NodoConsenso(Nodo):
    ''' Implementa la interfaz de Nodo para el algoritmo de Consenso.'''

    def __init__(self, id_nodo, vecinos, canal_entrada, canal_salida):
        ''' Constructor de nodo que implemente el algoritmo de consenso. '''
        self.id_nodo = id_nodo
        self.vecinos = vecinos
        self.canal_entrada = canal_entrada
        self.canal_salida = canal_salida
        # Atributos extra
        self.V = [None] * (len(vecinos) + 1) # Llenamos la lista de Nones
        self.V[id_nodo] = id_nodo
        self.New = set([id_nodo])
        self.rec_from = [None] * (len(vecinos) + 1)
        self.fallare = False      # Colocaremos esta en True si el nodo fallará
        self.lider = None         # La elección del lider.

    def consenso(self, env, f):
        '''El algoritmo de consenso.'''
        # Aquí va su implementación

        rondaFinal = f+1
        falla = 0
        
        #Comenzamos el algoritmo
        while True:
            
            #Establecemos cuáles son los nodos que fallaran en la ronda actual
            if env.now < f:
                falla = env.now
            else:
                falla = -1
            
            if(self.id_nodo == falla):
                self.fallare = True
                break
            #Enviamos mensajes a los vecinos si los identificadores de los nodos recién descubiertos no está vacío.
            if(len(self.New) == 0):
                yield env.timeout(TICK)
                self.canal_salida.envia([self.id_nodo, set([])], self.vecinos)

            else:

                yield env.timeout(TICK)
                identificadores = [self.id_nodo, self.New]
                self.canal_salida.envia(identificadores, self.vecinos)

            esperado = len(self.vecinos) - env.now
            
            #Esperamos a que lleguen los mensajes de los vecinos
            if(env.now == rondaFinal):
                esperado = len(self.vecinos) - (env.now-1)
            
            # Para que podamos recibir todos los mensajes esperados
            while (esperado > 0):
                mensaje = yield self.canal_entrada.get()
                emisor = mensaje[0]
                self.rec_from[emisor] = mensaje
                mensaje = None
                esperado = esperado-1
            
            #Actualizamos
            self.New = set()
            i = 0
            
            #Actualizamos
            self.New = set()
            for i, mensaje in enumerate(self.rec_from):
                if i != self.id_nodo and mensaje is not None:
                    for j in mensaje[1]:
                        if self.V[j] is None:
                            self.V[j] = j
                            self.New.add(j)

            #Si estamos en la ronda final interrumpimos
            if(env.now == rondaFinal):
                break
        
        # Tomamos al lider 
        for l in self.V:
            if l is not None:
                self.lider = l
                break
       