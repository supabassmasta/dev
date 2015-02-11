// Get impulse response FFT

SndBuf b => FFT fft_b => blackhole;
3 => b.gain;
//"../../chuck-1.3.3.0/examples/data/kick.wav" => b.read;
"../../convolution/IMreverbs4/Direct_Cabinet_N4.wav" => b.read;
//"../../convolution/IMreverbs4/Deep Space.wav" => b.read;
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





TriOsc s => ADSR adsr => Gain inter => conv_fft c =>  dac;
inter => Gain direct => dac;
.4 => direct.gain;
.4 => c.gain;

adsr.set(10::ms, 10::ms, .7, 50::ms);
.2 => s.gain;

while(1) {

	  Std.mtof(64) => s.freq; adsr.keyOn();  200::ms => now;
		adsr.keyOff(); 400::ms=> now;
	  Std.mtof(71) => s.freq; adsr.keyOn();  200::ms => now;
		adsr.keyOff(); 400::ms=> now;
	  Std.mtof(64) => s.freq; adsr.keyOn();  200::ms => now;
		adsr.keyOff(); 400::ms=> now;
	  Std.mtof(73) => s.freq; adsr.keyOn();  200::ms => now;
		adsr.keyOff(); 400::ms=> now;
}
 


