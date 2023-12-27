def calculate_sales_sequence(buildings):
    n = len(buildings)
    max_values = [[0] * (n+2) for _ in range(n+2)]
    choices = [[0] * (n+2) for _ in range(n+2)]

    for i in range(1, n+1):
        max_values[i][i] = buildings[i-1]
        choices[i][i] = i

    for length in range(2, n+1):
        for i in range(1, n-length+2):
            j = i + length - 1
            max_values[i][j] = max_values[i+1][j] + (length * buildings[i-1])
            choices[i][j] = i
            for k in range(i+1, j):
                value = max_values[i][k] + max_values[k+1][j] + ((length-1) * buildings[k-1])
                if value > max_values[i][j]:
                    max_values[i][j] = value
                    choices[i][j] = k

    sequence = []
    def get_sales_sequence(i, j):
        if i == j:
            sequence.append(i-1)
        else:
            k = choices[i][j]
            get_sales_sequence(i, k)
            get_sales_sequence(k+1, j)
    get_sales_sequence(1, n)

    return max_values[1][n], sequence

print(len([1,9,11,10,15,11,19,20,4,11,5,3,5,20,5,10,16,19,17,17,2,14,8,16,13,18,19,5,18,20]
))