class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

POLYTONE pt;

3 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;// 1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
 //pt.t[0].force_off_action();
 // pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

 pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
  //pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

  .6 * data.master_gain =>  pt.gain_common;
  // .6 * data.master_gain => pt.t[0].gain; // For individual gain

   pt.t[0].reg(synt0 s0); 
    pt.t[1].reg(synt0 s1); 
     pt.t[2].reg(synt0 s2); 

      pt.adsr0_set(1500::ms, 1000::ms, .8, 3000::ms); // Only works for ADSR 0
       pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

       // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
       "1" +=> pt.tseq[0];
       "3" +=> pt.tseq[1];
       "5" +=> pt.tseq[2];

       pt.go();

       // CONNECTIONS
       pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
       // pt.t[0] $ ST @=> ST @ last; 


while(1) {
       100::ms => now;
}
 
