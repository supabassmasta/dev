class buffer {
       Gain in => ADSR buf_in => Gain fb => ADSR buf_out => Gain out;
       fb => Delay d => fb;
       
	d.gain(1.);
       
       buf_in.set(3::ms, 0::ms, 1, 3::ms);
       buf_out.set(3::ms, 0::ms, 1, 3::ms);
       buf_in.keyOn();
       buf_out.keyOn();

       // init default values
       500::ms => d.max;
       500::ms=> d.delay;
       
       
        fun void open_in () {buf_in.keyOn();}
        fun void open_out () {buf_out.keyOn();}
        fun void close_in () {buf_in.keyOff();}
        fun void close_out () {buf_out.keyOff();}
    
        fun void update_delay (dur new_d){
            new_d => d.delay;
        }
        fun void update_max_delay (dur new_d){
            new_d => d.max;
        }

        fun UGen connect (UGen @ input){
            input => in;
            
            return out;
        }
        
        fun void diconnect() {
            buf_out =< out;
        }
    
    }

public class sampler {

    Gain in;
    Gain out;

    dur max;
    dur length;
    
    // buff class
    buffer @ array [0];
    

    fun UGen connect (UGen @ input){
        input => in;
        
        return out;
    }
    

    fun void add () {
         new buffer @=> buffer @ temp;
         temp.update_max_delay(max);
         temp.update_delay(length);
         in => temp.connect => out;
        // buffer  temp;
         array << temp;
    }

    fun void remove_last () {
        if (array.size() > 0) {
        
        array[array.size()-1].close_out ();
        3::ms => now;
        array[array.size()-1].diconnect ();
        // pop element
        // array.size()-1=>array.size;
        array.popBack();
        }
        
    }    

}

// TEST
/*sampler sp;

SinOsc s => sp.connect => LPF lpf => dac;
.1 => lpf.gain;
800 => lpf.freq;
440=> s.freq;

1::second => sp.max;
1::second => sp.length;
 sp.add();

100::ms => now;
 0.=> s.gain;
sp.array[0].close_in();
100::ms => now;
 sp.add();
1. => s.gain;
660 => s.freq;
100::ms => now;
 0.=> s.gain;

3::second=> now;
sp.array[0].close_out();

3::second=> now;

spork ~ sp.remove_last (); 
1::second=> now;
 <<<sp.array.size()>>>;
sp.array[0].open_out();

while (1) 100::ms => now;
*/


