class synt0 extends SYNT{

  16 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  TriOsc s[synt_nb];
  Gain final => outlet; 22 * .01 => final.gain;
  .1 => float w;
  inlet => detune[i] => s[i] => final; w => s[i].width; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
//  inlet => detune[i] => s[i] => final; w => s[i].width; det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
//  inlet => detune[i] => s[i] => final; w => s[i].width; det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   


  fun void on()  {
  }
  fun void off() { } 
  
  fun void new_note(int idx)  { 
    for (0 => int i; i <  synt_nb     ; i++) {
      0 => s[i].phase;
    }
  } 0 => own_adsr;
}

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//_1|3|5|7|8!1|!3|!5|!7|!8__ ____ ____ ____ ____ ____
"}c
_1|3|5|7|8 
" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STPADSR stpadsr;
stpadsr.set(1::ms /* Attack */, 2::ms /* Decay */, 1.0 /* Sustain */, 1::ms /* Sustain dur */,  119::ms /* release */);
stpadsr.setCurves(1.0, 0.6, 0.4); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, t.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 


STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STAUTOFILTERX stautobpfx0; BPF_XFACTORY stautobpfx0_fact;
stautobpfx0.connect(last $ ST ,  stautobpfx0_fact, 0.5 /* Q */, 1 * 100 /* freq base */, 11 * 100 /* freq var */, data.tick * 13  /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautobpfx0 $ ST @=>  last;  

STCOMPRESSOR stcomp;
7. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 4::ms /* attackTime */ , 9::ms /* releaseTime */);   stcomp $ ST @=>  last;   

2 => stcomp.gain;

while(1) {
       100::ms => now;
}
 
