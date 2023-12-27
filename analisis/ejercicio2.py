import math
import sys

def factorial(n):

    resultado = 1

    for i in range(n, -1, -1):
        
        if i == 0:
            resultado *= 1
        else:
            resultado *= i

    return resultado

def coeficiente_binomial(n,r):
    return int((factorial(n))/(factorial(r)*(factorial(n-r))))

def binom_mod_p(n,r,p):

    # Caso n < r
    if n < r :
        return 0
    
    # Caso p ≥ 50
    if p >= 50:
        print("Excepcion: p es mayor o igual a 50")
        return
    
    # Primos
    primos = set([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47])

    # Caso p no es factor primo
    if p not in primos:
        print("Excepcion: p no es un factor primo")
        return
    
    # Arreglo n_p
    n_p = list()

    # Arreglo r_p
    r_p = list()

    cociente = n
    
    while cociente != 0:
        n_p.insert(0,cociente%p)
        cociente = math.floor(cociente/p)

    # Convertimos n y r en base p
    cociente = r
    while cociente != 0:
        r_p.insert(0,cociente%p) 
        cociente = math.floor(cociente/p)

    # Determinamos el arreglo de mayor tamaño
    maximo = max(len(n_p),len(r_p))

    # Rellenamos con 0's el arreglo de menor longitud
    if maximo == len(n_p):
        while len(r_p)!=len(n_p):
            r_p.insert(0,0)
    if maximo == len(r_p):
        while len(n_p)!=len(r_p):
            n_p.insert(0,0)

    # Resolvermos el producto de coeficientes binomiales
    resultado = 1
    for i in range(maximo):
        resultado *= coeficiente_binomial(n_p[i],r_p[i])

    # Regresamos el resultado final
    return resultado % p
    
def main():

    n = int(sys.argv[1])
    r = int(sys.argv[2])
    p = int(sys.argv[3])
    
    print(f" ({n} {r}) mod {p} = {binom_mod_p(n,r,p)}")
    
if __name__ == '__main__':
    main()



    










