

def findRepeating(arr, N):
	s = set()
	for i in range(N):
		if arr[i] in s:
			return arr[i]
		s.add(arr[i])

	# If input is correct, we should
	# never reach here
	return -1

print(findRepeating([1,3,0,3,4,2,6], 7))



def MissingNo(arr):
    n = len(arr)
    total = ((n-1) + 1)*((n -1)+ 2)/2
    arr_sum = sum(arr)
    return total - arr_sum

print(MissingNo([7, 1, 5, 0, 3, 4, 2]))

def findRepeat(arr):
 
    # Find array sum and subtract sum
    # first n-1 natural numbers from it
    # to find the result.
    aux=len(arr)
    n=aux-1
    return (n + 1)*(n+ 2)/2 -sum(arr) 

print(findRepeat([1,3,0,3,4,2,6]))