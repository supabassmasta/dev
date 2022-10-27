class synt0 extends SYNT{
    inlet => blackhole;

    BandedWG bwg  =>  outlet; 
0.978363 => bwg.bowRate;
0.373116 => bwg.bowPressure;
0.853088 => bwg.strikePosition;
0 => bwg.preset;

124 => bwg.bowMotion;
//    bwg.controlChange( 11, 4 /* vibratoFreq */); 
//    bwg.controlChange( 128, 1 /*bowVelocity*/);
//    bwg.controlChange( 64, .1 /*setStriking*/);

    fun void f1 (){ 
      1::samp => now;
      inlet.last() => bwg.freq;
      2.8 => bwg.pluck;
       } 
       
        

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { spork ~ f1 ();} 0 => own_adsr;
}

TONE t;
t.reg(synt0 s1);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.lyd();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//51_7 355_
//1518 7_3_

"}c }c *4
531_ 3_8_
5151 _3_3
4__4 __8_
51_351 _3
1___ 5__1
4__4_ 5__1
1___ __8

" => t.seq;
1.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
//21::ms => arp.t.glide;
"*4 11188B5  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s1.inlet.op;
arp.t.raw() => s1.inlet; 


//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 
STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .7 /* delay line gain */,  12::ms /* dur base */, 2::ms /* dur range */, 3 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .7 /* delay line gain */,  11::ms /* dur base */, 1::ms /* dur range */, 3 /* freq */); 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 



STAUTOPAN autopan;
autopan.connect(last $ ST, .4 /* span 0..1 */, 5*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

//STAUTOPAN autopan2;
//autopan2.connect(last $ ST, .3 /* span 0..1 */, 3*data.tick /* period */, 0.15 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 


STREV2 rev; // DUCKED
rev.connect(last $ ST, .2 /* mix */);      rev $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
