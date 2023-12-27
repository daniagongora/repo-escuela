from Canales.CanalRecorridos import *
from NodoConsenso import *

class TestPractica2:
    ''' Clase para las pruebas unitarias de la práctica 2. '''

    # Las aristas de adyacencias de la gráfica.
    adyacencias = [[1, 2, 3, 4, 5, 6], [0, 2, 3, 4, 5, 6], [0, 1, 3, 4, 5, 6],
                   [0, 1, 2, 4, 5, 6], [0, 1, 2, 3, 5, 6], [0, 1, 2, 3, 4, 6],
                   [0, 1, 2, 3, 4, 5]]

    def test_ejercicio_uno(self):
        ''' Método que prueba el algoritmo de consenso. '''
        # Creamos el ambiente y el objeto Canal
        env = simpy.Environment()
        bc_pipe = CanalRecorridos(env)

        # La lista que representa la gráfica
        grafica = []

        # Creamos los nodos
        for i in range(0, len(self.adyacencias)):
            grafica.append(NodoConsenso(i, self.adyacencias[i],
                                        bc_pipe.crea_canal_de_entrada(), bc_pipe))

        # Le decimos al ambiente lo que va a procesar ...
        f = 2 # El número de fallos
        for nodo in grafica:
            env.process(nodo.consenso(env, f))
        # ...y lo corremos
        env.run()

        nodos_fallidos = 0
        lider_elegido = None
        for i in range(0, len(grafica)):
            nodo = grafica[i]
            if nodo.fallare:
                nodos_fallidos += 1
            else:
                lider_elegido = nodo.lider if lider_elegido is None else lider_elegido
                assert lider_elegido == nodo.lider
                assert nodo.lider == next(item for item in nodo.V if item is not None)
        assert nodos_fallidos == f
