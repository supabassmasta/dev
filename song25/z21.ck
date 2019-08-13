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


TONE t;
t.reg(PAD0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(PAD0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(PAD0 s2);  //data.tick * 9 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8:2 }c}c
1|3|51|3|5_
" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(600::ms, 400::ms, .7, 2000::ms);
t.adsr[1].set(600::ms, 400::ms, .7, 2000::ms);
t.adsr[2].set(600::ms, 400::ms, .7, 2000::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  24::ms /* dur base */, 12::samp /* dur range */, .021 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  24::ms /* dur base */, 11::samp /* dur range */, .02 /* freq */); 

STSYNCLPF stsynclpf;
stsynclpf.freq(200 /* Base */, 3 * 100 /* Variable */, 1. /* Q */);
stsynclpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.8 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STMIX stmix;
stmix.send(last, 28);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 

