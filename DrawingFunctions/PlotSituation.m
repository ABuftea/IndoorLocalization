function PlotSituation(x_min, x_max, y_min, y_max, FirstPointsX, FirstPointsY, SecondPointsX , SecondPointsY, FirstChar, SecondChar)

plot(FirstPointsX, FirstPointsY, FirstChar);
hold on
plot(SecondPointsX, SecondPointsY, SecondChar);
hold off
axis([x_min, x_max, y_min, y_max]);



end 