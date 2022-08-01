class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(0 /* synt nb */ ); 

// MOD

//SinOsc sin0 =>  s0.inlet;
//100.0 => sin0.freq;
//100.0 => sin0.gain;



t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" }c}c ____ ____ *4 1_1_1_1_8_1_1_1_ :4 ____" => t.seq;
.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(2::ms, 110::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//ARP arp;
//arp.t.dor();
//25::ms => arp.t.glide;
//"*4 1111118  " => arp.t.seq;
//arp.t.go();   

// CONNECT SYNT HERE
//3 => s0.inlet.op;
//arp.t.raw() => s0.inlet; 

//STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
//stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 6 * 100 /* freq base */, 17 * 100 /* freq var */, data.tick *   2/3 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.5 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 7* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .01 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
