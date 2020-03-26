class params {
  float lpffreq;

  fun void print (){
    <<<"LPF FREQ, ", lpffreq>>>;
  }
}


class contfreq extends CONTROL {
  Filter @ fl;
  Filter @ fr;
  Gain @ gin;
  Gain @ gout;

  0 => int active;

  0 =>  update_on_reg ;

  fun void set(float in) {
    if ( ! active  ){
      1 => active;
      gin =< gout;
      gin => fl => gout;
    }

      float f;
      Std.mtof(in) => f;
      if (f>19000) {
        <<<"control_freq TOO HIGH:", f>>>;
      }
      else if (f< 10) {
        <<<"control_freq TOO LOW:", f>>>;
        10 => fl.freq => fr.freq;
      }
      else {

        f => fl.freq => fr.freq;
        <<<"control_freq ", fr.freq()>>>; 
      }
    }

    
  }

} 

class STEQ extends ST {

 Gain ginl => Gain ginlpfl => Gain goutlpfl => outl;

 LPF lpfl;



  // TODO Right side
  Gain ginr; goutlpf => outr;
  

  fun void connect(ST @ tone) {
    tone.left() => ginl;
    tone.right() => ginr;

  }

}
