import simpy
from Nodo import *
from Canales.CanalRecorridos import *
from random import randint

class NodoBroadcast(Nodo):
	def __init__(self, id_nodo: int, vecinos: list, canal_entrada: simpy.Store,
                 canal_salida: simpy.Store):
		super().__init__(id_nodo,vecinos,canal_entrada,canal_salida)
		self.mensaje = None
		self.reloj = 0
		self.eventos = []

	def broadcast(self, env: simpy.Environment, data="Mensaje"):

		''' Aquí va tu código '''
		# Para los nodos no distinguidos no habra mensaje.
		
		if self.id_nodo != 0:
			
			self.mensaje = None

    	# Solo el nodo distinguido empezara a enviar mensajes.
		else:
			
			yield env.timeout(randint(0, 5))
		
			self.mensaje = "Mensaje"
			evento = 'E'
			
			#actualizamos el reloj interno del nodo y enviamos el mensaje a todos sus vecinos a través del canal de salida
			for i in range(len(self.vecinos)):
				self.reloj += 1
				msg = [self.mensaje, self.id_nodo, self.reloj]
				receptor = self.vecinos[i]
				self.canal_salida.envia(msg, [receptor])
				adjunto = [self.reloj, evento, self.mensaje, self.id_nodo, receptor]
				
				#agregamos el evento a la lista de eventos.
				self.eventos.append(adjunto)

		while True:
			
			yield env.timeout(randint(0, 5))
			self.mensaje, emisor, reloj_emisor = yield self.canal_entrada.get()
			self.reloj = max(reloj_emisor, self.reloj) + 1

			evento = 'R'
			#asignamos el valor de la identificación del nodo actual.
			recibidor = [self.id_nodo]
			
			#agregamos a la lista de eventos actual
			self.eventos += [[self.reloj, evento, self.mensaje, emisor, r] for r in recibidor]

			# Si hay vecinos a los que enviar el mensaje enviamos el mensaje a todos sus vecinos a través del canal de salida 
			if len(self.vecinos) >= 0:
				
				yield env.timeout(randint(0, 5))
				evento = 'E'
				
				for recibidor in self.vecinos:
					self.reloj += 1
					msj = [self.mensaje, self.id_nodo, self.reloj]
					self.canal_salida.envia(msj, [recibidor])
					adjuntar = [self.reloj, evento, self.mensaje, self.id_nodo, recibidor]
					
					#agregamos el evento a la lista de eventos.
					self.eventos.append(adjuntar)


