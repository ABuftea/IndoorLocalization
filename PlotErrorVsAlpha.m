%% Distance Errors
% In this function we plot the variation of the error in function of the
% variation of the atennuation coeficient alpha

syms estimate;
EmitedSignal = 5000;

TheoricAlpha = -2;
ErrorsInAlpha = (0:0.01:1.5);
FixedPointX = 50; % Close: 20 y Far: 50
FixedPointY = 50; % 20 y 50
KnownPositionX = 5;
KnownPositionY = 5;
Distance = FixedPointX-KnownPositionX;

DistanceErrors = zeros(1,length(ErrorsInAlpha));

for i=1:1:length(ErrorsInAlpha)
    RealAlpha = TheoricAlpha*(1+ErrorsInAlpha(i));
    ReceivedSignal = EmitedSignal*(Distance^(RealAlpha));
    eqn = ReceivedSignal == EmitedSignal*(estimate)^(TheoricAlpha);
    EstimateDistance = double(solve(eqn, estimate));
    EstimateDistance = EstimateDistance(EstimateDistance >= 0);
    DistanceError = abs(Distance-EstimateDistance);
    DistanceErrors(i) = DistanceError;
end 


Distances = zeros(length(DistanceErrors),1);
Distances(:)= Distance;

DistanceErrorsClose = DistanceErrors;
RelativeErrorsClose = CalculateRelativeErrors(Distances, DistanceErrorsClose);

DistanceErrorsClosePlus = DistanceErrors;
RelativeErrorsClosePlus = CalculateRelativeErrors(Distances, DistanceErrorsClosePlus);


DistanceErrorsFar = DistanceErrors;
RelativeErrorsFar = CalculateRelativeErrors(Distances, DistanceErrorsFar);


DistanceErrorsFarPlus = DistanceErrors;
RelativeErrorsFarPlus = CalculateRelativeErrors(Distances, DistanceErrorsFarPlus);


plot(ErrorsInAlpha*100, DistanceErrorsClose);
hold on;
plot(ErrorsInAlpha*100, DistanceErrorsFar);
title('Error en la distancia entre emisor y receptor');
xlabel('% Error en la estimación de alpha');
ylabel('Error absoluto en la distancia, metros');
legend('Cerca','Lejos');

plot(ErrorsInAlpha(1:21)*100, DistanceErrorsClosePlus(1:21))
hold on;
plot(ErrorsInAlpha(1:21)*100, DistanceErrorsFarPlus(1:21));
title('Error en la distancia entre emisor y receptor');
xlabel('% Error en la estimación de alpha');
ylabel('Error absoluto en la distancia, metros');
legend('Cerca','Lejos', 'AutoUpdate', 'off');
plot(ErrorsInAlpha(1:21)*100, DistanceErrorsClose(1:21),'k:');
plot(ErrorsInAlpha(1:21)*100, DistanceErrorsFar(1:21),'k:');



plot(ErrorsInAlpha*100, RelativeErrorsClose);
hold on;
plot(ErrorsInAlpha*100, RelativeErrorsFar);
title('Error en la distancia entre emisor y receptor');
xlabel('% Error en la estimación de alpha');
ylabel('% Error relativo en la distancia');
legend('Cerca','Lejos');


plot(ErrorsInAlpha(1:21)*100,RelativeErrorsClosePlus(1:21));
hold on;
plot(ErrorsInAlpha(1:21)*100,RelativeErrorsFarPlus(1:21));
title('Error en la distancia entre emisor y receptor');
xlabel('% Error en la estimación de alpha');
ylabel('% Error relativo en la distancia');
legend('Cerca','Lejos','AutoUpdate','off');
plot(ErrorsInAlpha(1:21)*100,RelativeErrorsClose(1:21),'k:');
plot(ErrorsInAlpha(1:21)*100,RelativeErrorsFar(1:21),'k:');


ErrorsInAlpha(1:21)*100;
RelativeErrors(1:21)



%% Position Erros
% In this section we calculate the error in function of the position that
% the object has relative to the fixed nodes. 

syms estimate;
EmitedSignal = 5000;

TheoricAlpha = -2;
ErrorsInAlpha = (0:0.01:0.2);
FixedPointsX = [0 5 10]; % Close: [0 5 10] Far: [0 10 20]
FixedPointsY = [0 10 0]; % Close: [0 10 0] Far: [0 20 0]
KnownPositionX = 9; % Middle 5  ; Side 2   ; Corner 10 ;  Near 9  ;
KnownPositionY = 1; % Middle 5  ; Side 5  ; Corner 10 ;  Near 1   ; 

plot(FixedPointsX, FixedPointsY, 'go');
hold on;
plot(KnownPositionX, KnownPositionY, 'gx');
hold off;

Distances = GetDistancesToFixedPoints(FixedPointsX, FixedPointsY, KnownPositionX, KnownPositionY);

PositionErrors = zeros(1,length(ErrorsInAlpha));
EstimatePositionsX = zeros(1,length(ErrorsInAlpha));
EstimatePositionsY = zeros(1,length(ErrorsInAlpha));

% this loope works similary to the loops in ErrorsPerDensity
% All the commented lines are beacuse of the implementation of the
% different localization algorithms created
for i=1:1:length(ErrorsInAlpha)
    
    fprintf('Processing %d of %d.....',i,length(ErrorsInAlpha));
    RealAlpha = TheoricAlpha*(1+ErrorsInAlpha(i));
    
    ReceivedSignals = zeros(1,3);  
    for e=1:1:3
    ReceivedSignal= EmitedSignal*(Distances(e)^(RealAlpha));
    ReceivedSignals(e) = ReceivedSignal;
    end 
    
    EstimateDistances = zeros(1,3);
    for e=1:1:3
    eqn = ReceivedSignals(e) == EmitedSignal*(estimate)^(TheoricAlpha);
    EstimateDistance = double(solve(eqn, estimate));
    EstimateDistance = EstimateDistance(EstimateDistance >= 0);
    EstimateDistances(e) = EstimateDistance;
    end
    
     Circle1 = [FixedPointsX(1) FixedPointsY(1) EstimateDistances(1)];
     Circle2 = [FixedPointsX(2) FixedPointsY(2) EstimateDistances(2)];   
     Circle3 = [FixedPointsX(3) FixedPointsY(3) EstimateDistances(3)];
    
%      h=figure;
%      figure(h);
%      plot(FixedPointsX, FixedPointsY, 'go');
%      hold on;
%      plot(KnownPositionX, KnownPositionY, 'gx');
%      viscircles([Circle1(1) Circle1(2)],Circle1(3),'color','g');
%      viscircles([Circle2(1) Circle2(2)],Circle2(3),'color','g');
%      viscircles([Circle3(1) Circle3(2)],Circle3(3),'color','g');
    
    % [EstimatePositionX , EstimatePositionY] = CalculateLocalizationTheory (FixedPointsX, FixedPointsY, EstimateDistances);
    
     [EstimatePositionX, EstimatePositionY] = CalculateLocalizationMaxMin (Circle1, Circle2, Circle3);
    
    % [EstimatePositionX, EstimatePositionY] = CalculateLocalizationCentroid (Circle1, Circle2, Circle3);
    
    % [EstimatePositionX, EstimatePositionY] = CalculateLocalization (Circle1, Circle2, Circle3);
    
     % viscircles([Circle1b(1) Circle1b(2)],Circle1b(3),'color','r');
     % viscircles([Circle2b(1) Circle2b(2)],Circle2b(3),'color','r');
     % viscircles([Circle3b(1) Circle3b(2)],Circle3b(3),'color','r');
    
     % plot(EstimatePositionX,EstimatePositionY,'rx')
     % pause(0.5);
     % saveas(h,sprintf('FIG%d.png',i));  
     % hold off;
     % close(h); 
    
     EstimatePositionsX(i) = EstimatePositionX;
     EstimatePositionsY(i) = EstimatePositionY;

     PositionError = sqrt((KnownPositionX-EstimatePositionX)^2+(KnownPositionY-EstimatePositionY)^2);
     PositionErrors(i) = PositionError;
     fprintf('Done.\n');
     
end 

% Comapring Results
Center =PositionErrors;
Side = PositionErrors;
Corner = PositionErrors;
Near = PositionErrors;

plot(ErrorsInAlpha*100,Center,'b');
hold on;
plot(ErrorsInAlpha*100,Side,'r');
plot(ErrorsInAlpha*100,Corner,'g');
plot(ErrorsInAlpha*100,Near,'c');
title('Error en la posición según distribución');
xlabel('% Error en la estimación de alpha');
ylabel('Error en la distancia, metros');
legend('Centrado', 'Lateral', 'Esquina', 'Cercanía')

% Comparing Methods
ErrorsMaxMin = PositionErrors;
ErrorsCentroid = PositionErrors;
ErrorsLocalization = PositionErrors;

plot(ErrorsInAlpha*100,ErrorsMaxMin,'r');
hold on;
plot(ErrorsInAlpha*100,ErrorsCentroid,'b');
plot(ErrorsInAlpha*100,ErrorsLocalization,'g');
title('Error en la posición según método');
xlabel('% Error en la estimación de alpha');
ylabel('Error en la distancia, metros');
legend('MaxMin','Centroid','Combinación')

plot(EstimatePositionsX, EstimatePositionsY, '*');
hold on;
plot (KnownPositionX, KnownPositionY, 'o');
hold off;











