public class FROG2 extends SYNT{
 

  inlet => Gain gin => SqrOsc s =>  LPF filter => ADSR a => Gain fb => outlet;   
  .125 => gin.gain;  

  a.set(1::ms, 0::ms, 1. , 1::ms);
  fb => Delay d => fb;
  data.tick * 3 / 4 => d.max => d.delay;
  .5 => d.gain; 

  .2 => s.gain;
  .4 => filter.gain;
  // filter to add in graph:
  // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
  Step base => Gain filter_freq => blackhole;
  Gain mod_out => Gain variable => filter_freq;
  SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

  // params
  7 => filter.Q;
   2* 1000 => base.next;
  1400 => variable.gain;
  1::second / (data.tick * 17 ) => mod.freq;
  // If mod need to be synced
  // 1 => int sync_mod;
  // if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

  fun void filter_freq_control (){ 
    while(1) {
      filter_freq.last() => filter.freq;
      1::ms => now;
    }
  }
  spork ~ filter_freq_control (); 



  fun void on()  { a.keyOn(); }  fun void off() {a.keyOff();  }  fun void new_note(int idx)  {   } 0 => own_adsr;

  1 => own_adsr;
} 


