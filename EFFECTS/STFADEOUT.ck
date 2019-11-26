public class STFADEOUT extends ST {
    ADSR al=> outl;
    ADSR ar => outr;
    
    fun void connect(ST @ tone,  dur d) {    
      al.set(0::ms, d, 0.00000000000000001, 0::ms);
      ar.set(0::ms, d, 0.00000000000000001, 0::ms);
      tone.left() =>  al;
      tone.right() => ar;
      al.keyOn();      
      ar.keyOn();      
    }
}

