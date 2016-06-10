function [C,sigma] = BusquedaTipoGrilla (MatrizCaracteristica,Etiquetas)
[MatrizCaracteristicaNormalizada,configuracionMatrizCaracteristica] = mapminmax(MatrizCaracteristica);
% MatrizCaracteristicaNormalizada =[MatrizCaracteristicaNormalizada(:,3) MatrizCaracteristicaNormalizada(:,4) MatrizCaracteristicaNormalizada(:,5)];
etiquetaNormalizada = Etiquetas;
% [etiquetaNormalizada,configuracionEtiquetas] = mapminmax(Etiquetas);
etiquetaNormalizada = etiquetaNormalizada';
c = [1e-3 1e-2 1 2 3 5 10 100 110 200 300 400 500];
g = [1e-5 1e-4 1e-3 1e-2 0.1  0.5  0.8 1  2 3 3.5 4 5 6 7 8 9 10];
[numFilas,numColumnas] = size(MatrizCaracteristicaNormalizada);
MatrizCaracteristicaEntrenamientoNormalizada = MatrizCaracteristicaNormalizada(1:2:numFilas,:);
MatrizCaracteristicaValidacionNormalizada = MatrizCaracteristicaNormalizada(2:2:numFilas,:);
etiquetaNormalizadaEntrenamiento = etiquetaNormalizada(1:2:numFilas,:);
etiquetaNormalizadaValidacion = etiquetaNormalizada(2:2:numFilas,:);

s1 = '-s';
s2 = num2str(3); %% 3 Para epsilon SVM, 4 para nu SVM
s3 = '-t';
s4 = num2str(2); %% 2 Para kernel RBF
s6 = '-p';
s7 = num2str(1)
s8 = '-c';
s10= '-h';
s11 = num2str(0);
s12 = '-g';
sEmpty = ' ';
for j = 1:length(c)
    for k = 1:length(g)
s9 = num2str(c(j));
s13 = num2str(g(k));
streamAux = horzcat(s1,sEmpty,s2,sEmpty,s3,sEmpty,s4,sEmpty,s6,sEmpty,s7,sEmpty,s8,sEmpty,s9,sEmpty,s12,sEmpty,s13,sEmpty,s10,sEmpty,s11);
model = svmtrain(etiquetaNormalizadaEntrenamiento,MatrizCaracteristicaEntrenamientoNormalizada,streamAux);
%['-s 3 -t 2 -c -p 0.001 -h 0']
[predicted_label, accuracy,prob_estimates] =svmpredict(etiquetaNormalizadaValidacion,MatrizCaracteristicaValidacionNormalizada,model);
MeanSquareError(j,k) = accuracy(2);
    end
end
valorMinMeanSquareError = (min(min(MeanSquareError)));
posicionMeanSquareError = find(MeanSquareError == valorMinMeanSquareError);
[filaMSE,columnaMSE] = ind2sub( size(MeanSquareError) , posicionMeanSquareError );
s9 = num2str(c(filaMSE(1)));
s13 = num2str(g(columnaMSE(1)));
streamAux = horzcat(s1,sEmpty,s2,sEmpty,s3,sEmpty,s4,sEmpty,s6,sEmpty,s7,sEmpty,s8,sEmpty,s9,sEmpty,s12,sEmpty,s13,sEmpty,s10,sEmpty,s11);
model = svmtrain(etiquetaNormalizadaEntrenamiento,MatrizCaracteristicaEntrenamientoNormalizada,streamAux);
[Prediccion, accuracy, dec_values] = svmpredict(etiquetaNormalizadaValidacion,MatrizCaracteristicaValidacionNormalizada,model);
errorPrediccion = sqrt(sum(abs(Prediccion - etiquetaNormalizadaValidacion)));
stem(Prediccion)
hold on
stem(etiquetaNormalizadaValidacion,'r')
Prediccionrecuperada = mapminmax('reverse',Prediccion,configuracionEtiquetas);
