class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(29 /* synt nb */ ); 

//s0.config(1 /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//"   *8__8 530 1_2 81_532_1:8 __ ____ " => t.seq;
" {c {c *8851851851851851851851851851851851851:8 __ ____ " => t.seq;
.23 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


//SinOsc sin0 =>  s0.inlet;
//94.0 => sin0.freq;
//24.0 => sin0.gain;

//ARP arp;
//arp.t.dor();
//12::ms => arp.t.glide;
////"*4 185B8  " => arp.t.seq;
//arp.t.go();   

// CONNECT SYNT HERE
//3 => s0.inlet.op;
//arp.t.raw() => s0.inlet; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 10* 100.0 /* freq */ , 1.1 /* Q */ , 4 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 + 10::ms, .6);  ech $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .7 /* delay line gain */, data.tick * 3/2 + 43::ms /* dur base */, 0::ms /* dur range */, 0 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .7 /* delay line gain */, data.tick * 3/2 + 5::ms /* dur base */, 0::ms /* dur range */, 0 /* freq */); 

while(1) {
       100::ms => now;
}
 
