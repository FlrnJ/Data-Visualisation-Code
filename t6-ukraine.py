import random
x_list = []
for i in range(92):
    x_list.append('x')

y_list = []
for i in range(100):
    x_list.append('y')

X_list = []
for i in range(995):
    x_list.append('X')

Y_list = []
for i in range(1529):
    x_list.append('Y')

O_list = []
for i in range(1315):
    x_list.append('?')

list = x_list + y_list + X_list + Y_list + O_list

random.shuffle(list)
print(*list, sep = " ")