person = 8

# Placeholder array for person
a = [0] * person

# Assign placeholders from 1 to N (total person)
for i in range(person):
	a[i] = i + 1
	
# Will start the game from 1st person (Which
# is at placeholder 0)
pos = 0

# Game will be continued till we end up with
# only one person left
while (len(a) > 1):
	
	# Current person will shoot the person next
	# to him/her. So incrementing the position.
	pos += 1
	
	# As person are standing in circular manner,
	# for person at last place has right neighbour
	# at placeholder 0. So we are taking modulo
	# to make it circular
	
	pos %= len(a)
	print("pos", pos)
	
	# Killing the person at placeholder 'pos'
	# To do that we simply remove that element
	print("se elimino a", a[pos])
	del a[pos]
	
	# There is no need to increment the pos again to
	# pass the gun Because by erasing the element at
	# 'pos', now next person will be at 'pos'.

# Driver code

# PrPerson that survive the game
print(a[0])

# This code is contributed by ShubhamSingh10
