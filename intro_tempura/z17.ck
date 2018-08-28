ST st_effect;
ST st_direct;

adc => Gain gain_effect => st_effect.mono_in; st_effect @=> ST @ last;
adc => Gain gain_direct => st_direct.mono_in;
.5 => gain_effect.gain;
.5 => gain_direct.gain;

// EFFECT -----------------
STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


// DIRECT + EFFECT --------

STLPF lpf;
lpf.connect(last $ ST , 5 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 
lpf.connect(st_direct , 5 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 


