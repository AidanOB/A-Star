function r=AnalyzeChild(iy,ix,costProposed,Parent)
    global MapOG; %Convert this into a proper variable later on.
    r = 0;
    
    %Checking if the cell is an obstacle
    if (MapOG.Cells(iy,ix)>=1), 
        return; 
    end ;
    
    %Setting the values for the distance, 1 is straight D2 is diagonal
    D = 1;
    D2 = sqrt(2);
    
    %Proportional increase, so it's slightly higher
    p = 0.01;
    
    %Set the differences
    dx = double(abs(iy - source(1)));
    dy = double(abs(ix - source(2)));
    
    %Calculating the heuristic cost
    heurCost = costProposed + D * sqrt(dx * dx + dy * dy);
    
    %Scaling the Heuristic slightly, so it'll never be better or equal to
    %the best solution
    heurCost = heurCost *(1+ p);
    
    
    currentCostOfThisChild =MapOG.CellsCostToGo(iy,ix);
    
    %Format this nicely
    if (heurCost >= currentCostOfThisChild),
        return ; % the proposed cost is worse than the previosly proposed cost. 
    end ;    
    
    
    %The proposed cost is better than any previously offered cost. Update
    MapOG.CellsCostToGo(iy,ix) = costProposed ;     
    %MapOG.CellsCostToGo(iy,ix) = heurCost;
    MapOG.MyBestParent(iy,ix) = Parent ;
    if currentCostOfThisChild>=10000, % unused, new!
        QueueLib_PushItem([iy,ix, heurCost]); % fisrt time this cell is considered ==> push in queue
    end ;
    return ;        
end