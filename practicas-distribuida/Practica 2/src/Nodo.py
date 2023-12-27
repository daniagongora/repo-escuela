import simpy

class Nodo:
    """Representa un nodo.

    Cada nodo tiene un id, una lista de vecinos y dos canales de comunicación.
    Los métodos que tiene son únicamente getters.
    """
    def __init__(self, id_nodo: int, vecinos: list, canal_entrada: simpy.Store,
                 canal_salida: simpy.Store):
        '''Inicializa los atributos del nodo.'''

    def get_id(self) -> int:
        '''Regresa el id del nodo.'''
