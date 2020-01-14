public class STAUTOPAN extends ST{
    Envelope el => outl;
    Envelope er => outr;
    float s;
    dur p;
    float ph;

    1. => el.value =>  er.value;

    fun void f1 (){ 
      1. + s => float tarl;
      1. - s => float tarr;
      1 => int up;

      if (ph < .25) {
        
        1. + ph * 4 * s => el.value;
        1. - ph * 4 * s => er.value;
        1. + s => tarl;
        1. - s => tarr;
        p/4 - p*ph => el.duration ;
        p/4 - p*ph => er.duration;
        1 => up;
        
      }
      else if (ph < .75){
        1. + s - (ph - .25)*4*s => el.value;
        1 -s + (ph - .25)*4*s => er.value;
        1. - s => tarl;
        1. + s => tarr;
        p*3/4 - p*ph => el.duration ;
        p*3/4 - p*ph => er.duration;
        0 => up;

      }
      else if (ph <= 1.){
        1. - s + (ph - .75) * 4 * s => el.value;
        1. + s - (ph - .75) * 4 * s => er.value;
        1. + s => tarl;
        1. - s => tarr;
        p - p*ph => el.duration ;
        p - p*ph => er.duration;
        1 => up;
      }
      else{ // > 1 error case
        // do nothing 
      }

      while(1) {
         if (up ){
           1. - s => tarr;
           1. + s => tarl;
           0 => up;
         }
         else {
           1.+s => tarr;
           1.-s => tarl;
           1 => up;
         }

         tarl => el.target;
         tarr => er.target;
         p/2 => el.duration ;
         p/2=> er.duration;
//         el.keyOn();
//         er.keyOn();

         p/2 => now;

      }
       
    } 
        
    fun void connect(ST @ tone, float span, dur period, float phase) {    
      tone.left() =>  el;
      tone.right() => er;
       span => s;
       period => p;
       phase => ph;
       spork ~ f1 ();

    }
    
}

