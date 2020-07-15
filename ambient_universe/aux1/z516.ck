
      
      
      
      
      
      1 =>  int nb;




//=======================================================================================
//=======================================================================================
//   
   
//   
//   class synt0 extends SYNT{
//   
//   8 => int synt_nb; 0 => int i;
//   Gain detune[synt_nb];
//   Step det_amount[synt_nb];
//   SinOsc s[synt_nb];
//   Gain final => outlet; .3 => final.gain;
//   
//   inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
//   inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -2.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
//   inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
//   inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
//   inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  2.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
//   
//   
//   
//   
//           fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
//   } 
//   
//      
//             POLYTONE pt;
//             
//             2 => pt.size;
//             
//             // data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;//
//             2 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  
//             
//             // /!\ Not managed for all TONE in POLY TONE
//             //pt.t[0].force_off_action();
//             // pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;
//             
//             pt.lyd();// pt.lyd();//
//             //pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
//             //pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();// 
//   //          pt.full_sync();
//             
//             .7 * data.master_gain =>  pt.gain_common;
//             // .6 * data.master_gain => pt.t[0].gain; // For individual gain
//             
//             pt.t[0].reg(synt0 s0); 
//             pt.t[0].reg(synt0 s1); 
//             pt.t[0].reg(synt0 s2); 
//             pt.t[0].reg(synt0 s3); 
//             
//             pt.t[1].reg(synt0 s4); 
//             pt.t[1].reg(synt0 s5); 
//             pt.t[1].reg(synt0 s6); 
//             pt.t[1].reg(synt0 s7); 
//             
//             //pt.adsr0_set(1500::ms, 1000::ms, .8, 3000::ms); // Only works for ADSR 0
//             //pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//             
//             2 * data.tick => dur a;
//             5 * data.tick => dur r;
//             pt.t[0].adsr[0].set(a, 0::ms, 1., r);
//             pt.t[0].adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//             pt.t[0].adsr[1].set( a, 0::ms, 1.,  r);
//             pt.t[0].adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//             pt.t[0].adsr[2].set( a, 0::ms, 1.,  r);
//             pt.t[0].adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//             pt.t[0].adsr[3].set( a, 0::ms, 1.,  r);
//             pt.t[0].adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//             
//             pt.t[1].adsr[0].set(a, 0::ms, 1., r);
//             pt.t[1].adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//             pt.t[1].adsr[1].set( a, 0::ms, 1.,  r);
//             pt.t[1].adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//             pt.t[1].adsr[2].set( a, 0::ms, 1.,  r);
//             pt.t[1].adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//             pt.t[1].adsr[3].set( a, 0::ms, 1.,  r);
//             pt.t[1].adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//             
//             // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//             "
//             1|3|5|8 1|3|5|8
//             1|3|5|8 1|3|5|8
//             1|3|5|8 1|3|5|8
//             1|3|5|8_
//             
//             __
//             __
//             __
//             __
//             
//            
//             " +=> pt.tseq[0];
//             
//             "
//             __
//             __
//             __
//             __
//             
//             5|^7|a|c 5|^7|a|c
//             5|^7|a|c 5|^7|a|c
//             5|^7|a|c 5|^7|a|c
//             5|^7|a|c_
//       
//          
//             " +=> pt.tseq[1];
//             
//   
//             
//             pt.go();
//             
//             // CONNECTIONS
//             pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
//             // pt.t[0] $ ST @=> ST @ last; 
//      
//      
//      //=======================================================================================
//      //=======================================================================================
//      
//      
//            "____ ____ ____ ____" +=> pt.tseq[0]; "____ ____ ____ ____" +=> pt.tseq[1];
//          
//             STREC strec;
//             strec.connect(last $ ST, 32*data.tick, "../../_SAMPLES/ambient_universe/pads" + nb + ".wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); strec $ ST @=>  last;  
//      
   

//=======================================================================================
//=======================================================================================


     LOOP_DOUBLE_WAV_SYNC l;
     "../../_SAMPLES/ambient_universe/pads" + nb + ".wav" => l.read;
     1.0 * data.master_gain => l.buf.gain => l.buf2.gain;
     l.AttackRelease(1 * data.tick, 5 * data.tick);
     l.start(1 * data.tick /* sync */ ,   4 * data.tick /* END sync */ ,  16 * data.tick /* loop */); l $ ST @=> ST @ last;   
     
     
     STGVERB stgverb;
     stgverb.connect(last $ ST, .2 /* mix */, 9 * 10. /* room size */, 12::second /* rev time */, 0.4 /* early */ , 0.8 /* tail */ ); stgverb $ ST @=>  last; 
//   
  
while(1) {
       100::ms => now;
}
 
