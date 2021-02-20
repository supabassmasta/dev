public class SYNTLAB {

  fun void go (SYNT @ sL, SYNT @ sR ,int sn,int ln,dur nd,dur att,dur rel,string bn ) {
    sn => int start_note;
    ln => int last_note;

    nd => dur note_dur;

    att => dur attack;
    rel => dur release;

    bn => string base_name;

    // INPUT
    ST stin;

    Step freq =>  sL => stin.outl;
         freq =>  sR => stin.outr;


    stin $ ST @=> ST @ last; 

    STADSR stadsr;
    stadsr.set(attack /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur */,  release /* release */);
    stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 


    STREC strec;
    1 => int first;
    for (start_note=> int i; i <  last_note + 1  ; i++) {

      Std.mtof(i) => freq.next;
      1::samp => now;

      stadsr.keyOn();

      if ( first  ){
        strec.connect(last $ ST, note_dur, base_name + i + ".wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  
        0 => first;
      }
      else {
        strec.rec(note_dur, base_name + i + ".wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  
      }

      note_dur - release => now; 
      stadsr.keyOff();

      release => now;

    }

    <<<">>>>>>>>>>>>>>>>>>>>>>>">>>;
    <<<">>  END REC SESSION  >>">>>;
    <<<">>>>>>>>>>>>>>>>>>>>>>>">>>;
    10::ms => now;

  }
}

