class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
      .45 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(SUPERSAW2 s1);  //data.tick * 8 => t.max; //
30::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4
8351
8351
8351
8351
4A21
4A21
B351
B351
" => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 + 3::ms , .9);  ech $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .2 /* delay line gain */,  4.1::ms /* dur base */, 3::ms /* dur range */, 81 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .2 /* delay line gain */,  4.1::ms /* dur base */, 3::ms /* dur range */, 80 /* freq */); 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .2 /* delay line gain */,  5.1::ms /* dur base */, 4::ms /* dur range */, 83 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .2 /* delay line gain */,  5.1::ms /* dur base */, 4::ms /* dur range */, 82 /* freq */); 

STFILTERMOD fmod;
fmod.connect( last , "HPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 200 /* f_base */ , 1400  /* f_var */, 1::second / (10 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
