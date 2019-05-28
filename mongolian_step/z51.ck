class filter0 extends SYNT{
      1::samp => dur refresh;

          inlet => blackhole;
              
                  STLPF lpf;
                  //    STWPDiodeLadder lpf;
                      
                          fun void f1 (){ 
                                  while(1) {
                                            inlet.last() => lpf.lpfl.freq =>  lpf.lpfr.freq;
                                            //        inlet.last() => lpf.lpfl.cutoff =>  lpf.lpfr.cutoff;
                                                    refresh => now;
                                                          }
                                                                 
                                                                       
                                                                           } 
                                                                               spork ~ f1 ();

                                                                                   fun void  connect (ST @ in, float q){
                                                                                           lpf.connect(in , 1000 /* freq */  , 1.0 /* Q */  );   
                                                                                                 q => lpf.lpfl.Q =>  lpf.lpfr.Q;
                                                                                                 //      lpf.connect(in , 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );   
                                                                                                 //      q => lpf.lpfl.resonance=>  lpf.lpfr.resonance;

                                                                                                     }


                                                                                                             fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE tone_filter;
tone_filter.reg(filter0 filt0);  //data.tick * 8 => tone_filter.max; //60::ms => tone_filter.glide;  // tone_filter.lyd(); // tone_filter.ion(); // tone_filter.mix();// 
tone_filter.dor();// tone_filter.aeo(); // tone_filter.phr();// tone_filter.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
*8
____ ____   ____ ____   ____ G////f   ____ ____ 
____ ____   ____ ____   ____ f////G   ____ ____ 
____ ____   ____ ____   ____ f//GG//f   ____ ____ 

" => tone_filter.seq;
.9 * data.master_gain => tone_filter.gain;
//tone_filter.sync(4*data.tick);// tone_filter.element_sync();//  tone_filter.no_sync();//  tone_filter.full_sync();  // 16 * data.tick => tone_filter.extra_end;   //tone_filter.print(); //tone_filter.force_off_action();
// tone_filter.mono() => dac;//  tone_filter.left() => dac.left; // tone_filter.right() => dac.right; // tone_filter.raw => dac;
tone_filter.adsr[0].set(20::ms, 0::ms, 1., 400::ms);
tone_filter.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
tone_filter.go();   tone_filter $ ST @=> ST @ last; 

//////////////////////////////////////////////
//            PUT YOUR SYNT/SEQ HERE :       //
//            Beware of "last" declaration  //

class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
*8
{c{c{c{c{c
____ ____   ____ ____   ____ 9/2__2/9   ____ ____ 
____ ____   ____ ____   ____ 9/2_0/d_   ____ ____ 
____ ____   ____ ____   ____ _G/1_2/9   ____ ____ 
____ ____   ____ ____   ____ 2////9   ____ ____ 

" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=>last; 


//////////////////////////////////////////////

filt0.connect(last, 8.0); filt0.lpf @=> last; 

STHPF hpf;
hpf.connect(last $ ST , 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .8);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, 2*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
