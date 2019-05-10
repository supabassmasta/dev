  class control_gain extends CONTROL {
    Delay @ dlp;
    Delay @ drp;

    1 => update_on_reg ;
    
    fun void set (float in) {
      in / 100. =>  dlp.gain => drp.gain;
      <<<"control_gain ", dlp.gain()>>>;

    }
  }

  class control_freq extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    HPF @ hl;
    HPF @ hr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      float f;

      if ( in < 64  ){
        // Open HPF
        10 => hl.freq => hr.freq;

        Std.mtof(in * 2) => f;
        if (f>19000) {
          <<<"LPF control_freq TOO HIGH:", f>>>;
          19000 => fl.freq => fr.freq;
        }
        else if (f< 10) {
          <<<" LPF control_freq TOO LOW:", f>>>;
          10 => fl.freq => fr.freq;
        }
        else {
          f => fl.freq => fr.freq;
          <<<"LPF control_freq ", fr.freq()>>>; 
        }
      }
      else {
        // Open LPF
        19000 => fl.freq => fr.freq;
        Std.mtof((in - 64) * 2) => f;
        if (f>19000) {
          <<<"HPF control_freq TOO HIGH:", f>>>;
          19000 => hl.freq => hr.freq;
        }
        else if (f< 10) {
          <<<" HPF control_freq TOO LOW:", f>>>;
          10 => hl.freq => hr.freq;
        }
        else {
          f => hl.freq => hr.freq;
          <<<"HPF control_freq ", hr.freq()>>>; 
        }



      }
    }

  }

  class control_q extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    HPF @ hl;
    HPF @ hr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q => hl.Q => hr.Q;

      <<<"control_Q ", fr.Q()>>>; 
    }
  }

class STECHOLHPFC extends ST{
  Gain fbl => outl;
  fbl => Delay dl => LPF lpfl => HPF hpfl => fbl;
  
  Gain fbr => outr;
  fbr => Delay dr => LPF lpfr => HPF hpfr => fbr;

  0. =>  dl.gain => dr.gain;
  data.tick => dl.max => dl.delay => dr.max => dr.delay;

  control_gain cgain;
  dr @=> cgain.drp; 
  dl @=> cgain.dlp; 



  1000 => lpfl.freq;
  1000 => lpfr.freq;
  1 => lpfl.Q;
  1 => lpfr.Q;

  0 => hpfl.freq;
  0 => hpfr.freq;
  1 => hpfl.Q;
  1 => hpfr.Q;

  control_freq cfreq;
  lpfl @=> cfreq.fl;
  lpfr @=> cfreq.fr;
  hpfl @=> cfreq.hl;
  hpfr @=> cfreq.hr;

  control_q cq;
  lpfl @=> cq.fl;
  lpfr @=> cq.fr;
  hpfl @=> cq.hl;
  hpfr @=> cq.hr;


  fun void connect(ST @ tone, CONTROLER f, CONTROLER q, dur d, CONTROLER g) {
    tone.left() => fbl;
    tone.right() => fbr;

    g.reg(cgain);
    d => dl.max => dl.delay => dr.max => dr.delay;


    f.reg(cfreq);
    if(q != NULL){
      q.reg(cq);
    }
  }


}

SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"
s___
" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STHPF hpf;
hpf.connect(last $ ST , 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STECHOLHPFC lpfc;
lpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */ , data.tick * 3. / 4. , HW.lpd8.potar[1][3] /* Delay Gain */ );       lpfc $ ST @=>  last; 

//STLHPFC lhpfc;
//lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 

STLPFC lpfc2;
lpfc2.connect(last $ ST , HW.lpd8.potar[1][5] /* freq */  , HW.lpd8.potar[1][6] /* Q */  );       lpfc2 $ ST @=>  last; 

last.mono() => Dyno dy => dac;
dy.limit();
0.0 => dy.slopeAbove;

.5 => dy.gain;

while(1) {
       100::ms => now;
}
 

