53 => data.ref_note;

class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; 
36::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(0 /* synt nb */ );

t.gypsy_minor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 
//"*4 }c 1234 5678 7878 __66  5_4_ 3210 111_ __8_ " => t.seq;
//"*4 }c 11__ __33 __11 ____ 33__ 332_ 331_  3_32 331_ 3213 21__  " => t.seq;
//"*4 }c 1111 3333 3333 33__    1111 2222 2222 22__  1111 3333 3333 33__  3214 3211 1_1_ 1_1_ " => t.seq;
"*4 }c
1111 3333 3333 33__    1111 2222 2222 22__  1111 3333 3333 33__  3214 3211 1_1_ 
1111 3333 2222 11__    13214 3211 5432 3214 3211 1_1_ 3214 3211  321_ 1_1_ 1_1_ " => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

SinOsc sin0 =>  s0.inlet;
30 * 10.0 => sin0.freq;
30.0 => sin0.gain;


//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 2 / 4 , .6);  ech $ ST @=>  last; 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 11/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
