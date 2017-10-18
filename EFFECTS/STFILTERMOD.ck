public class STFILTERMOD extends ST {
  FilterBasic @ filterl;
  FilterBasic @ filterr;
  0 => int filter_connected;

  // filter to add in graph:
  // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
  Step base => Gain filter_freq => blackhole;
  Gain mod_out => Gain variable => filter_freq;
  SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

  // params
//    // If mod need to be synced
  // 1 => int sync_mod;
  // if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

  fun void filter_freq_control (){ 
    while(1) {
      filter_freq.last() => filterl.freq => filterr.freq;
      1::ms => now;
    }
  }

  fun void connect(ST @ tone, string filter_in, float q, float f_base, float f_var, float f_mod) {    
    if (filter_in == "LPF"){
        new LPF @=> filterl;
        new LPF @=> filterr;
        tone.left() => filterl;
        tone.right() =>filterr;
        
        q => filterl.Q;
        q => filterr.Q;
        f_base => base.next;
        f_var => variable.gain;
        f_mod => mod.freq;

        if ( ! filter_connected ){
           filterl => outl;  
           filterr => outr;
           1 => filter_connected;
           spork ~ filter_freq_control (); 
        }
    }
    if (filter_in == "BPF"){
        new BPF @=> filterl;
        new BPF @=> filterr;
        tone.left() => filterl;
        tone.right() =>filterr;
        
        q => filterl.Q;
        q => filterr.Q;
        f_base => base.next;
        f_var => variable.gain;
        f_mod => mod.freq;

        if ( ! filter_connected ){
           filterl => outl;  
           filterr => outr;
           1 => filter_connected;
           spork ~ filter_freq_control (); 
        }
    }
    if (filter_in == "HPF"){
        new HPF @=> filterl;
        new HPF @=> filterr;
        tone.left() => filterl;
        tone.right() =>filterr;
        
        q => filterl.Q;
        q => filterr.Q;
        f_base => base.next;
        f_var => variable.gain;
        f_mod => mod.freq;

        if ( ! filter_connected ){
           filterl => outl;  
           filterr => outr;
           1 => filter_connected;
           spork ~ filter_freq_control (); 
        }
    }

    if (filter_in == "BRF"){
        new BRF @=> filterl;
        new BRF @=> filterr;
        tone.left() => filterl;
        tone.right() =>filterr;
        
        q => filterl.Q;
        q => filterr.Q;
        f_base => base.next;
        f_var => variable.gain;
        f_mod => mod.freq;

        if ( ! filter_connected ){
           filterl => outl;  
           filterr => outr;
           1 => filter_connected;
           spork ~ filter_freq_control (); 
        }
    }

    if (filter_in == "ResonZ"){
        new ResonZ @=> filterl;
        new ResonZ @=> filterr;
        tone.left() => filterl;
        tone.right() =>filterr;
        
        q => filterl.Q;
        q => filterr.Q;
        f_base => base.next;
        f_var => variable.gain;
        f_mod => mod.freq;

        if ( ! filter_connected ){
           filterl => outl;  
           filterr => outr;
           1 => filter_connected;
           spork ~ filter_freq_control (); 
        }
    }




    }
}

