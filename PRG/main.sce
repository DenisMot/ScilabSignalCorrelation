// Short description 
//  main : file to "run" in scilab (e.g., using F5)
//
// Calling Sequence
//  none : main is the entry point 
//
// Parameters
//  none
//
// Description
//  main is the file to run using the scilab interface 
//
// Authors
//  Denis Mottet - Univ Montpellier - France
//
// Versions
//  Version 1.0.0 -- D. Mottet -- SEpt 26, 2020

// The main script always contains two parts : 
//  1°) set up of working environement 
//  2°) computations (in the right setup)

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// **** FIRST : Initialize ****

PRG_PATH = get_absolute_file_path("main.sce");          
FullFileInitTRT = fullfile(PRG_PATH, "InitTRT.sce" );
exec(FullFileInitTRT); 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// **** SECOND : Do things ****

// PART 0 : read input file(s)
fnameIn_A = fullfile(DAT_PATH, "A_data.txt"); 
fnameIn_B = fullfile(DAT_PATH, "B_data.txt"); 
separator = ","; 
decimal   = "."; 

A = csvRead(fnameIn_A, separator, decimal, "double" );
B = csvRead(fnameIn_B, separator, decimal, "double" );

// simplify the data : keep only last column 
A = A(:,$); 
B = B(:,$); 

// create a known delay (for testing purpose)
if %T then
    d = -12; write(%io(2), sprintf("The KNOWN lag is %d samples ", d) )
    if d >= 0 then 
        B = A(d+1:$); // create data using A only 
        A = A(1:$-d); 
    else
        B = A(1:$+d); // create data using A only 
        A = A(abs(d)+1:$); 
    end
    // switch A and B (for tests)
    write(%io(2), sprintf("A and B were reversed: this changes the sign of the lag") )
    C = B; 
    B = A; 
    A = C; 
end

[delay, lags, c] = getDelayBetweenSignals(A, B)

figure()
plot(lags, c')
xlabel ("lag")
xlabel ("correlation A-B")
title(sprintf("Maximum correlation for a delay of %+d samples", delay))

write(%io(2), sprintf("The lag FOUND is %d samples ", delay) )
write(%io(2), sprintf("Signal A(t) ressembles signal B(t%+d)", delay) )

// we need "time" for the x axis of the plot... 
Time = 1:length(A);    // create time = index of line in A (or B)
Time = Time';         // make it a column vector 
TimeB = Time + delay;  // new time for signal B

figure()

plot(Time, A, '-b')
plot(Time, B, '-k')
plot(TimeB, B, '-r')
legend("Signal A", "Signal B", "Signal B (sync with A)")
xlabel("Sample number")
ylabel("Signal value")
title(sprintf("Signal A(t) ressembles signal B(t%+d)", delay) )


figure()
plot(Time, A, '-b')
plot(Time, B, '-k')
legend("Signal A", "Signal B")
xlabel("Sample number")
ylabel("Signal value")




////////////////////////////////////////////////////////////////////////////////


