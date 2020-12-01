class synt0 extends SYNT{

  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SinOsc s[synt_nb];
  Gain final => outlet; .3 => final.gain;

  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  2.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.43 => det_amount[i].next;      .1 => s[i].gain; i++;   

  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.61 => det_amount[i].next;      .1 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  1.43 => det_amount[i].next;      .1 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -2.43 => det_amount[i].next;      .1 => s[i].gain; i++;   
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.43 => det_amount[i].next;      .1 => s[i].gain; i++;   





  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


POLYTONE pt;

3 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;//
1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
//pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
pt.sync(1*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

.6 * data.master_gain =>  pt.gain_common;
// .6 * data.master_gain => pt.t[0].gain; // For individual gain

//pt.t[0].reg(synt0 s0); 
//pt.t[1].reg(synt0 s1); 
//pt.t[2].reg(synt0 s2); 

//pt.adsr0_set(1500::ms, 1000::ms, .8, 3000::ms); // Only works for ADSR 0
//pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

for (0 => int j; j <    3   ; j++) {
  for (0 => int i; i <    4      ; i++) {
    pt.t[j].reg(new synt0);
    
    pt.t[j].adsr[i].set(2000::ms, 1000::ms, .6, 4000::ms);
    //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  }

}

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c :4 1|3|5|7__" +=> pt.tseq[0];
"}c}c :4 _4|2|6|0_" +=> pt.tseq[1];
"}c}c :4 __3|5|0|7" +=> pt.tseq[2];

pt.go();

// CONNECTIONS
pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
// pt.t[0] $ ST @=> ST @ last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 

16 * data.tick => now;
<<<"ST disconnect">>>;
//pt.stout.outl =< dac.left;
//pt.stout.outr =< dac.right;
//pt.stout.outl =< pt.stout.left_out;
//pt.stout.outr =< pt.stout.right_out;
//

pt.stout.disconnect();

8 * data.tick => now;
<<<"OUT">>>;




1 * data.tick => now;

 
