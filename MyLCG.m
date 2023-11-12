% Función para generar números aleatorios usando el Generador Lineal Congruencial
function numerosAleatorios = MyLCG(semilla, n)
    % Parámetros del LCG
    a = 7^5;
    c = 7^3;
    m = 2^31 - 1;
    
    % Inicialización con la semilla
    X_n = semilla;
    
    % Genera n números aleatorios entre 0 y 1
    numerosAleatorios = zeros(1, n);
    for i = 1:n
        X_n = mod(a * X_n + c, m);
        numerosAleatorios(i) = X_n / m;
    end
end