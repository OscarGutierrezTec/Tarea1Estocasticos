% Configuración inicial
clear;
clc;
close all;

% Parámetros
w0 = 0.5;
xmax = 2 * w0;
pt = 512;
N = 500;
a = 0.1 * w0;  % Radio de la región circular
kx = 20;
ll = 1;
A = 1;

% Generación de datos aleatorios
x = linspace(-xmax, xmax * (pt - 2) / pt, pt);
ran = 1:N;
[X, Y, ~] = meshgrid(x, x, ran);
rr = a * sqrt(rand(1, 1, N));
ph = 2 * pi * rand(1, 1, N);
xj = rr .* cos(ph);
yj = rr .* sin(ph);

% Función del campo (Vortex)
Vx = @(X, Y, w0, ll) (A/w0^ll) * ((X.^2 + Y.^2).^abs(ll)) .* exp(-(X.^2 + Y.^2) / (w0^2)) .* exp(1i * ll * atan2(Y, X));

% Cálculos
tic;
UU = Vx(X - xj, Y - yj, w0, ll);
UUr = Vx(-X - xj, -Y - yj, w0, ll);
Imean = mean(abs(UU).^2, 3);
CCDmean = mean(real(UU .* conj(UUr)), 3);
toc;

% Visualización de resultados
figure(1);
imagesc(Imean);
axis equal;
colormap jet;
colorbar;
xlabel('$x$', 'Interpreter', 'latex');
ylabel('$y$', 'Interpreter', 'latex');
title('Intensidad: $\left| \langle I\left(\vec{r}\right)\rangle\right|$, $l=1$, $a=\frac{1}{20}$', 'Interpreter', 'latex');

figure(2);
imagesc(abs(CCDmean).^(0.5));
title('Correlaci\''on cruzada: $\left| \langle \chi \left(\vec{r}\right)\rangle\right|$, $l=1$, $a=\frac{1}{20}$', 'Interpreter', 'latex');
axis equal;
colormap jet;
colorbar;
xlabel('$x$', 'Interpreter', 'latex');
ylabel('$y$', 'Interpreter', 'latex');
