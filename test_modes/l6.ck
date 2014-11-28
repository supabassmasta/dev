// Get impulse response FFT

SndBuf b => FFT fft_b => blackhole;
10 => b.gain;
//"../../convolution/Claustrofobia v1.1/Coalhod/Coalhod.wav" => b.read;
//"../../convolution/IMreverbs4/Direct_Cabinet_N4.wav" => b.read;
//"../../convolution/IMreverbs4/Deep Space.wav" => b.read;
"../../convolution/flute.wav" => b.read;

<<<"IR sample nb:", b.samples()>>>;

// compute FFT size
512 => int win_size;
b.samples() + 512 => int max_conv_size;

win_size => int fft_size;
while (fft_size < max_conv_size) {
		fft_size * 2 => fft_size;
}

<<<"FFT size:", fft_size>>>; 

fft_size => fft_b.size;

complex ir_fft[fft_size/2];

// Advance time to fill FFT buffer with IR samples;
b.samples()::samp => now;

fft_b.upchuck();
fft_b.spectrum(ir_fft);


class conv_fft extends Chubgraph {

		

 fun void add_window () {
				complex win_fft[fft_size/2];
				inlet => Gain g => FFT fft => blackhole;
				100 => g.gain;
				win_size::samp => now;
				
				fft.upchuck();
				fft.spectrum(win_fft);				

				complex res_fft[fft_size/2];

				//perform the convolution
				for (0 => int i; i < fft_size/2; i++) {
						win_fft[i] * ir_fft[i] => res_fft[i];
//						<<<i, 	win_fft[i], ir_fft[i], res_fft[i]>>>;
				}
				
				//output ifft
				IFFT ifft => outlet; 
				
				ifft.transform(res_fft);
				
				// wait ifft buffer to be empty and exit shred				
				fft_size::samp => now;

		}

		fun void run () {
			while(1) {
				spork ~ add_window();
				win_size::samp  => now;
			}
		}

		spork ~ run();

}


class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.1 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max;
0=> f0.sync;
">c  0_0_5_3_21212" =>     f0.seq;     
f0.freq_seq.adsr.set(2::ms, 20::ms, .4, 100::ms);
f0.reg(synt0 s0);
f0.post() => Gain inter => conv_fft c => dac;
inter => Gain direct => dac;
.0 => direct.gain;

.6 => c.gain;



while(1) {
	     100::ms => now;
}
 


