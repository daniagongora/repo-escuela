import simpy

class Nodo:
    """Representa un nodo.
    Cada nodo tiene un id, una lista de vecinos y dos canales de comunicación.
    Los métodos que tiene son únicamente getters.
    """
    def __init__(self, id_nodo: int, vecinos: list, canal_entrada: simpy.Store,
                 canal_salida: simpy.Store):
        '''Inicializa los atributos del nodo.'''
        self.id_nodo = id_nodo
        self.vecinos = vecinos
        self.canal_entrada = canal_entrada
        self.canal_salida = canal_salida

    def get_id_nodo(self):
        '''Regresa el id del nodo.'''
        return self.id_nodo

    def get_vecinos(self):
        '''Regresa la lista de los vecinos del nodo'''
        return self.vecinos
    
    def get_canal_entrada(self):
        return self.canal_entrada
    
    def get_canal_salida(self):
        return self.canal_salida
    
    def set_id_nodo(self,id_nodo):
        self.id_nodo = id_nodo
        
    def set_vecinos(self,vecinos):
        self.vecinos = vecinos
        
    def set_canal_entrada(self,canal_entrada):
        self.canal_entrada = canal_entrada
        
    def set_canal_salida(self,canal_salida):
        self.canal_salida = canal_salida

    def __str__(self):
        return "Nodo " + str(self.id_nodo) + ", vecinos: " + str(self.vecinos)
