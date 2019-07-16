class SUPERSAWT extends SYNT{

	9 => int synt_nb; 0 => int i;
	Gain detune[synt_nb];
	TriOsc s[synt_nb];
	Gain final => outlet; .15 => final.gain;

	.001 * 2 => float offset;
	fun float comp_detune(int i) {
		return i * offset + Math.random2f(-0.001, 0.001) ;

	}
	inlet => detune[i] => s[i] => final;    1.  => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune((i+1)/2) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. - comp_detune((i+1)/2) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune((i+1)/2) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. - comp_detune((i+1)/2) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune((i+1)/2) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. - comp_detune((i+1)/2) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune((i+1)/2) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. - comp_detune((i+1)/2) => detune[i].gain;    .6 => s[i].gain; i++;  



	// init width
	for (0 =>  i; i < detune.size()     ; i++) {
		0. => s[i].width;
	}

  fun void reset_phase() {
    for (0 => int i; i <  synt_nb     ; i++) {
      0 => s[i].phase;
    }
     
  }

	fun void on()  { reset_phase(); }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(SUPERSAWT s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c
!1111
__53
0000
__68

" => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(30::ms, 10::ms, 1., 800::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

t.go();   t $ ST @=> ST @ last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 1::second / (8 * data.tick) /* freq */); 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 1::second / (8 * data.tick)/* freq */); 

//STLPF lpf;
//lpf.connect(last $ ST , 2 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 100 /* f_base */ , 200  /* f_var */, 1::second / (8 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

//STFILTERMOD fmod2;
//fmod2.connect( last , "HPF" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 50 /* f_base */ , 150  /* f_var */, 1::second / (11 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 


STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 
//STLIMITER stlimiter;
//5. => float in_gainl;
//stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   
while(1) {
       100::ms => now;
}
 
