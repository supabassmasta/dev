TONE t;
t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(1 /* synt nb */ );
// s0.set_chunk(0); 

fun void  LOOPLA  (){ 
    while(1) {
       

        s0.set_chunk(Std.rand2(0,63)); 

            1 * data.tick / 8=> now;
                //-------------------------------------------
                  }
} 
spork ~ LOOPLA();


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 }c }c 1_" => t.seq;
//"*4 }c }c 1_11 __1_ 111_ 8_8_ __1_ *3 111_ 111_ 111_111_ 111_ 111_111_ 111_ 111_111_ 111_ 111_" => t.seq;
2.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(2::ms, 3::ms, .9, 4::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STWPDiodeLadder stdl;
stdl.connect(last $ ST , 12 * 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

STFREEPAN stfreepan0;
stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
AUTO.pan("*8 42531638") => stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0 

STLHPFC lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 


<<<"=======================">>>;
<<<"== SEQ CUT   MOD   ====">>>;
<<<"== 1.1  HLPF.F     ====">>>;
<<<"== 1.2  HLPF.Q     ====">>>;
<<<"== 1.3  FM MODE GAIN ==">>>;
<<<"=======================">>>;
<<<"=======================">>>;

// MOD
MGAINC mgainc0; mgainc0.config( HW.lpd8.potar[1][3] /* gain */, 100.0 /* Static gain */ ); 
TriOsc sin0 =>  mgainc0 =>  s0.inlet; 
100.0 => sin0.freq;
1.0 => sin0.gain;


while(1) {
       100::ms => now;
}


