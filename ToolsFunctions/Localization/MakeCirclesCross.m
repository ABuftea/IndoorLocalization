function [Circle1, Circle2, Circle3] = MakeCirclesCross (Circle1, Circle2, Circle3)

[Xcross12,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
[Xcross13,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
[Xcross23,~] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));
increment = 0.01;

    while ( (isnan(Xcross12(1)) && isnan(Xcross12(2))) || (isnan(Xcross13(1)) && isnan(Xcross13(2))) || (isnan(Xcross23(1)) && isnan(Xcross23(2))) )
    
        % None of them ; inrement the smaller
        if ( (isnan(Xcross12(1)) && isnan(Xcross12(2))) && (isnan(Xcross13(1)) && isnan(Xcross13(2))) && (isnan(Xcross23(1)) && isnan(Xcross23(2))) )

            while( (isnan(Xcross12(1)) && isnan(Xcross12(2))) && (isnan(Xcross13(1)) && isnan(Xcross13(2))) && (isnan(Xcross23(1)) && isnan(Xcross23(2))) )
                CircleRadios = [Circle1(3) Circle2(3) Circle3(3)];
                [~,SmallerCircle] = min(CircleRadios);
                    switch SmallerCircle
                        case 1
                            Circle1(3) = Circle1(3)+increment;
                        case 2
                            Circle2(3) = Circle2(3)+increment;
                        case 3
                            Circle3(3) = Circle3(3)+increment;
                    end
                [Xcross12,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
                [Xcross13,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
                [Xcross23,~] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));
            end

         % 1-2 and 1-3  ; 2-3 yes ; increment 1
        elseif ( (isnan(Xcross12(1)) && isnan(Xcross12(2))) && (isnan(Xcross13(1)) && isnan(Xcross13(2))) )

            while( (isnan(Xcross12(1)) && isnan(Xcross12(2))) && (isnan(Xcross13(1)) && isnan(Xcross13(2))) )
                Circle1(3) = Circle1(3)+increment; 
                [Xcross12,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
                [Xcross13,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
            end 

         % 1-2 and 2-3   ; 1-3 yes ; increment 2
        elseif ( (isnan(Xcross12(1)) && isnan(Xcross12(2))) && (isnan(Xcross23(1)) && isnan(Xcross23(2))) )

           while( (isnan(Xcross12(1)) && isnan(Xcross12(2))) && (isnan(Xcross23(1)) && isnan(Xcross23(2))) )
            Circle2(3) = Circle2(3)+increment;
            [Xcross12,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
            [Xcross23,~] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));
           end

         % 1-3 and 2-3  ; 1-2 yes ; increment 3
        elseif( (isnan(Xcross13(1)) && isnan(Xcross13(2))) && (isnan(Xcross23(1)) && isnan(Xcross23(2))) )

            while ( (isnan(Xcross13(1)) && isnan(Xcross13(2))) && (isnan(Xcross23(1)) && isnan(Xcross23(2))) )
            Circle3(3) = Circle3(3)+increment;
            [Xcross13,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
            [Xcross23,~] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));
            end 

         % 1-2   
        elseif ( (isnan(Xcross12(1)) && isnan(Xcross12(2))) )

            while( (isnan(Xcross12(1)) && isnan(Xcross12(2))) )
                CircleRadios = [Circle1(3) Circle2(3)];
                [~,SmallerCircle] = min(CircleRadios);

                switch SmallerCircle
                    case 1
                     Circle1(3) = Circle1(3)+increment;   
                    case 2
                     Circle2(3) = Circle2(3)+increment;
                end

                [Xcross12,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));

            end 

         % 1-3  
        elseif ( (isnan(Xcross13(1)) && isnan(Xcross13(2))) )    

            while ( (isnan(Xcross13(1)) && isnan(Xcross13(2))) )
                CircleRadios = [Circle1(3) Circle3(3)];
                [~,SmallerCircle] = min(CircleRadios);

                switch SmallerCircle
                    case 1
                     Circle1(3) = Circle1(3)+increment;   
                    case 2
                     Circle3(3) = Circle3(3)+increment;
                end

                [Xcross13,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));

            end

         % 2-3   
        elseif ( (isnan(Xcross23(1)) && isnan(Xcross23(2))) ) 

            while ( (isnan(Xcross23(1)) && isnan(Xcross23(2))) )
                CircleRadios = [Circle2(3) Circle3(3)];
                [~,SmallerCircle] = min(CircleRadios);

                switch SmallerCircle
                    case 1
                     Circle2(3) = Circle2(3)+increment;   
                    case 2
                     Circle3(3) = Circle3(3)+increment;
                end

                [Xcross23,~] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));

            end 

        end 
        [Xcross12,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle2(1),Circle2(2),Circle2(3));
        [Xcross13,~] = circcirc(Circle1(1),Circle1(2),Circle1(3),Circle3(1),Circle3(2),Circle3(3));
        [Xcross23,~] = circcirc(Circle2(1),Circle2(2),Circle2(3),Circle3(1),Circle3(2),Circle3(3));
    end
end 