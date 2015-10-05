public class TONE {

		SYNT synt[0];

		Step one => Envelope env;
		1. => one.next;


		Gain out => ADSR adsr => Pan2 pan => dac;
		adsr.set(3::ms, 0::ms, 1., 3::ms);
		.2 => adsr.gain;

		fun void reg(SYNT @ in) {
				synt << in;

				env => in => out;
		}



    // function to get audio out of object
    // only one of this to use at a time
    Gain mono_out;
    fun UGen mono() {
					adsr =< pan;
					adsr => mono_out;

        return mono_out;
    }

    Gain left_out;
    fun UGen left() {
				pan =< dac;
				pan.left => left_out;
        return left_out;
    }
    Gain right_out;
    fun UGen right() {
				pan.right => right_out;
        return right_out;
    }

		// raw signal, no adsr
    fun UGen raw() {
				out =< adsr;
				out => mono_out;

        return mono_out;
    }

			

}

// TEST
/*
TONE t;

t.reg(GRAIN g);
t.reg(HORROR h);
		// TODO : TO REMOVE
		110 => t.env.value;
		t.adsr.keyOn();
while(1) {
	     100::ms => now;
}
 
*/

