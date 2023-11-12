% Limpieza y configuración inicial
clc; clear; close all;

% Configuración de parámetros
semilla = 470211272;   % Semilla
n = 1000;   % Número de números aleatorios

% Generación de números aleatorios con LCG (Generador Lineal Congruencial)
numerosAleatoriosLCG = MyLCG(semilla, n);

% Generación de números aleatorios con el comando rand
numerosAleatoriosRand = rand(1, n);

% Parámetros de la distribución gamma
alfa = 3;
beta = 1/2;

% Cálculo de la inversa de la función de distribución acumulativa (CDF) usando rand
iFx_rand = gaminv(numerosAleatoriosRand, alfa, beta);

% Cálculo de la inversa de la función de distribución acumulativa (CDF) usando LCG
iFx_LCG = gaminv(numerosAleatoriosLCG, alfa, beta);

% Configuración para el histograma
numBins = 100;
x = linspace(0, 8, n);
pdfGamma = gampdf(x, alfa, beta); % Función de densidad de probabilidad (PDF)

% Cálculo de la media y la desviación estándar
media_iFx_rand = mean(iFx_rand);
desviacion_estandar_iFx_rand = std(iFx_rand);
media_iFx_LCG = mean(iFx_LCG);
desviacion_estandar_iFx_LCG = std(iFx_LCG);

% Histograma 1
figure(1);
subplot(1,2,1)
histogram(iFx_rand, numBins, 'Normalization', 'pdf');
hold on
plot(x, pdfGamma, 'r', 'LineWidth', 1.5)
grid on
title('Histograma con comando rand(1,n)','Interpreter','latex');

% Histograma 2
subplot(1,2,2)
histogram(iFx_LCG, numBins, 'Normalization', 'pdf');
hold on
plot(x, pdfGamma, 'r', 'LineWidth', 1.5)
grid on
title('Histograma con LCG','Interpreter','latex');

fprintf('Media (Transformada Inversa): %.4f\n', media_iFx_LCG);
fprintf('Desviación Estándar (Transformada Inversa): %.4f\n', desviacion_estandar_iFx_LCG);
fprintf('Media (Funciones de MATLAB): %.4f\n', media_iFx_rand);
fprintf('Desviación Estándar (Funciones de MATLAB): %.4f\n', desviacion_estandar_iFx_rand);