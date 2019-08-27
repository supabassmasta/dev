ST st;
SndBuf s => st.mono_in;

// G#
Std.mtof(56 -12 ) / Std.mtof(48) => float rate => s.rate;


"../_SAMPLES/tanpura/LoopCplusG 3.wav" => s.read;
0.3 * data.master_gain => s.gain;

fun void f1 (){ 
  while(1) {

    s.length() / rate => now;
    0 => s.pos;
  }
} 
spork ~ f1 ();
    
st @=> ST @ last;


STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 1600  /* f_var */, 1::second / (5 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .2 /* delay line gain */,  100::ms /* dur base */, 0::ms /* dur range */, 2 /* freq */); 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .2 /* delay line gain */,  150::ms /* dur base */, 0::ms /* dur range */, 2 /* freq */); 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .2 /* delay line gain */,  175::ms /* dur base */, 0::ms /* dur range */, 2 /* freq */); 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .2 /* delay line gain */,  999::ms /* dur base */, 0::ms /* dur range */, 2 /* freq */); 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .2 /* delay line gain */,  1187::ms /* dur base */, 0::ms /* dur range */, 2 /* freq */); 

STECHO ech;
ech.connect(last $ ST , 1497::ms , .6);  ech $ ST @=>  last; 

STLPF lpf;
lpf.connect(last $ ST , 2000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .4 /* mix */);     rev  $ ST @=>  last; 

    while(1) {
           100::ms => now;
    }
     

