class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   } 0 => own_adsr;
}

TONE t;
t.reg(AMB1 s1);  //data.tick * 8 => t.max; 160::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 
}c
1_5 _ 1___
5 _1_ 1!1!5_
1!5!1!5 ____
1!3!8!5 ____
" => t.seq;
.35 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2000::ms, 1000::ms, .6, 4000::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last;

//STFILTERMOD fmod;
//fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 1600 /* f_base */ , 1400  /* f_var */, 1::second / (6 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STREV2 rev; // DUCKED
rev.connect(last $ ST, .4 /* mix */);      rev $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
