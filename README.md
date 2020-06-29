# IndoorLocalization
Indoor localization techniques with RSSI lecture for wireless systems 

This is my bachelors final thesis. 
The code is divided in three parts, that is the reason you can see three .m files on the main folder. 
Each file respresents one part of the project. 

First PlotErrorVsAlpha
This file is the first simulation of the project which consits of plotting the error committed at estimating the position of an object, based on how bad we predict the attenuation of the signal through the space. 
Using this scrip I ploted the meters of deviation between the real location and the estimated location versus the % mistake at alpha

Second ErrosVsDensity
This file is the second simulation of the project and it consists of plotting the errors commited at estimating the position of the object based on how many fixed reference points we have in the area

Third ParkingTrajectory
This third and lats simulaton file is where I create the parking environment and I implement the simuation of two cars traking inside a parking using the localization technique that outputed the best resul in previous simulations and analisis.
