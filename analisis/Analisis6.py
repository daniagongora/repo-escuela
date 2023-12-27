def abs_sort(arr):
    # Paso 1: crear un arreglo auxiliar de tamaño máximo igual al valor absoluto del elemento más grande del arreglo de entrada más uno.
    max_val = max(arr, key=abs)
    count = [0] * (abs(max_val) + 1)
    
    # Paso 2: contar la frecuencia de los elementos en el arreglo auxiliar.
    for num in arr:
        count[abs(num)] += 1
    
    # Paso 3: crear un arreglo de salida del mismo tamaño que el arreglo de entrada.
    output = [0] * len(arr)
    
    # Paso 4: rellenar el arreglo de salida de la siguiente manera:
    # Recorrer los elementos desde el inicio del arreglo hasta el primer elemento distinto de cero y colocarlos en orden descendente en el arreglo de salida.
    # Recorrer los elementos desde el final del arreglo hasta el último elemento distinto de cero y colocarlos en orden ascendente en el arreglo de salida.
    i = 0
    j = len(count) - 1
    while i <= j:
        if count[i] > 0:
            output[count[i+j]] = -i
            count[i] -= 1
        if count[j] > 0:
            output[count[i+j]] = j
            count[j] -= 1

