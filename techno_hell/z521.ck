TONE t;
t.reg(PSYBASS6 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4
_1!1!1

" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 41 * 10 /* freq */  , 1.1 /* Q */  );       lpf $ ST @=>  last; 

 class STDUCK2 extends ST {
   Dyno dl;
   Dyno dr;
   dl.duck();
   dr.duck();

   Gain sidein_l => blackhole;
   Gain sidein_r => blackhole;


   fun void side_process(){ 

     while(1) 
     {
       sidein_l.last() =>  dl.sideInput;
       sidein_r.last() =>  dr.sideInput;
       1::samp => now;
     }

   } 

   fun void connect(ST @ tone, float in_gain, float tresh, float slope, dur attack, dur release) {
     in_gain => sidein_l.gain;
     in_gain => sidein_r.gain;

     tresh =>   dl.thresh;
     tresh =>   dr.thresh;

     slope =>   dl.slopeAbove;
     slope =>   dr.slopeAbove;

     attack =>  dl.attackTime;
     attack =>  dr.attackTime;

     release => dl.releaseTime;
     release => dr.releaseTime;


     global_mixer.duck2_sidel => sidein_l;
     global_mixer.duck2_sider => sidein_r;

     tone.left()  => dl => outl;
     tone.right() => dr => outr; 

     spork ~ side_process();

   }

}


STDUCK2 duck2;
duck2.connect(last $ ST, 9. /* Side Chain Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duck2 $ ST @=>  last; 

STMIX stmix;
stmix.send(last, 14);

while(1) {
       100::ms => now;
}
 
