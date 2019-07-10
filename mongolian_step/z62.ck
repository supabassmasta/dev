class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

 

 TONE t;
 t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
 t.dor();// t.aeo(); // t.phr();// t.loc();
 // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//1_1_3_ 1_____ 
//3_3_4_ 3_2___
//{c
//5_5_7_ 5_5___
//7_7_8_ 7__6__
 "*6 }c}c }c 
1_____ ______ 
3_____ ______
{c
5_____ ______
7_____ ___6__

}c

1_____ ______ 
3_____ ______
{c
5_____ 5_____
7_____ ___6__

}c

1_____ ______ 
3_____ ______
{c
5_____ ______
7_____ ___6__

}c

1_____ ______ 
3_____ ______

5_____ 5_____
7_____ ___6__


 " => t.seq;
 .4 * data.master_gain => t.gain;
 //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
 // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
 t.adsr[0].set(4::ms, 30::ms, .001, 400::ms);
 t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
 t.go();   t $ ST @=> ST @ last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 1 / 8 , .8);  ech $ ST @=>  last; 
STGVERB stgverb2;
stgverb2.connect(last $ ST, .2 /* mix */, 1 * 10. /* room size */, 6::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb2 $ ST @=>  last;

STGVERB stgverb;
stgverb.connect(last $ ST, .5 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last;

STCOMPRESSOR stcomp;
12. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain + .1 /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   


 while(1) {
        100::ms => now;
 }
  

