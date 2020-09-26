function [Sf] = LowPassButtDouble (S, SampFreq, CutFreq)
    // LowPassButtDouble : low pass filter of a signal with dual pass Butterworh
    //
    // Calling Sequence
    //  [Sf] = LowPassButtDouble (S, SampFreq, CutFreq)
    //
    // Parameters
    //  S        : vector,  the input signal S must be vector.
    //  SampFreq : number,  sampling frequency in Hz
    //  CutFreq  : number,  cutoff frequency in Hz
    //  Sf       : vector,  the signal after the filtering
    //
    // Description
    //  LowPassButtDouble : low pass filter of a signal with dual pass Butterworh
    //  to cancel phase shift. The resulting filter has an order of 4 and an
    //  effective cut frequency of about CutFreq * 83%.
    //  Sf is a vector (same size as S)
    //
    // Examples
    //  To get a signal filtered at 8Hz
    //      T = linspace(0,10,1001);
    //      S = sin(2*%pi*T)+sin(20*%pi*T);
    //      Sf = LowPassButtDouble (S, SampFreq, 8);
    //      plot(T, S, '-k', T, Sf, '-b')
    //      legend("S", "Sf")
    
    // Authors
    //  Denis Mottet - Univ Montpellier - France
    //
    // Versions
    //  Version 1.0.0 -- D. Mottet -- 2016-05-28
    //    First version
    //  Version 1.0.1 -- D. Mottet -- 2018-03-27
    //    Documentation following
    //      https://wiki.scilab.org/Guidelines%20To%20Design%20a%20Module
    //  Version 1.0.2 -- D. Mottet -- 2019-10-09
    //      self contained example (cut-paste is ok)
    //  Version 1.1.0 -- D. Mottet -- 2020-04-11
    //      correct cutoff for dual pass second order butterworth 



    if min(size(S)) > 1 then
        error("The input signal should be a vector")
    end

    // Correct cut frequency for a 2nd order butt with dual pass in fltsflts
    Cutoff = CutoffCorrection(CutFreq, SampFreq);
    // Computation of the Butterworth filter equation
    hz = iir(2, 'lp', 'butt', [Cutoff/SampFreq, 0], [0,0]);
    // Dual-pass filtering in the time domain
    ReflexionSize = 60;     // to consume starting effects of iir filter
    Sf = fltsflts(S, hz, ReflexionSize);

endfunction

function f_corrected = CutoffCorrection(cutoff_frequency, sampling_frequency)
    // Biomechanics and Motor Control of Human Movement, 4th-edition (page 69)
    // https://www.codeproject.com/Articles/1267916/Multi-pass-Filter-Cutoff-Correction
    filter_passes = 2;                          // filtfilt use 2 passes
    C = (((2^(1/filter_passes))-1)^(1/4));      // David A. Winter butterworth correction factor
    Wc = 2*%pi*cutoff_frequency;                // angular cutoff frequency
    Uc = tan(Wc/(2*sampling_frequency));        // adjusted angular cutoff frequency
    Un = Uc / C;                                // David A. Winter correction
    f_corrected = atan(Un)*sampling_frequency/%pi; 
endfunction
