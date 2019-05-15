class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .1 => s.gain;
    .0 => s.width;

//    SinOsc mod => s;
//    10. => mod.gain;
//    20 * 10 => mod.freq;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); //
t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" 
*2*6 }c {2
A_2_1_A_2_1_
A_2_1_A_2_1_
A_2_1_A_2_1_
A_2_1_A_2_1_
2_6_5_2_6_5_
2_6_5_2_6_5_
1_4_3_1_4_3_
1_4_3_1_4_3_

" => t.seq;
.25 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


//STLPF lpf;
//lpf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 1000 /* f_base */ , 2000  /* f_var */, 1::second / (6 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 



while(1) {
       100::ms => now;
}


