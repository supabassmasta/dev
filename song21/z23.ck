class filter0 extends SYNT{
    1::samp => dur refresh;

    inlet => blackhole;

    STWPDiodeLadder lpf;
    
    fun void f1 (){ 
      while(1) {
        inlet.last() => lpf.lpfl.cutoff =>  lpf.lpfr.cutoff;
        refresh => now;
      }
       
      
    } 
    spork ~ f1 ();

    fun void  connect (ST @ in, float q){
      lpf.connect(in , 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );   
      q => lpf.lpfl.resonance=>  lpf.lpfr.resonance;

    }


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE tone_filter;
tone_filter.reg(filter0 filt0);  //data.tick * 8 => tone_filter.max; //60::ms => tone_filter.glide;  // tone_filter.lyd(); // tone_filter.ion(); // tone_filter.mix();// 
tone_filter.dor();// tone_filter.aeo(); // tone_filter.phr();// tone_filter.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c
*3G/fG/fG/f:3
G/f
*6G/fG/fG/fG/fG/fG/f:6
*2f/G:2
M/l
" => tone_filter.seq;
.9 * data.master_gain => tone_filter.gain;
//tone_filter.sync(4*data.tick);// tone_filter.element_sync();//  tone_filter.no_sync();//  tone_filter.full_sync();  // 16 * data.tick => tone_filter.extra_end;   //tone_filter.print(); //tone_filter.force_off_action();
// tone_filter.mono() => dac;//  tone_filter.left() => dac.left; // tone_filter.right() => dac.right; // tone_filter.raw => dac;
tone_filter.adsr[0].set(20::ms, 10::ms, 1., 400::ms);
tone_filter.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
tone_filter.go();   tone_filter $ ST @=> ST @ last; 

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
{c{c
1538
1_80
1538
cc83
" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=>  last; 

filt0.connect(last, 6.0); filt0.lpf @=> last;

STCOMPRESSOR stcomp;
17. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain +  .6/* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
