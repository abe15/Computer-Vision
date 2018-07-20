
%read the 3 images i chose and convert them to binaryimages
%along with getting there connected components
E = imread('lego.jpg');
E = otsu(E);
B_E = connected_components(E);

F = imread('pencil.png');
F = otsu(F);
B_F = connected_components(F);


G = imread('top.jpg');
G = otsu(G);
B_G = connected_components(G);

%get x bars

M00_E = moment(E,0,0,1);
M00_F = moment(F,0,0,1);
M00_G =  moment(G,0,0,1);

M10_E= moment(E,1,0,1);
M10_F =moment(F,1,0,1);
M10_G= moment(G,1,0,1);


M01_E =  moment(E,0,1,1);
M01_F =  moment(F,0,1,1);
M01_G = moment(G,0,1,1);


xBar_E = M10_E/M00_E;
xBar_F = M10_F/M00_F;
xBar_G = M10_G/M00_G;

yBar_E = M01_E/M00_E;
yBar_F = M01_F/M00_F;
yBar_G = M01_G/M00_G;


u20_E = central_moment(E,2,0,1);
u20_F = central_moment(F,2,0,1);
u20_G = central_moment(G,2,0,1);

u11_E = central_moment(E,1,1,1);
u11_F = central_moment(F,1,1,1);
u11_G = central_moment(G,1,1,1);


u02_E = central_moment(E,0,2,1);
u02_F = central_moment(F,0,2,1);
u02_G = central_moment(G,0,2,1);

%Second moment matrices

S_E = [u20_E,u11_E;u11_E,u02_E];
S_F = [u20_F,u11_F;u11_F,u02_F];
S_G = [u20_G,u11_G;u11_G,u02_G];

[V_E, D_E] = eig(S_E);
[V_F,D_F] = eig(S_F);
[V_G,D_G] = eig(S_G);

imagesc(B_E);
hold on;
quiver(xBar_E,yBar_E,V_E(1,1),V_E(2,1),90,'LineWidth',3);
quiver(xBar_E,yBar_E,V_E(1,2),V_E(2,2),90,'LineWidth',3);
hold off;
figure;

imagesc(B_F);
hold on;
quiver(xBar_F,yBar_F,V_F(1,1),V_F(2,1),90,'LineWidth',3);
quiver(xBar_F,yBar_F,V_F(1,2),V_F(2,2),90,'LineWidth',3);
hold off;
figure;


imagesc(B_G);
hold on;
quiver(xBar_G,yBar_G,V_G(1,1),V_G(2,1),90,'LineWidth',3);
quiver(xBar_G,yBar_G,V_G(1,2),V_G(2,2),90,'LineWidth',3);
hold off;




















