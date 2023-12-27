def maxEvenSumPair(arr, n) :
	
    result = 0;
    for i in range(n - 1) :
        for j in range(i + 1, n) :

            # Calculate the sum for each
            # pair 
            temporal = arr[i] + arr[j];

            # If sum is even than consider
            # it for result
            if (temporal % 2 == 0) :

                # Maintain maximum pair
                # sum in result
                result = max(result, temporal);

    # If result is zero that means
    # no pair with even sum is present
    if (result == 0) :
        return -1;

    return result;

arr = [17,34,21,35,63,123,21,1]
n=len(arr)
print("el feo: ",maxEvenSumPair(arr,n))

# Function to find maximum even pair sum
def maxEvenSumPair2(arr, n) :

    firstEvenMax = -1; secondEvenMax = -1;
    firstOddMax = -1; secondOddMax = -1;

    # First traversal for finding
    # the maximum even and odd number
    for i in range(n) :
        if (arr[i] & 1) :
            firstOddMax = max(firstOddMax, arr[i]);
        else :
            firstEvenMax = max(firstEvenMax, arr[i]);
			

    # Second traversal for finding
    # the second maximum even and
    # odd number
    for i in range(n) :
        if (arr[i] & 1) :
            if (arr[i] != firstOddMax) :
                secondOddMax = max(secondOddMax, arr[i]);

        else :
            if (arr[i] != firstEvenMax) :
                secondEvenMax = max(secondEvenMax, arr[i]);

    sumOdd = 0; sumEven = 0;

    # If two even numbers exist in array
    if (firstEvenMax != -1 and secondEvenMax != -1) :
        sumEven = firstEvenMax + secondEvenMax;

    # If two odd numbers exist in array
    if (firstOddMax != -1 and secondOddMax != -1) :
        sumOdd = firstOddMax + secondOddMax;

    res = max(sumEven, sumOdd);

    # No even sum pair found so return -1
    if (res == 0) :
        return -1;

    return res;

print("el bueno: ", maxEvenSumPair(arr,n))