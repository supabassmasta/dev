public class lpf_vcf_light {
    Gain in;
    Gain out;

    LPF lpf_filter_u;
    lpf_filter_u.freq(300);

    fun UGen connect(UGen @ u)
    {
        int i;
        
        u => in => lpf_filter_u => out; 
        
        return out;
    }

	fun void update_freq(UGen @ freq_in) {
	
		while (1) {
			Std.mtof(freq_in.last()) => lpf_filter_u.freq;

           if (lpf_filter_u.freq() <= 1)
           {
				lpf_filter_u.freq(1);
                in.gain(0);
                out.gain(0);
           }
           else
           {
                in.gain(1);
                out.gain(1);
           }
			
           1::samp => now;
		}
	}
	
	fun void update_Q(UGen @ Q_in) {
	
		while (1) {
			Q_in.last()/24 => lpf_filter_u.Q;
			
			1::samp => now;
		}
	}
	
	fun void freq_ctrl (UGen @ freq_in) {
		freq_in => blackhole;
		spork ~ update_freq(freq_in);
	}
	
	fun void Q_ctrl (UGen @ Q_in) {
		Q_in => blackhole;
		spork ~ update_Q(Q_in);
	}
	
	
}

/*
lpf_vcf_light vcf;

SqrOsc s => vcf.connect => dac;
s.gain(0.3);

Phasor p => vcf.freq_ctrl;
p.gain(127);
p.freq(0.5);


Phasor p2 => vcf.Q_ctrl;
p2.gain(127);
p2.freq(0.1);

while(1) {1::ms => now; <<<vcf.lpf_filter_u.freq()>>>;}

*/