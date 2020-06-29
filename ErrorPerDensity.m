
%% ErrorsByDensity
% In this section we will calculate how the error at estimating the
% position disminuishes if incrementing the fixed nodes

%Initializing variables
x_min = 0;
x_max = 50;
y_min = 0;
y_max = 50;

EmittedSignal = 5000;
LossFactor = -2;

NumberOfFixedPoints = [10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200];

NumberOfTrackingPoints = 100;
minAllowableTrackingPointsDistance = 0.5;

MaxPositionsErrors = zeros(1, length(NumberOfFixedPoints));
MeanPositionsErrors = zeros(1, length(NumberOfFixedPoints));
MinPositionsErrors = zeros(1, length(NumberOfFixedPoints));

% For each ammount of fixed nodes, we will calculate the error when we
% estimate the position of 100 points
for i=1:1:length(NumberOfFixedPoints)
fprintf('Distribution with %d fixed points from %d',i*10,length(NumberOfFixedPoints)*10);
[FixedPointsX, FixedPointsY] = GenerateEquidistantPoints(x_min, x_max, y_min, y_max, NumberOfFixedPoints(i));
[TrackPointsX , TrackPointsY] = GenerateTrackingPoints(5, 45, 5, 45, FixedPointsX, FixedPointsY, NumberOfTrackingPoints, minAllowableTrackingPointsDistance);
EstimateTrackPointsX = zeros(1,length(TrackPointsX));
EstimateTrackPointsY = zeros(1,length(TrackPointsY));
    %This loop is where we calculate the error for each one of the 100
    %tracking points
    for e=1:1:length(TrackPointsX)
        fprintf('Processing position %d of %d.....',e,length(TrackPointsX));
        TrackPointX = TrackPointsX(e);
        TrackPointY = TrackPointsY(e);
        [ClosestPointsX, ClosestPointsY, ~, EstimateDistances] = GetClosestPoints (EmittedSignal,LossFactor,FixedPointsX, FixedPointsY, TrackPointX, TrackPointY);
        Circle1 = [ClosestPointsX(1) ClosestPointsY(1) EstimateDistances(1)];
        Circle2 = [ClosestPointsX(2) ClosestPointsY(2) EstimateDistances(2)];   
        Circle3 = [ClosestPointsX(3) ClosestPointsY(3) EstimateDistances(3)];
        % this is the function which we modify to experiment with different
        % localization techniques (I've created many of them)
        [EstimatePositionX, EstimatePositionY] = CalculateLocalization (Circle1, Circle2, Circle3);
        EstimateTrackPointsX(e) = EstimatePositionX;
        EstimateTrackPointsY(e) = EstimatePositionY;
        fprintf('Done.\n');
    end 
    
[MaxPositionError, MeanPositionError, MinPositionError] = CalculateErrorsPerDensity (TrackPointsX , TrackPointsY, EstimateTrackPointsX,  EstimateTrackPointsY);

MaxPositionsErrors(i) =  MaxPositionError;
MeanPositionsErrors(i) = MeanPositionError;
MinPositionsErrors(i) = MinPositionError;

end 

% Here we plot the results. 
plot(FixedPointsX, FixedPointsY, 'o')
hold on;
plot(TrackPointsX, TrackPointsY,'x')
axis([x_min, x_max, y_min, y_max]);

figure(EquidistantPlot)
plot(NumberOfFixedPoints, MaxPositionsErrors);
hold on;
plot (NumberOfFixedPoints, MeanPositionsErrors);
hold on;
plot (NumberOfFixedPoints, MinPositionsErrors);
title('Error medio según la densidad de nodos');
xlabel('Densidad de nodos en el mapa');
ylabel('Error en la posición, metros');
legend('Error Máximo','Error Medio','Error Mínimo')

% Restore data from plot
h = findobj(gca,'Type','line')
NodosFijos=get(h,'Xdata')
MediumErrors5=get(h,'Ydata')

h = findobj(gca,'Type','line')
MediumErrors10=get(h,'Ydata')

h = findobj(gca,'Type','line')
MediumErrors15=get(h,'Ydata')

h = findobj(gca,'Type','line')
MediumErrors20=get(h,'Ydata')

plot(NodosFijos,MediumErrors20,'r')
hold on;
plot(NodosFijos,MediumErrors15,'g')
plot(NodosFijos,MediumErrors10,'b')
plot(NodosFijos,MediumErrors5,'c')
title('Errores medios según la densidad de nodos');
xlabel('Densidad de nodos en el mapa');
ylabel('Error en la posición, metros');
legend('20%','15%','10%', '5%')

%% Errors Delimitation
% In this section we will calculate the range of the error in function of
% the ammount of fixed nodes, it means, between wich values does
% the error move

x_min = 0;
x_max = 20;
y_min = 0;
y_max = 20;

NumberOfFixedPoints = 30; % 8, 16, 32
EmittedSignal = 5000;
LossFactor = -2;

[FixedPointsX, FixedPointsY] = GenerateEquidistantPoints(x_min, x_max, y_min, y_max, NumberOfFixedPoints);


plot(FixedPointsX, FixedPointsY, 'o');
axis([x_min, x_max, y_min, y_max]);

MovedPlot = figure();
EquidistantPlot = figure();

x_min = 5;
x_max = 15;
y_min = 5;
y_max = 15;

NumberOfTrackingPoints = 100;
minAllowableTrackingPointsDistance = 0.5;
[TrackPointsX , TrackPointsY] = GenerateTrackingPoints(5, 15, 5, 15, FixedPointsX, FixedPointsY, NumberOfTrackingPoints, minAllowableTrackingPointsDistance);
    
EstimateTrackPointsX = zeros(1,NumberOfTrackingPoints);
EstimateTrackPointsY = zeros(1,NumberOfTrackingPoints);

plot(FixedPointsX, FixedPointsY, 'o');
hold on
plot(TrackPointsX, TrackPointsY, '.');
axis([0, 20, 0, 20]);
title('Distribución de puntos fijos y aleatorios');

hold off

    for i=1:1:length(TrackPointsX)
        fprintf('Processing %d of %d.....',i,length(TrackPointsX));
        TrackPointX = TrackPointsX(i);
        TrackPointY = TrackPointsY(i);
        [ClosestPointsX, ClosestPointsY, ~, EstimateDistances] = GetClosestPoints (EmittedSignal,LossFactor,FixedPointsX, FixedPointsY, TrackPointX, TrackPointY);
        Circle1 = [ClosestPointsX(1) ClosestPointsY(1) EstimateDistances(1)];
        Circle2 = [ClosestPointsX(2) ClosestPointsY(2) EstimateDistances(2)];   
        Circle3 = [ClosestPointsX(3) ClosestPointsY(3) EstimateDistances(3)];
        [EstimatePositionX, EstimatePositionY] = CalculateLocalization(Circle1, Circle2, Circle3);
        EstimateTrackPointsX(i) = EstimatePositionX;
        EstimateTrackPointsY(i) = EstimatePositionY;
        fprintf('Done.\n');
    end 
   
 % Calculating the errors and the mean value by each ammount of fixed
 % points
PositionErrors20 = CalculatePositionErrors(TrackPointsX, TrackPointsY, EstimateTrackPointsX, EstimateTrackPointsY);
MeanErrors20 = mean(PositionErrors20);
MeanErrors20 = repelem(MeanErrors20, length(PositionErrors20));   

PositionErrors15 = CalculatePositionErrors(TrackPointsX, TrackPointsY, EstimateTrackPointsX, EstimateTrackPointsY);
MeanErrors15 = mean(PositionErrors15);
MeanErrors15 = repelem(MeanErrors15, length(PositionErrors15));   

PositionErrors10 = CalculatePositionErrors(TrackPointsX, TrackPointsY, EstimateTrackPointsX, EstimateTrackPointsY);
MeanErrors10 = mean(PositionErrors10);
MeanErrors10 = repelem(MeanErrors10, length(PositionErrors10));   

PositionErrors5 = CalculatePositionErrors(TrackPointsX, TrackPointsY, EstimateTrackPointsX, EstimateTrackPointsY);
MeanErrors5 = mean(PositionErrors5);
MeanErrors5 = repelem(MeanErrors5, length(PositionErrors5));   


%Ploting the results

figure(EquidistantPlot)

plot((1:1:NumberOfTrackingPoints), PositionErrors20,'b');
hold on;
plot((1:1:NumberOfTrackingPoints), PositionErrors15,'r');
plot((1:1:NumberOfTrackingPoints), PositionErrors10,'g');
plot((1:1:NumberOfTrackingPoints), PositionErrors5,'c');
legend('20%','15%','10%','5%','AutoUpdate', 'off')
plot((1:1:NumberOfTrackingPoints), MeanErrors20,'b');
plot((1:1:NumberOfTrackingPoints), MeanErrors15,'r');
plot((1:1:NumberOfTrackingPoints), MeanErrors10,'g');
plot((1:1:NumberOfTrackingPoints), MeanErrors5,'c');

title('Errores al estimar la posición');
xlabel('Número del experimento');
ylabel('Error en la posición, metros');


figure(MovedPlot)
plot((1:1:NumberOfTrackingPoints), PositionErrors);




%% Errors By Separation
% in this section we represent the variation of the error in fuction of the
% minimum distance we allow between fixed nodes. 


NumberOfFixedPoints = 50;
minAllowableFixedPointsDistance = [1 2 3 3.9 5];
NumberOfTrackingPoints = 100;
minAllowableTrackingPointsDistance = 1;

MaxPositionsErrors = [];
MeanPositionsErrors = [];
MinPositionsErrors = [];

for i=1:1:length(minAllowableFixedPointsDistance)
[MaxPositionError, MeanPositionError, MinPositionError] = CalculateErrorsPerDensity (NumberOfFixedPoints, minAllowableFixedPointsDistance(i), NumberOfTrackingPoints, minAllowableTrackingPointsDistance);

MaxPositionsErrors = [MaxPositionsErrors MaxPositionError];
MeanPositionsErrors = [MeanPositionsErrors MeanPositionError];
MinPositionsErrors = [MinPositionsErrors MinPositionError];

end

plot(NumberOfFixedPoints, MaxPositionsErrors);
hold on;
plot (NumberOfFixedPoints, MeanPositionsErrors);
hold on;
plot (NumberOfFixedPoints, MinPositionsErrors);


