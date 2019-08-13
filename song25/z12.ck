class synt1 extends SYNT{

    inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
      .5 => w.gain;

    .125 => factor.gain;


      1 => w.sync;
      1 => w.interpolate;
//[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
//[-1.0,  1] @=> float myTable[];
float myTable[0];

SndBuf s => blackhole;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 01.wav"=> s.read;

for (0 => int i; i <  s.samples() /* && i < 2048  */  ; i++) {
  myTable << s.valueAt(i);
}
 

w.setTable (myTable);

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt2 extends SYNT{

//    inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
    inlet => Gain factor => blackhole;
    Wavetable w =>  outlet; 
      .5 => w.gain;

    .125 => factor.gain;


//      1 => w.sync;
      0 => w.sync;
      1 => w.interpolate;
//[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
//[-1.0,  1] @=> float myTable[];
float myTable[0];

SndBuf s => blackhole;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 01.wav"=> s.read;

for (0 => int i; i <  s.samples() /* && i < 2048  */  ; i++) {
  myTable << s.valueAt(i);
}
 

w.setTable (myTable);

        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => w.freq;
        } 0 => own_adsr;
} 

class PAD1 extends SYNT{

inlet => Gain factor => blackhole;

1. / 8. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 05_short.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class PAD2 extends SYNT{

inlet => Gain factor => blackhole;

1. / 32. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 01_short.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class PAD3 extends SYNT{

inlet => Gain factor => blackhole;

1. / 32. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 02_short.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class PAD0 extends SYNT{

inlet => Gain factor => blackhole;

1. / 32. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 06_short.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class VIOLIN0 extends SYNT{

inlet => Gain factor => blackhole;

1. / 32. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/violin.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class VIOLIN1 extends SYNT{

inlet => Gain factor => blackhole;

1. / 32. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/violin2.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class CELLO0 extends SYNT{

inlet => Gain factor => blackhole;

1. / 8. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/cello0.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 


lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(CELLO0 s0);  synta.a[0].set(3::ms, 30::ms, .7, 400::ms);
synta.reg(CELLO0 s1);  synta.a[1].set(3::ms, 30::ms, .7, 400::ms);
synta.reg(CELLO0 s2);  synta.a[2].set(3::ms, 30::ms, .7, 400::ms);
synta.reg(CELLO0 s3);  synta.a[3].set(3::ms, 30::ms, .7, 400::ms);

// Note info duration
10 * 100::ms => synta.ni.d;

synta $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 20 * 100 /* Variable */, 1. /* Q */);
stsynclpf.adsr_set(.1 /* Relative Attack */, .4/* Relative Decay */, .00006 /* Sustain */, .2 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpf.connect(last $ ST, synta.note_info_tx_o); stsynclpf $ ST @=>  last; 

STLPFC lpfc;
lpfc.connect(last $ ST , HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */  );       lpfc $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 8. /* static gain */  );       gainc $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 

