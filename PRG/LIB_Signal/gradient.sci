function dSdT = gradient(S, T)  
    // gradient computes the approximate time derivative of a signal S
    //
    // Calling Sequence
    //  dS = gradient(S, [T])
    //
    // Parameters
    //  S   : vector, the input signal S must be vector.
    //  T   : vector, time of measure  (same size as S)
    //  dS  : vector, the time derivative of S (same size as S)
    //
    // Description
    //  gradient computes the first central difference along S, using T as the 
    //  spacing between elements in S. If T is a single value, T is the constant 
    //  sampling period. If T is ommited, T = 1 is used. 
    //  Edges are computed with linear extraopolation. 
    //  NOTE : in case of non constant sampling rate, the averaging in the 
    //  central difference will give poor approximation of dS/dt. CAUTION. 
    //
    // Examples
    //  To get a signal filtered at 8Hz
    //      T = linspace(0,10,1001);
    //      S = sin(2*%pi*T)+sin(20*%pi*T)/10;
    //      dS = gradient(S, T);
    //      plot(T, S, '-k', T, dS, '-b')
    //      legend("S", "dS")
    //
    // Authors
    //  Denis Mottet - Univ Montpellier - France
    //
    // Versions
    //  Version 1.0.0 -- D. Mottet -- May 26, 2011
    //  Version 1.1.0 -- D. Mottet -- Oct 10, 2019
    //    Documentation following
    //      https://wiki.scilab.org/Guidelines%20To%20Design%20a%20Module

    
    // argument check
    if min(size(S)) > 1 then
        error("S should be a vector");
    end
    if min(size(T)) > 1 then
        error("T should be a vector");
    end

    dS = LocalDiff(S);                  // 2 step diff on S
    
    if argn(2) < 2 then 
        dt = 1; 
    else
        if size(T, "*") == 1 then        
            dt = T;                     // a single value = Sampling period
        else
            dt = LocalDiff(T);          // 2 step diff on T
        end
    end

    dSdT = dS ./ dt;

endfunction

////////////////////////////////////////////////////////////////////////////////
// This where real things happens... 
// Computes the approximate derivative of S using the first central difference
// algorithm (and simple diff at edges): 
// https://en.wikipedia.org/wiki/Finite_difference
// 
//                       f(t+h) - f(t-h)
// Central difference = -----------------
//                             2h
// with 
// h = sampling period ; t = time ; f(t) = time serie (the signal) 

function dS = LocalDiff(S)
    
    dS = zeros(S);                      // prealocation (for the next line)

    dS(2:$-1) = (S(3:$)-S(1:$-2))/2 ;   // first central difference (mean of S at 2 steps in time)

    dS(1) = S(2) - S(1);                // simple diff (at the beg)
    dS($) = S($) - S($-1);              // simple diff (at the end)

    dS(1) = 2*dS(1) - dS(2);            // simple extrapolation (to the beg)
    dS($) = 2*dS($) - dS($-1);          // simple extrapolation (to the end)

endfunction
