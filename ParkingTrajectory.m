%Here we will simulate two vehicles entering into the garage and going to
%their parking slot. We will track their position to see how it works.

%% Defining Paths
% manually defining the vehicle trajectory
% First Path
x1=[39.5:-1:5.5]; y1=[7]; y1=repelem(y1,length(x1));
y2=[7:1:22]; x2=[5.5]; x2=repelem(x2,length(y2));
x3=[5.5:1:84.5]; y3=[22]; y3=repelem(y3, length(x3));
y4=[22:-1:9]; x4=[84.5]; x4 = repelem(x4,length(y4));
x5=[84.5:-1:70.5]; y5=[9]; y5=repelem(y5,length(x5));
y6=[9:-1:4]; x6=[70.5]; x6=repelem(x6, length(y6));
FirstTrajectoryX=[x1 x2 x3 x4 x5 x6];
FirstTrajectoryY=[y1 y2 y3 y4 y5 y6];

% Second Path
x1=[40:-1:2]; y1=[10]; y1=repelem(y1, length(x1));
y2=[10:1:23]; y2=[y2 23.5]; x2=[2]; x2=repelem(x2, length(y2));
x3=[2:1:58]; y3=[23.5]; y3=repelem(y3, length(x3));
y4=[23.5:-1:18.5]; x4=[58]; x4=repelem(x4, length(y4));
SecondTrajectoryX=[x1 x2 x3 x4];
SecondTrajectoryY=[y1 y2 y3 y4];

%% Defining Measures and variables
x_min = 0;
x_max = 90;
y_min = 0;
y_max = 30;

% EmitterPower
EmittedSignal = 5000;

% Emitter Loss Factor
LossFactor = -2;

% Fixed nodes in Parking
NumberOfFixedPoints = 108; % 54 108 162
[FixedPointsX, FixedPointsY] = GenerateEquidistantPoints(x_min, x_max, y_min, y_max, NumberOfFixedPoints);

ErrorsTrajectory = figure;
ResultsPlot = figure;

figure(ResultsPlot);
parking = imread('ParkingScheme.png');
image([x_min x_max], [y_min y_max], parking);
hold on
plot(FixedPointsX, FixedPointsY,'o');
plot(FirstTrajectoryX, FirstTrajectoryY, 'r.-');
plot(SecondTrajectoryX, SecondTrajectoryY, 'g.-');



%% Performing Localization
TrajectoryX =  SecondTrajectoryX; %SecondTrajectoryX  FirstTrajectoryX
TrajectoryY = SecondTrajectoryY; %SecondTrajectoryY  FirstTrajectoryY

EstimateTrajectoryX = zeros(1, length(TrajectoryX));
EstimateTrajectoryY = zeros(1, length(TrajectoryY));

for i=1:1:length(TrajectoryX)
fprintf('Processing %d of %d.....',i,length(TrajectoryX));
TrackPointX = TrajectoryX(i);
TrackPointY = TrajectoryY(i);
[ClosestPointsX, ClosestPointsY, ~, EstimateDistances] = GetClosestPoints (EmittedSignal,LossFactor,FixedPointsX, FixedPointsY, TrackPointX, TrackPointY);

% [EstimatePositionX , EstimatePositionY] = CalculateLocalizationTheory (ClosestPointsX, ClosestPointsY, EstimateDistances);

Circle1 = [ClosestPointsX(1) ClosestPointsY(1) EstimateDistances(1)];
Circle2 = [ClosestPointsX(2) ClosestPointsY(2) EstimateDistances(2)];   
Circle3 = [ClosestPointsX(3) ClosestPointsY(3) EstimateDistances(3)];

[EstimatePositionX, EstimatePositionY] = CalculateLocalization (Circle1, Circle2, Circle3);
    
EstimateTrajectoryX(i) = EstimatePositionX;
EstimateTrajectoryY(i) = EstimatePositionY;
fprintf('Done.\n');
end 

PositionErrorsA = CalculatePositionErrors(TrajectoryX, TrajectoryY, EstimateTrajectoryX, EstimateTrajectoryY) ;
MediumErrorA = mean(PositionErrorsA);
MediumErrorA = repelem(MediumErrorA, length(PositionErrorsA));
XAxisLengthA = (1:1:length(EstimateTrajectoryX));

PositionErrorsB = CalculatePositionErrors(TrajectoryX, TrajectoryY, EstimateTrajectoryX, EstimateTrajectoryY) ;
MediumErrorB = mean(PositionErrorsB);
MediumErrorB = repelem(MediumErrorB, length(PositionErrorsB));
XAxisLengthB = (1:1:length(EstimateTrajectoryX));

%% Plotting results

figure(ResultsPlot);
hold on;
plot(EstimateTrajectoryX, EstimateTrajectoryY,'r*:'); % 'LineWidth' , 5
title('Estimación de las trayectorias');
xlabel('Dimensiones en metros');
ylabel('Dimensiones en metros');
legend('Nodos Fijos', 'Trayectoria A', 'Trayectoria B', 'Estimación A', 'Estimación B');


figure(ErrorsTrajectory);
hold on;
plot(XAxisLengthA, PositionErrorsA,'r');
plot(XAxisLengthB, PositionErrorsB,'g');
legend('Estimación A','Estimación B', 'AutoUpdate', 'off');
plot(XAxisLengthA, MediumErrorA, 'r')
plot(XAxisLengthB, MediumErrorB, 'g')
title('Errores cometidos al estimar las trayectorias');
xlabel('Número de muestra');
ylabel('Error absoluto en metros');


%% Things Not Used

comet(TrajectoryX, TrajectoryY);
comet(EstimateTrajectoryX, EstimateTrajectoryY);


figure ;
parking = imread('ParkingScheme.png');
image([x_min x_max], [y_min y_max], parking);
hold on
plot(FixedPointsX, FixedPointsY,'o');




