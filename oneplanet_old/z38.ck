class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  //
t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 }c 
1__1 _2__
5___ ____

B__B _A__
2___ ____

1_3_ 21__
5___ ____

1_B_ 0A__
B___ ____


" => t.seq;
0.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
4 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(40::ms, 30::ms, .3, 400::ms);
t.adsr[0].setCurves(.8, 2.0, 2.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STGVERB stgverb;
stgverb.connect(last $ ST, .06 /* mix */, 8 * 10. /* room size */, 8::second /* rev time */, 0.0 /* early */ , 0.3 /* tail */ ); stgverb $ ST @=>  last; 

//STREV1 rev;
//rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
