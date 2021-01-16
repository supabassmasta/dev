class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}


TONE t;
t.reg(SERUM1 s0);  //data.tick * 8 => t.max; /
171::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.add(13 /* synt nb */ , 0 /* rank */ , 0.1 /* GAIN */, 1.0 /* in freq gain */, 20::ms /* attack */, 2 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
s0.add(13 /* synt nb */ , 0 /* rank */ , 0.1001 /* GAIN */, 1.0 /* in freq gain */, 20::ms /* attack */, 2 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
s0.add(13 /* synt nb */ , 0 /* rank */ , 0.998 /* GAIN */, 1.0 /* in freq gain */, 20::ms /* attack */, 2 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
s0.add(27 /* synt nb */ , 0 /* rank */ , 0.1 /* GAIN */, 0.5 /* in freq gain */, 3 * data.tick /* attack */, 2 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"1///1_ ____" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//    class nirx extends note_info_rx {
//      PowerADSR @ pa;  
//      float rel_attack;
//      float rel_decay;
//      float sustain;
//      float rel_release;
//      float rel_release_pos;
//      0 => int off_cnt;
//    
//      fun void off(int nb, dur att_dec_sus) {
//        att_dec_sus => now;
//        if (nb == off_cnt) {
//          pa.keyOff();
//    //            <<<"OFF: ", nb>>>;
//        }
//        // else skip, new note already ongoing
//        //    else {
//        //      <<<"OFF skipped: ", nb, "off_cnt :", off_cnt>>>;
//        //    }
//      }
//    
//      fun void push(note_info_t @ ni ) {
//        if(ni.on) {
//          pa.set(rel_attack * ni.d , rel_decay * ni.d , sustain, rel_release * ni.d);
//          pa.keyOn();
//    
//          1 +=> off_cnt;
//          spork ~ off( off_cnt,  ni.d + (rel_release_pos*ni.d) );
//        }
//      }
//    
//    }
//    
//    
//    class ADSRMOD2 {
//    
//      Step stp => Gain out;
//      Gain in => PowerADSR padsr => out;
//      1. => stp.next;
//    
//      nirx nio;
//      padsr @=> nio.pa;
//      fun void connect(SYNT @ synt, note_info_tx @ ni_tx) {
//    
//        3 => synt.inlet.op;
//        out => synt.inlet;
//    
//        // Register note info rx in tx
//        ni_tx.reg(nio);
//    
//      }
//    
//      fun void adsr_set(float ra, float rd, float sustain, float rr_pos, float rr) {
//        ra => nio.rel_attack;
//        rd => nio.rel_decay;
//        sustain => nio.sustain;
//        rr_pos => nio.rel_release_pos;
//        rr => nio.rel_release;
//      }
//    
//    }

//    ADSRMOD2 adsrmod;
//    adsrmod.adsr_set(0.2 /* relative attack dur */, 0.5 /* relative decay dur */ , 0.001 /* sustain */, - 0.5 /* relative sustain pos */, .3 /* relative sustain dur */);
//    adsrmod.padsr.setCurves(1., 2., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
//    adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 
//    // => adsrmod.in; // CONNECT this /!\ WARNING Modulator Gain to set as ratio of main frequeny example 0.1

ADSRMOD2 adsrmod; // Freq input modulation with external input and ADSR
adsrmod.adsr_set(0.2 /* relative attack dur */, 1.9 /* relative decay dur */ , 0.001 /* sustain */,  0.5 /* relative sustain pos */, .3 /* relative sustain dur */);
adsrmod.padsr.setCurves(1., 1., 1.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 
// => adsrmod.in; // CONNECT this /!\ WARNING Modulator Gain to set as ratio of main frequeny example 0.1 

SinOsc sin0 =>   adsrmod.in; // CONNECT this
77.0 => sin0.freq;
28 * 0.01 => sin0.gain;

//adsrmod.out => Gain g => dac;
//.1 => g.gain;

STLHPFC lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
