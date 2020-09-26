function [fr, sm] = AmplitudeSpectrum(S)    
    // Short description 
    //   
    // Calling Sequence
    //  
    // Parameters
    //
    // Description
    //
    // Examples
    //
    // Authors
    //  Denis Mottet - Univ Montpellier - France
    //
    // Versions
    //  Version 0.0.0 -- D. Mottet -- Oct 9, 2019
    //      It is left to you to complete the previous (as an exercise)... 
    //      Have fun ! 

    sm = abs(fft(S,1));         // module of the fft
    smsize = max(size(sm));     // number of samples (in frequency domain)
    fr = (1:smsize)';           // same size as sm
    fr = fr ./ smsize;          // vector of frequencies (percentage of SampFreq)
    fr = fr.*SampFreq;          // vector of frequencies (in Hz)
    fr = fr(1:smsize/2);        // valid frequencies (Nyquist)
    sm = sm(1:smsize/2);        // valid modules (corresponding to fr)


endfunction 
