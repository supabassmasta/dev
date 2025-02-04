//<<<"WARNING: MULTIREC ERROR 'illegal token' above not problematic...">>>;

public class MULTIREC {
  ST probe[0]; // will be inserted in the code
  ST in[0];
  STREC strec[0];
  string track_name[0];
  1::second => dur rec_dur;
  0 => int disable;

  fun void  add_track (string name){ 
     if ( ! disable  ){
       track_name << name;
       new STREC @=> strec[name];
       new ST @=> in[name];
     }
  } 

  fun void  _rec  (){ 
     if ( ! disable  ){
       for (0 => int i; i < track_name.size()  ; i++) {
         <<<"Start rec" + track_name[i]>>>;

         strec[track_name[i]].connect(in[track_name[i]], rec_dur, track_name[i], 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ );
       }
       rec_dur + 10::ms => now; 
     }
  } 

  
  fun void  rec (){ 
     if ( ! disable  ){
       spork ~   _rec (); 
    }
  } 

  fun ST @ rec_on_track(ST @ inpt, string n) {
     if ( ! disable  ){
       1 => int not_exist;
       for (0 => int i; i <  track_name.size() &&  not_exist    ; i++) {
         if (track_name[i] == n) 0 => not_exist;
       }
       if ( not_exist  ){
         <<<"!!! ERROR MULTIREC: " + n + " not created (add_track()) !!!">>>;
         new ST @=> ST @ st;
         return st;
       }
       else {
         new ST @=> ST @ st;
         probe << st;
         inpt.left() => st.outl;
         inpt.right() => st.outr;
         st.outl => in[n].outl;
         st.outr => in[n].outr;
         return st;
       }


    }
    else {
      // if disabled return input => passthrough
      return inpt;
    }
  }
}


