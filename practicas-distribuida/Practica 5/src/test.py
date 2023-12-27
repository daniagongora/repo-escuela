from Canales.CanalRecorridos import *
from NodoBroadcast import *
from NodoDFS import *


class TestPractica4:
    ''' Clase para las pruebas unitarias de la práctica 4. '''
    # Las aristas de adyacencias de la gráfica.
    adyacencias = [[1, 3, 4, 6], [0, 3, 5, 7], [
        3, 5, 6], [0, 1, 2], [0], [1, 2], [0, 2], [1]]
    adyacencias_arbol = [[1, 2], [3], [5], [4], [], []]
    # Será el mismo para todos.
    adyacencias_arbol_1 = [[1], [2], [3, 4], [5, 6], [], [], []]
    adyacencias_arbol_2 = [[1], [2], [3], []]

    def verifica_orden_ascendente(self, grafica, es_vectorial):
        '''
        Verificamos que el orden de los eventos de cada proceso tenga valores de reloj
        ascendetes. Si la variable booleana es vectorial usaremos la comparacion de relojes
        vectoriales.
        '''
        for nodo in grafica:
            # Si algun reloj resulta menor a este valor está mal.
            actual_reloj = [0]*8 if es_vectorial else 0
            for evento in nodo.eventos:
                reloj_actual_menor = self.compara_relojes(actual_reloj, evento[0]) if es_vectorial \
                    else actual_reloj < evento[0]
                if not reloj_actual_menor:  # El reloj encontrado es menor que el que llevamos
                    return False
                actual_reloj = evento[0]
        # Si no encontramos ningun reloj malo, entonces todo ta' bien.
        return True

    def verifica_pares_eventos(self, grafica, es_vectorial):
        '''
        Verificamos que para cada evento de envío exista un evento de recepción
        que siga el orden causal.
        '''
        # Usamos un diccionario para verificar los eventos que hemos visto.
        eventos_vistos = {}
        for nodo in grafica:  # Iteramos cada evento...
            for evento in nodo.eventos:  # ...de cada nodo
                # La llave que usaremos para buscar
                llave = tuple([evento[2], evento[3], evento[4]])
                # El valor que agregaremos (en caso de que la llave no exista)
                valor = [evento[0], evento[1]]
                # Renombramos estos valores para hacer más legible
                reloj_actual = evento[0]
                tipo_actual = evento[1]
                try:
                    # Puede que este valor no exista, lo que nos lanzaria
                    # una excepcion (KeyError)
                    valor_visto = eventos_vistos[llave]
                    reloj_visto = valor_visto[0]
                    tipo_visto = valor_visto[1]
                    # Variables booleanas auxiliares
                    reloj_visto_menor = self.compara_relojes(reloj_visto, reloj_actual) if es_vectorial \
                        else reloj_visto < reloj_actual
                    reloj_visto_mayor = self.compara_relojes(reloj_actual, reloj_visto) if es_vectorial \
                        else reloj_visto > reloj_actual
                    envio_encontrado = tipo_visto == 'E' and reloj_visto_menor \
                        and tipo_actual == 'R'
                    recibo_encontrado = tipo_visto == 'R' and reloj_visto_mayor \
                        and tipo_actual == 'E'
                    if envio_encontrado or recibo_encontrado:
                        # si el par que encontramos si sigue el orden causal...
                        # ... lo sacamos del diccionario
                        eventos_vistos.pop(llave)
                    else:
                        # En otro caso lo agregamos
                        eventos_vistos[llave] = valor
                except KeyError:
                    # Si no esta el valor
                    eventos_vistos[llave] = valor
        # Al final si el diccionario está vacío es porque pudimos 'emparejar' todos los pares
        return len(eventos_vistos.items()) == 0

    def compara_relojes(self, a, b):
        '''
        Dados dos relojes vectoriales a y b, regresamos True si a <= b.
        '''
        for i in range(0, len(a)):
            if a[i] <= b[i]:
                continue
            else:
                return False
        return True

    def test_ejercicio_uno(self):
        ''' Método que prueba el algoritmo de Broadcast. '''
        # Creamos el ambiente y el objeto Canal
        env = simpy.Environment()
        bc_pipe = CanalRecorridos(env)
        bc_pipe_1 = CanalRecorridos(env)
        bc_pipe_2 = CanalRecorridos(env)

        # La lista que representa la gráfica
        grafica = []
        grafica1 = []
        grafica2 = []

        # Creamos los nodos
        for i in range(0, len(self.adyacencias_arbol)):  # Gráfica 1
            grafica.append(NodoBroadcast(i, self.adyacencias_arbol[i],
                                         bc_pipe.crea_canal_de_entrada(), bc_pipe))

        for i in range(0, len(self.adyacencias_arbol_1)):  # Gráfica 2
            grafica1.append(NodoBroadcast(i, self.adyacencias_arbol_1[i],
                                          bc_pipe_1.crea_canal_de_entrada(), bc_pipe_1))

        for i in range(0, len(self.adyacencias_arbol_2)):  # Gráfica 3
            grafica2.append(NodoBroadcast(i, self.adyacencias_arbol_2[i],
                                          bc_pipe_2.crea_canal_de_entrada(), bc_pipe_2))

        # Le decimos al ambiente lo que va a procesar ...
        for nodo in grafica:
            env.process(nodo.broadcast(env))
        for nodo in grafica1:
            env.process(nodo.broadcast(env))
        for nodo in grafica2:
            env.process(nodo.broadcast(env))
        # ...y lo corremos
        env.run()

        # Probamos que todos los nodos tengan ya el mensaje
        mensaje_enviado = grafica[0].mensaje
        mensaje_enviado_1 = grafica1[0].mensaje
        mensaje_enviado_2 = grafica2[0].mensaje
        for nodo in grafica:
            assert mensaje_enviado == nodo.mensaje
        for nodo in grafica1:
            assert mensaje_enviado_1 == nodo.mensaje
        for nodo in grafica1:
            assert mensaje_enviado_2 == nodo.mensaje

        # Verificamos que, por proceso, los valores de los relojes vayn en orden ascendente.
        assert self.verifica_orden_ascendente(grafica, False)
        assert self.verifica_orden_ascendente(grafica1, False)
        assert self.verifica_orden_ascendente(grafica2, False)

        # Y que cada pareja envío-recepción sea lógica
        assert self.verifica_pares_eventos(grafica, False)
        assert self.verifica_pares_eventos(grafica1, False)
        assert self.verifica_pares_eventos(grafica2, False)

    def test_ejercicio_dos(self):
        ''' Prueba para el algoritmo DFS. '''
        # Creamos el ambiente y el objeto Canal
        env = simpy.Environment()
        bc_pipe = CanalRecorridos(env)

        # La lista que representa la gráfica
        grafica = []

        # Creamos los nodos
        for i in range(0, len(self.adyacencias)):
            grafica.append(NodoDFS(i, self.adyacencias[i],
                                   bc_pipe.crea_canal_de_entrada(), bc_pipe, 8))

        # Le decimos al ambiente lo que va a procesar ...
        for nodo in grafica:
            env.process(nodo.dfs(env))
            # ...y lo corremos
        env.run()

        # Probamos que efectivamente se hizo un DFS.
        padres_esperados = [0, 0, 3, 1, 0, 2, 2, 1]
        hijos_esperados = [[1, 4], [3, 7], [5, 6], [2], [], [], [], []]

        # Para cada nodo verificamos que su lista de identifiers sea la esperada.
        for i in range(0, len(grafica)):
            nodo = grafica[i]
            assert nodo.padre == padres_esperados[i]
            assert nodo.hijos == hijos_esperados[i]

        assert self.verifica_orden_ascendente(grafica, True)
        assert self.verifica_pares_eventos(grafica, True)
