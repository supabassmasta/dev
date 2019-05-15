class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
    .03 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; 
10::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"  *6
678678
678678
678678
678678
234234
234234
123123
123123

678678
678678
678678
678678
234234
234234
123123
123123

678678
678678
678678
678678
234234
234234
123123
123123

678678
678678
678678
678678
234234
234234
123123
123123

______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
______
" => t.seq;
3.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 5::ms, .3, 400::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//t.go();  
t $ ST @=> ST @ last; 


STWPDiodeLadder stdl;
stdl.connect(last $ ST , 4 * 1000 /* cutoff */  , 7. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

//STSYNCWPDiodeLadder stsyncdl;
//stsyncdl.freq(35*100 /* Base */, 69 * 100 /* Variable */, 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
//stsyncdl.adsr_set(.1 /* Relative Attack */, .1/* Relative Decay */, 0.5 /* Sustain */, .3 /* Relative Sustain dur */, 0.2 /* Relative release */);
//stsyncdl.connect(t $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last;  

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 100 /* f_base */ , 1400  /* f_var */, 1::second / (16 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, 16*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 


STRECCONV strecconv;
20 * 1000 => strecconv.inputl.gain => strecconv.inputr.gain; // input signal into reverb only
.8 => strecconv.dry;
0::ms => strecconv.predelay;

//"../_SAMPLES/ConvolutionImpulseResponse/in_the_silo_revised.wav" => strecconv.ir.read; 
"../_SAMPLES/ConvolutionImpulseResponse/on_a_star_jsn_fade_out.wav" => strecconv.ir.read;
//"../_SAMPLES/ConvolutionImpulseResponse/chateau_de_logne_outside.wav" => strecconv.ir.read;
//"../_SAMPLES/ConvolutionImpulseResponse/st_nicolaes_church.wav" => strecconv.ir.read;
strecconv.loadir();

/////   /!\ make seq start after loading IR /!\   ///////////////////
t.no_sync(); // Config it no_sync
t.go();
////////////////////////////////////////////////////////////////

strecconv.connect(last $ ST /* ST */);
strecconv.process();
strecconv.rec(64 * data.tick /* length */, "arpconv.wav" /* file name */ ); 




while(1) {
       100::ms => now;
}
 
