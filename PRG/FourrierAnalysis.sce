// Short description 
//   example of fourier analysis 
//
// Calling Sequence
//  **** This script should be called by another script *****
// 
// Parameters
//  S + Sf are needed (signal + filtered signal) 
//
// Description
//  FourrierAnalysis computes and displays the amplitude spectrum of S and Sf  
// 
// Examples
//
// Authors
//  Denis Mottet - Univ Montpellier - France
//
// Versions
//  Version 1.0.0 -- D. Mottet -- Oct 10, 2019
//  Version 1.0.1 -- D. Mottet -- Apr 11, 2020


////////////////////////////////////////////////////////////////////////////////
// BEG : get and display amplitude spectrum 

// PART 1 : obtain signal frequency and magnitude
[S_f,  S_m]  = AmplitudeSpectrum(S);    // call function AmplitudeSpectrum
[Sf_f, Sf_m] = AmplitudeSpectrum(Sf); 

// PART 2 : illustrations  
figFrequencies = 2; 
figure(figFrequencies); clf; 
plot(S_f,  S_m,  "-k")
plot(Sf_f, Sf_m, "-b")

xlabel("Frequency (Hz)")
ylabel("Module (same unit as orginal signal)")
xtitle("Amplitude spectrum from fft")
legend("S", "Sf")

// PART 3 : save figure as a result 
fnamePDF = fullfile(RES_PATH, "Frequencies.pdf"); 
xs2pdf(figFrequencies, fnamePDF)



// END : get and display amplitude spectrum 
////////////////////////////////////////////////////////////////////////////////

