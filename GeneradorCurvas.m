function [Pmax,Vmax,Imax,perfilCorriente,perfilTension,perfilPotencia] = GeneradorCurvas ()
% close all
% clear all
% clc
Paso=1e-3;
%Radiacion = [1000 900 800 700 600 500 400 300 200 100 0];
Radiacion = [950:-10:10];
Temperatura = [30];
Iaux=1;
Vaux=0;
fila = 1;
indiceV5 = 0.5/Paso + 1;
indiceV15 = 1.5/Paso + 1;
indiceV25 = 2.5/Paso + 1;
indiceV30 = 3.0/Paso + 1;
indiceV35 = 3.5/Paso + 1;
indiceV40 = 4/Paso + 1;
for i = 1:length(Radiacion)
    for j = 1:length(Temperatura)
while(Iaux>0)
Iaux=Panel(Vaux,Radiacion(i),Temperatura(j));
Vaux=Vaux+Paso;
end
V1=0:0.01:Vaux;
I(fila,:)=Panel(V1,Radiacion(i),Temperatura(j));
P(fila,:)=V1.*I(fila,:);
%% Identificación del punto de máxima potencia
Pmax(fila) = max(P(fila,:));
IndiceVmax(fila) = find(P(fila,:) == Pmax(fila));
Vmax(1,fila) = V1(1,IndiceVmax(fila));
Imax(1,fila) = I(fila,IndiceVmax(fila));
%% Graficos
subplot(1,2,1)
grid on;
hold on;
plot(V1,I(fila,:),'b') % dibuja la curva en rojo para los 25ÂºC
stem(Vmax,Imax,'*','r','LineStyle','none')
subplot(1,2,2)
grid on;
hold on;
plot(V1,P(fila,:),'b') % dibuja la curva de potencia para 25Âª
stem(Vmax,Pmax,'*','r','LineStyle','none')
hold off;
%% Extracción de valores
I5 = I(indiceV5);
I15 = I(indiceV15);
I25 = I(indiceV25);
I30 = I(indiceV30);
I35 = I(indiceV35);
I40 = I(indiceV40);
V5 = V1(indiceV5);
V15 = V1(indiceV15);
V25 = V1(indiceV25);
V30 = V1(indiceV30);
V35 = V1(indiceV35);
V40 = V1(indiceV40);
perfilCorriente(fila,:) = [I5 I15 I25 I30 I35 I40];
perfilTension(fila,:) = [V5 V15 V25 V30 V35 V40];
perfilPotencia(fila,:) = [I5*V5 I15*V15 I25*V25 I30*V30 I35*V35 I40*V40];
fila = fila + 1;

end
Iaux = -1;
end
end
