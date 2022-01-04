fileContent = open('data.txt', 'r');

line = fileContent.readline();
x = [];
y = [];
z = [];

while line != '':
    count = 0;
    vals = line[1:-2].split(',');
    for i in range(len(vals)):
        temp = float(vals[i]);
        if(count == 0):
            x.append(temp);
        if(count == 1):
            y.append(temp);
        if(count == 2):
            z.append(temp);
        count = count + 1;
    line = fileContent.readline();


print('x = ', end='')
print(x, end='')
print(';')

print('y = ', end='')
print(y, end='')
print(';')

print('z = ', end='')
print(z, end='')
print(';')
