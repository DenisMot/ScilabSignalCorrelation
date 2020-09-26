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
//  Version 1.0.0 -- D. Mottet -- Oct 10, 2019
//  Version 1.0.1 -- D. Mottet -- Apr 11, 2020
//      with input (from DAT) and ouptut (to RES)

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

////////////////////////////////////////////////////////////////////////////////
// BEG : code example : plot a signal + noise 
// 
// PART 0 : read an input file
fnameIn = fullfile(DAT_PATH, "Frequencies.csv"); 
separator = " "; 
decimal   = "."; 
Txt = csvRead(fnameIn, separator, decimal, "string" );
Val = csvRead(fnameIn, separator, decimal, "double" );

SampFreq   = Val(2, 1);                // Sampling frequency (Hz)
SignalFreq = Val(2, 2);                // Signal frequency (Hz)
NoiseFreq  = Val(2, 3);                // Noise frequency (Hz)
CutFreq    = Val(2, 4);                // cutoff frequency (Hz)

// PART 1 : computations 

// Generate a signal (low frequency) + noise (high frequency)
Duration = 5;                       // Duration of signal (s)
T = 0 : 1./SampFreq : Duration;     // Time (over Duration sec)
T = T';                             // Time as a column vector 

Ss =   1 .* cos(2 .* %pi .* SignalFreq .* T);     // Amplitude 1
Sn = 0.1 .* cos(2 .* %pi .* NoiseFreq  .* T);     // Amplitude 0.1 
S = Ss + Sn;                        // S contains two signals  

// lowpass the signal 

Sf = LowPassButtDouble (S, SampFreq, CutFreq);  // filter

// PART 2 : illustrations  
fig = 1;    
figure(fig);clf; 
plot(T, S,  '-k')
plot(T, Sf, '-b')
xlabel("Time (s)")
ylabel("Amplitude (unit?)")
xtitle("Signal as a function of time")
legend("S", "Sf")


// PART 3 : save figure 1 as a result 
fnamePDF = fullfile(RES_PATH, "Signals.pdf"); 
xs2pdf(fig, fnamePDF)

// END : code example : plot a signal + noise 
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// BEG : code example : call an external script  

Mode_DisplayNothingInConsole = -1; 
exec(fullfile(PRG_PATH, "FourrierAnalysis.sce"), Mode_DisplayNothingInConsole)

// END: code example : call an external script  
////////////////////////////////////////////////////////////////////////////////


