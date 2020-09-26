function [delay, lags, c] = getDelayBetweenSignals(A, B)
    // Short description 
    //   getDelayBetweenSignals(A, B) gets the delay between two signal 
    //      using cross correlation of the differences
    //
    // Calling Sequence
    //   [delay, lags, c] = getDelayBetweenSignals(A, B)
    //
    // Parameters
    //  delay : lag from signal A to signal B (in sample)
    //  lags : output of xcorr (the lags tested)
    //  c : output of xcorr (correlation at each lag)
    // 
    // Description
    //
    // Examples
    //      t = linspace(0, 3, 100)'
    //      S = cos(3*%pi*t)+2*cos(%pi*t)
    //      A = S(1:$-10)
    //      B = S(11:$)
    // 
    //      [delay, lags, c] = getDelayBetweenSignals(A, B);
    //      
    //      T = (1:length(A))'
    //      plot(T, A, "*-b")
    //      plot(T, B, "*-k")
    //      plot(T+delay, B, "*-r")
    //      title(sprintf("Delay = %+d", delay))
    //      legend("A", "B", "B(t+delay)")    
    //  
    // Authors
    //  Denis Mottet - Univ Montpellier - France
    //
    // Versions
    //  Version 1.0.0 -- D. Mottet -- Sept 26, 2020
    
    
    // check arguments
    if min(size(A)) > 1 | min(size(B)) > 1 then
        error("Inputs are should be vectors")
    end
    if max(size(A)) ~= max(size(B)) then
        error("Inputs should have the same size")
    end

    // get the approximate time derivative 
    dA = diff(A); 
    dB = diff(B); 

    // get the delay FROM THE DERIVATIVES 
    // NB : you want that A **CHANGES** with B (you do not want that A = B) 
    [c, lags] = xcorr(dA, dB);      // cross correlation of the derivatives 
    [val, iVal] = max(c)            // find index of max correlation 
    delay = lags(iVal)              // the delay is at the max of the correlation

endfunction
