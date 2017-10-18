public class STFADEIN extends ST {
    ADSR al=> outl;
    ADSR ar => outr;
    
    fun void connect(ST @ tone,  dur d) {    
      al.set(d, 0::ms, 1., 100::ms);
      ar.set(d, 0::ms, 1., 100::ms);
      tone.left() =>  al;
      tone.right() => ar;
      al.keyOn();      
      ar.keyOn();      
    }
}

