clear all;
clc;
close all;

f = @(p) sqrt(1 - exp(-p.^2));
N = 1000;
r = linspace(0, 2, N);
phi = zeros(1, N);

for i = 1:N
    phi(i) = MonteCarlo(f, 0, sqrt(2) * r(i), N * 50);
end

figure(1)
plot(r, phi)
title('Phi vs radio')
xlabel("radio")
ylabel("Phi(r)")

function result = MonteCarlo(f, xmin, xmax, n)
    x = linspace(xmin, xmax, 1000);
    ymax = max(f(x));
    ymin = min(f(x));

    % Ajuste de Limites para funciones mayores, menores o cruzanets con 0
    if ymax > 0 && ymin > 0
        ymin = 0;
    elseif ymax < 0 && ymin < 0
        ymax = 0;
    end

    % Randomizacion de Puntos
    p = zeros(n, 2);
    p(:, 1) = xmin + (xmax - xmin) .* rand(n, 1);
    p(:, 2) = ymin + (ymax - ymin) .* rand(n, 1);

    % For de contador de puntos
    vCount = 0;
    for i = 1:n
        if p(i, 2) > 0 && p(i, 2) < f(p(i, 1))
            vCount = vCount + 1;
        elseif p(i, 2) < 0 && p(i, 2) > f(p(i, 1))
            vCount = vCount - 1;
        end
    end

    % Imprime resultado
    result = (vCount / n) * ((abs(xmax - xmin)) * abs(ymax - ymin));

end
