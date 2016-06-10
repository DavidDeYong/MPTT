function [parametrosRed,tr] = TrainingBackpropagation(vectorCaracteristicoEntrenamiento,...
    target)

neuronasCapaOculta1 = 100;
neuronasCapaOculta2 = 200;
tazaAprendizajeMaxima = 0.001;
epocasMaxima = 1000;
errorMaximo = 1e-5;

Objetivo = target';

% Creacion de la red 
net = feedforwardnet([neuronasCapaOculta1 neuronasCapaOculta2]);

%Se pueden dejar los parámetros de entrenamiento por defecto o fijarlos

net.trainParam.show = 250; 
net.trainParam.lr =tazaAprendizajeMaxima; 
net.trainParam.epochs = epocasMaxima;
net.trainParam.goal = errorMaximo;
net.trainParam.max_fail = 1000;
net.trainParam.showCommandLine = true;
net.trainParam.showWindow = false;
% Entrenamiento

[parametrosRed,tr] = trainlm(net,vectorCaracteristicoEntrenamiento',Objetivo');


