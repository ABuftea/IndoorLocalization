function [RelativeErrors] = CalculateRelativeErrors (AccurateValues, ValueErrors)

        RelativeErrors = zeros(1,length(AccurateValues));
        
        for i=1:1:length(AccurateValues)
            RelativeError = (ValueErrors(i)/AccurateValues(i))*100;
            RelativeErrors(i) = RelativeError;
        end 
        
   
end 