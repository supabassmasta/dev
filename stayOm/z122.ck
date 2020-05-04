class nirx extends note_info_rx {
  PowerADSR @ pa;  
  float rel_attack;
  float rel_decay;
  float sustain;
  float rel_release;
  float rel_release_pos;
  0 => int off_cnt;

  fun void off(int nb, dur att_dec_sus) {
    att_dec_sus => now;
    if (nb == off_cnt) {
      pa.keyOff();
//            <<<"OFF: ", nb>>>;
    }
    // else skip, new note already ongoing
    //    else {
    //      <<<"OFF skipped: ", nb, "off_cnt :", off_cnt>>>;
    //    }
  }

  fun void push(note_info_t @ ni ) {
    if(ni.on) {
      pa.set(rel_attack * ni.d , rel_decay * ni.d , sustain, rel_release * ni.d);
      1. / sustain => pa.gain;
      pa.keyOn();

      1 +=> off_cnt;
      spork ~ off( off_cnt,  ni.d + (rel_release_pos*ni.d) );
    }
  }

}


class ADSRMOD {

  Step stp => PowerADSR padsr;
  1. => stp.next;

  nirx nio;
  padsr @=> nio.pa;
  fun void connect(SYNT @ synt, note_info_tx @ ni_tx) {

    3 => synt.inlet.op;
    padsr => synt.inlet;

    // Register note info rx in tx
    ni_tx.reg(nio);

  }

  fun void adsr_set(float ra, float rd, float sustain, float rr_pos, float rr) {
    ra => nio.rel_attack;
    rd => nio.rel_decay;
    sustain => nio.sustain;
    rr_pos => nio.rel_release_pos;
    rr => nio.rel_release;
  }

}

class synt0 extends SYNT{
8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => TriOsc s2 => final;    1. => detune[i].gain;    .8 =>s2.gain; i++;  
inlet => detune[i] => s[i] => final;    2. => detune[i].gain;    .5 => s[i].gain; i++;  

fun void on()  {   0. => s[0].phase => s[2].phase =>  s2.phase;
}  fun void off() { }  fun void new_note(int idx)  {
  
  } 0 => own_adsr;
}

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c*4 111_  " => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, 1., 20::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ADSRMOD adsrmod;
adsrmod.adsr_set(0.02 /* relative attack dur */, 0.2 /* relative decay dur */ , 0.3 /* sustain */, - 0.5 /* relative sustain pos */, .3 /* relative sustain dur */);
adsrmod.padsr.setCurves(1., 2., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */);

while(1) {
       100::ms => now;
}
 
