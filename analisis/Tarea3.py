def coeficiente_binomial_modulo(n, r, p):
    # Caso base
    if r > n:
        return 0

    # C(n,r) = C(n,n-r). El código es más eficiente para valores más pequeños de n-r.
    if n - r > r:
        r = n - r

    # Lista para almacenar el menor factor primo de cada número del 1 al n
    SPF = [0] * (n + 1)
    SPF[1] = 1

    # Precalculamos los menores factores primos
    for i in range(2, n + 1):
        if SPF[i] == 0:
            SPF[i] = i
            for j in range(i * i, n + 1, i):
                if SPF[j] == 0:
                    SPF[j] = i

    # Diccionario para almacenar la potencia de cada factor primo en C(n,r)
    prime_pow = {}

    # Para el numerador, contamos la frecuencia de cada factor primo
    for i in range(r + 1, n + 1):
        t = i

        # División recursiva para encontrar la factorización en primos de i
        while t > 1:
            if SPF[t] not in prime_pow:
                prime_pow[SPF[t]] = 1
            else:
                prime_pow[SPF[t]] += 1
            t //= SPF[t]

    # Para el denominador, restamos la potencia de cada factor primo
    for i in range(1, n - r + 1):
        t = i

        # División recursiva para encontrar la factorización en primos de i
        while t > 1:
            prime_pow[SPF[t]] -= 1
            t //= SPF[t]

    ans = 1

    # Calculamos (a*b)%mod = (a%mod * b%mod)%mod
    for i in prime_pow:
        ans = (ans * pow(i, prime_pow[i], p)) % p

    return ans


print("Ejemplo 1 :", coeficiente_binomial_modulo(6, 2, 13))
print("Ejemplo 2 :", coeficiente_binomial_modulo(10, 2, 13))