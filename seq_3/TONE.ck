public class TONE {

		SYNT synt[0];
    Envelope env[0];
    ADSR adsr[0];

    // input for all env
    Step one;
		1. => one.next;


		Gain out  => Pan2 pan => dac;
    Gain raw_out;
    .2 => raw_out.gain;

		fun void reg(SYNT @ in) {
        Envelope @ e;
        ADSR @ a;

  			synt << in;
        
        new Envelope @=> e;
        env << e;
        
        new ADSR @=> a;
        adsr << a;
        a.set(3::ms, 0::ms, 1., 3::ms);
        .2 => a.gain;

				one => e => in => a => out;
        in => raw_out;
		}



    // function to get audio out of object
    // only one of this to use at a time
    Gain mono_out;
    fun UGen mono() {
					out =< pan;
					out => mono_out;

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
				pan =< dac;
				pan.right => right_out;
        return right_out;
    }

		// raw signal, no adsr
    fun UGen raw() {
				out =< pan;
				raw_out=> mono_out;

        return mono_out;
    }

			

}

// TEST
/*
TONE t;
t.reg(HORROR h);
//t.mono() => NRev r => dac;
//.3 => r.mix;
//  1 => t.pan.pan;
//  t.right() => dac;
		// TODO : TO REMOVE
		220 => t.env[0].value;
//		t.adsr[0].keyOn();
t.raw() => dac;
while(1) {
	     100::ms => now;
}
 */
