public class digit {
	// Public Var
	0=> float quant; 
	1::samp => dur ech;

	// Private 
	Step out;
	
	// Private
	fun void run(UGen @ in) {
        int div;
        in => blackhole;
        
		while (1) {
        
            if (quant == 0){
                in.last() => out.next;
            }
            else {
                (in.last() / quant) $ int => div;
                div $ float * quant => out.next;
            }
            
            ech => now;
		}
	}

	// Public Func
    fun UGen connect(UGen @ in) {
        spork ~ run(in);
        
        return out;
    }
}