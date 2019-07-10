class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet;   
        .1 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
____ 1/8 _c/8_ ____ ____
____ 8/1 _1/c_ ____ ____
" => t.seq;
.7 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .7);  ech $ ST @=>  last; 

//STFILTERMOD fmod;
//fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 2400  /* f_var */, 1::second / (8 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 
STECHO ech2;
ech2.connect(last $ ST , data.tick * 3 / 4 , .6);  ech2 $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
