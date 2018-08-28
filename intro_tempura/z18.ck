ST st_effect;
ST st_direct;

adc => Gain gain_effect => st_effect.mono_in; st_effect @=> ST @ last;
adc => Gain gain_direct => st_direct.mono_in;
1.5 => gain_effect.gain;
1.5 => gain_direct.gain;

// EFFECT -----------------
STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .9);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, 3*data.tick/2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

// DIRECT + EFFECT --------

STLPF lpf;
lpf.connect(last $ ST , 10 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 
lpf.connect(st_direct , 10 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 


