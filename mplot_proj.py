from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
from scipy.interpolate import griddata


fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Grab some test data.
fileContent = open('data.txt', 'r');

line = fileContent.readline();
x = [];
y = [];
z = [];
count = 0;

while line != '':
    
    vals = line[1:-2].split(';');
    for i in range(len(vals)):
        temp = [];
        if(count == 0):
            temp.append(float(vals[i]));
            x.append(temp);
        if(count == 1):
            temp.append(float(vals[i]) * -1);
            y.append(temp);
        if(count == 2):
            temp.append(float(vals[i]));
            z.append(temp);
    count = count + 1;
    line = fileContent.readline();

x = np.array(x)
y = np.array(y)
z = np.array(z)

def f(x,y):
    return griddata(x,y,z)

xlin = np.arange(min(x),max(x),33);
ylin = np.arange(min(y),max(y),33);

xmesh,ymesh = np.meshgrid(xlin,ylin);
zmesh = f(xmesh,ymesh);

# Plot a basic wireframe.
ax.plot_wireframe(x, y, z, rstride=10, cstride=10)

plt.show()
