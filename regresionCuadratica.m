function [] = regresionCuadratica()
format long
x = [0:0.1:5];
x1 = [0.01:0.1:5 + 0.01];
ruido = 0.1*randn(1,length(x));
y = x.^3;
y1 = x1.^3;
yruido = y + ruido;
y1ruido = y1 + ruido;
[yruidonormalizado,configuracion] = mapminmax(yruido);
[ynormalizado,configuracion2] = mapminmax(y);
[y1normalizado,configuracion3] = mapminmax(y1);
c = [1e-3 1e-2 1 2 3 5 10 100 110 200 300 400 500];
g = [1e-5 1e-4 1e-3 1e-2 0.1  0.5  0.8 1  2 3 3.5 4 5 6 7 8 9 10];
s1 = '-s';
s2 = num2str(3); %% 3 Para epsilon SVM, 4 para nu SVM
s3 = '-t';
s4 = num2str(2); %% 2 Para kernel RBF
s6 = '-p';
s7 = num2str(0.0001)
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
model = svmtrain(ynormalizado',x',streamAux);
%['-s 3 -t 2 -c -p 0.001 -h 0']
[predicted_label, accuracy,prob_estimates] =svmpredict(ynormalizado',x',model);
MeanSquareError(j,k) = accuracy(2);
    end
end

valorMinMeanSquareError = (min(min(MeanSquareError)));
posicionMeanSquareError = find(MeanSquareError == valorMinMeanSquareError);
[filaMSE,columnaMSE] = ind2sub( size(MeanSquareError) , posicionMeanSquareError );

s9 = num2str(c(filaMSE(1)));
s13 = num2str(g(columnaMSE(1)));

streamAux = horzcat(s1,sEmpty,s2,sEmpty,s3,sEmpty,s4,sEmpty,s6,sEmpty,s7,sEmpty,s8,sEmpty,s9,sEmpty,s12,sEmpty,s13,sEmpty,s10,sEmpty,s11);
model = svmtrain(ynormalizado',x',streamAux);

[Prediccion, accuracy, dec_values] = svmpredict(y1normalizado', x1',model);
errorPrediccion = sqrt(sum(abs(Prediccion - y1normalizado')));
Prediccionrecuperada = mapminmax('reverse',Prediccion,configuracion2);
 error = sqrt(sum(abs(y1normalizado - Prediccion')))
 errorRecuperado = sqrt(sum(abs(y1 - Prediccionrecuperada')))
 
stem(x,predicted_label,'o')
hold on
stem(x,ynormalizado,'k','*')
% stem(x,yruidonormalizado,'g','^')
figure
stem(x1,y1normalizado,'k','*')
hold on
stem(x1,Prediccion,'g','^')
figure
stem(x1,y1)
hold on
stem(x1,Prediccionrecuperada,'r')


