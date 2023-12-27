def sumaArr(numeros: list[int], n: int) -> list[int]:
    for i in range(len(numeros)):
        for j in range(i + 1, len(numeros)):
            if numeros[j] == n - numeros[i]:
                return [i, j]

print(sumaArr([1,2,2], 3))