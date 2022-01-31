clc;
clear all;

x = [];
y = [];
z = [];

zNormal = z;
x = [x;max(x);max(x);min(x);min(x)];
y = [y;max(y);min(y);max(y);min(y)];
z = [z;0;0;0;0];

y = y * -1;
xlin = linspace(min(x),max(x),33);
ylin = linspace(min(y),max(y),33);

[xmesh,ymesh] = meshgrid(xlin,ylin);

f = scatteredInterpolant(x,y,z);
zmesh = f(xmesh,ymesh);

figure
mesh(xmesh,ymesh,zmesh) %mesh / surf, add V for color based on V
axis tight; hold on
plot3(x,y,z,'.','Marker','none','LineStyle','none') %nonuniform
zlim([min(zNormal) - 20 max(zNormal) + 20])
title('GRAPH TITLE');
xlabel('X-Label');
ylabel('Y-Label');
zlabel('Z-Label');
caxis([min(zNormal) max(zNormal)]) %change for V
colorbar

minimumLat = min(x) % min lat
maximumLat = max(x) % max lat
%0.41 mi Lat

minimumLong = min(y) % min long
maximumLong = max(y) % max long
%0.52 mi Long

numPoints = numel(x);
X = [];
Y = [];

for num = 1:numPoints
    dx = getDistance(x(num), minimumLong, minimumLat, minimumLong);
    dy = getDistance(minimumLat, y(num), minimumLat, minimumLong);
    X = [X;dx];
    Y = [Y;dy];
end

Z = z;
Xlin = linspace(min(X),max(X),33);
Ylin = linspace(min(Y),max(Y),33);

[Xmesh,Ymesh] = meshgrid(Xlin,Ylin);

f = scatteredInterpolant(X,Y,Z);
Zmesh = f(Xmesh,Ymesh);

figure
plot = mesh(Xmesh,Ymesh,Zmesh) %mesh / surf, add V for color based on V
axis tight; hold on
plot3(X,Y,Z,'.','Marker','none','LineStyle','none') %nonuniform
zlim([min(zNormal) - 20 max(zNormal) + 20])
title('GRAPH TITLE');
xlabel('X-Label');
ylabel('Y-Label');
zlabel('Z-Label');
caxis([min(zNormal) max(zNormal)]) %change for V
colorbar

%rotateSurf()

function x = rotateSurf()
    for AZ = 0:1:360
        view(AZ, 30);
        pause(0.15);
    end
end

function d = getDistance(lat, long, minLat, minLong)
    R = 6371e3; % meters
    phi1 = minLat * pi / 180; % phi, lambda in radians
    phi2 = lat * pi / 180;
    deltaPhi = (lat - minLat) * pi / 180;
    deltaLambda = (long - minLong) * pi / 180;

    a = sin(deltaPhi / 2) * sin(deltaPhi / 2)+ cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
    c = 2 * atan(sqrt(a) / sqrt(1 - a));

    d = R * c; % in metres
end
