import sys
# Algoritmo para encontar 2 elementos faltantes
# Utillizando O(1) extra de espacio

#Utilizaremos un algoritmo auxiliar que 
#calcule la suma de los elementos de un
#arreglo 
def suma(arr,n):

	sum = 0;
	for i in range(0, n):
		sum += arr[i]
	return sum

# Algoritmo para encontar 2 elementos faltantes
# Utillizando O(1) extra de espacio
# En un rango de 0 hasta n-1. 
def encuentraDosNumeros(arr, n):

	sum = (((n-1) * ((n-1) + 1)) / 2 -suma(arr, (n-1) - 1));

	mitad = (sum / 2);

	sumaDerecha = 0
	sumaIzquierda = 0;
	for i in range(0, n - 1):
	
		if (arr[i] <= mitad):
			sumaDerecha += arr[i]
		else:
			sumaIzquierda += arr[i]
	
	print("Los dos números que hacen falta son:")

	totalDerecho = (mitad * (mitad + 1)) / 2
	print(totalDerecho -sumaDerecha)
	print(((n * (n + 1)) / 2 -totalDerecho) -sumaIzquierda)



#Algoritmo que encuentra los 3 números repetidos
#Utilizando O(1) extra de espacio

def arregloTresRepetidos(arr, n):

	aux1 = 0
	aux2 = 0
	primero = sys.maxsize
	segundo = sys.maxsize

	for i in range(0, n):

		#si ya vimos este elemento
		#aumentamos la visita de aux1 en 1
		if (primero == arr[i]):
			aux1 += 1

		#si ya vimos este elemento
		#aumentamos la visita de aux1 en 1
		elif (segundo == arr[i]):
			aux2 += 1
	
		elif (aux1 == 0):
			aux1 += 1
			primero = arr[i]

		elif (aux2 == 0):
			aux2 += 1
			segundo = arr[i]
		

		#Si el elemento que visitamos
		#no lo hemos visitado decrementamos
		#a las variables auxiliares
		else:
			aux1 -= 1
			aux2 -= 1
		
	

	aux1 = 0
	aux2 = 0

	# recorreremos en arreglo
	#de nuevo para llevar la
	#cuenta de las variables aux
	for i in range(0, n):
		if (arr[i] == primero):
			aux1 += 1

		elif (arr[i] == segundo):
			aux2 += 1
	

	if (aux1 == 3):
		return primero

	if (aux2 == 3):
		return segundo

	return -1



#algoritmo que encuentra el número 
#repetido 3 veces y encuentra los 2 numeros faltantes

def algoritmo2(arr, n):
	aux=arregloTresRepetidos(arr, n)
	print("El elemento repetido es:", aux)
	arr.remove(aux)
	arr.remove(aux)
	encuentraDosNumeros(arr, 1+len(arr))

algoritmo2([7, 1, 5, 0, 3, 4, 5, 5], 8)