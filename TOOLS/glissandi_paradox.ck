//* ******************************************************************
//*
//*  Risset's paradox aka Shepard Tone
//*                   (see Dodge's Elements of CM pp-94-96)
//*
//* This take Juan Reyes, 03/08/2017
//*
//*
//* Toggle values: baseFreq and baseDur

// sample rate
1::second / 1::samp => float srate;



// Function for normal curves to factor amplitude
fun float normfn (float x, float d)
{
    return Math.exp(-4.8283*(1-Math.cos(2*Math.PI*
    (x-((d*srate*0.5)-0.5))/(d*srate))));
}

// Toggle values
// --------------

1000.0 => float baseFreq;
3.33 => float baseDur;
baseDur*srate => float samples;
samples/7.0 => float phaseoffs;

// Frequency Factors
[0.0, 51.2, 102.4, 153.6, 204.8, 256.0, 307.2, 358.4,
409.6, 460.8] @=> float fqFactors[];

// A bank of sine oscillators
SinOsc oscBank[10];

// Gains for oscillator bank
Gain gainsArr[10];

// Signal
for(0=> int i; i < oscBank.cap(); i++)
{
    baseFreq+fqFactors[i]=> oscBank[i].freq;
    oscBank[i] => gainsArr[i] => dac;
}

// Count samples
0.0 => float sx;

while( true ) {

    for (0 => int j; j < oscBank.cap(); j++)
    {
        0.25*normfn((sx+((j+1)*phaseoffs)), baseDur)
        => gainsArr[j].gain;
    }

    if (sx > samples)
    {
        0 => sx;
    }
    else
    {
        1 +=> sx;
    }

    //     advance "1" sample.
    1.0::samp => now;
}
