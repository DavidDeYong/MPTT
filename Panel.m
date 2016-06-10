function I = Panel (V,Radiacion,Temp)
% Carga del Electron
q=1.602176e-19;
% Contante de Boltzman
K=1.3806488e-23;
% Constante del material
n=1.3;
% Temperatura en Kelvin
T=273.15+Temp;
% Resistencia serie
Rs=0.01;
% Resistencia Paralelo
Rp=100;
% Calculo del producto de constantes de la exponencial
Vt=(n*K*T)/q;
Ns=72; %celdas en serie.
Vc=V./Ns;
% Corriente de Fotogenerada
Isc=5.15;
Alfa=0.037/100;
%variacion de la corriente con la temperatura
Iph=Isc*Radiacion/1000*(1+(Alfa*(Temp-25)));
% Corriente inversa del diodo
Voc_ref=44.4/Ns;
Beta=-0.34/100;
Voc=Voc_ref*(1+(Beta*(Temp-25)));
%for i=1:length(Vc)
%if (Vc(i)>Voc)
%Vc(i)=Voc;
%end
%end
Io=Isc/(exp(Voc/Vt)-1);
Ir=Io;%*(T/298.15)^3*exp(((T/298.15)-1)*1.11*q/(n*K*298.15));

% Funcion a Valuar
I=zeros(size(Vc));
for i=1:50
I = I - (Iph - I - Ir .* ( exp((Vc + I .* Rs) ./ Vt) -1)+(Vc + I .* Rs)/Rp)... 
        ./ (-1 - Ir * (Rs ./ Vt) .* exp((Vc + I .* Rs) ./ Vt)-Rs/Rp); 
end
 end 
 