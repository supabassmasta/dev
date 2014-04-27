class SEQ_STR {

0. => float max_v;//private
0. => float remaining;//private

fun void max(float in){
		in => max_v => remaining;
}

fun float set_dur(float in_dur){// private
		float res;
		if (max_v == 0.)
			return in_dur;
		else {
			if (in_dur >= remaining){
				remaining => res;
				0. => remaining;
			}
		  else {
				in_dur => res;
				remaining - in_dur => remaining;
			}

			return res;
		}
}

seqSndBuf seq_main[5];
string    seq_special[0];
Gain final => dac;
.2 => final.gain;

fun void reg(int nb, string in){

		if (nb>4) <<<"ERROR, maximum 5 main sequences in SEQ_STR\n">>>;
		else {
			seq_main[nb] => final;
			1. => seq_main[nb].gain;
			in => seq_main[nb].read;
			data.bpm =>seq_main[nb].bpm;
			0 =>seq_main[nb].sync_on;
		}
}

fun void gain(int nb, float g){
		 g=> seq_main[nb].gain;
}

fun void reg(string  char , string in){
			new seqSndBuf => seq_main[char];
			seq_special << char;
			seq_main[char] => final;
			1. => seq_main[char].gain;
			in => seq_main[char].read;
			data.bpm =>seq_main[char].bpm;
			0 => seq_main[char].sync_on;
}

fun void gain(string  char, float g){
		 g=> seq_main[char].gain;
}

fun int special_exists(string char){
	for (0 => int i; i < seq_special.size()      ; i++) {
		if (char == seq_special[i]) return 1;
	}

	return 0;

}

fun int get_seq_main(int c) {
		 if ((c >= '0') && (c <= '9')) 
			 return  0;
		else if	 ((c >= 'a') && (c <= 'j')) 
			 return  1;
		else if	((c >= 'A') && (c <= 'J'))
				 return 2;
		else if	((c >= 'k') && (c <= 't'))
				 return 3;
		else if	((c >= 'K') && (c <= 'T'))
				 return 5;
		else
				return -1;

}

fun float get_seq_main_gain(int c) {
	  	0 => int val;
		 if ((c >= '0') && (c <= '9')) 
			 c - '0' => val;
		else if	 ((c >= 'a') && (c <= 'j')) 
			 c - 'a' => val;
		else if	((c >= 'A') && (c <= 'J'))
			 c - 'A' => val;
		else if	((c >= 'k') && (c <= 't'))
			 c - 'k' => val;
		else if	((c >= 'K') && (c <= 'T'))
			 c - 'K' => val;
		else
				return 0.;

		return ((val $ float) + 1.) / 10. ;


}

fun int convert_note(int c) {
		 if ((c >= '0') && (c <= '9')) 
			 return  c - '0';
		else if	 ((c >= 'a') && (c <= 'z')) 
			 return  c - 'a' + 10;
		else if	((c >= 'A') && (c <= 'Z'))
				 return -1 - (c - 'A');
		else
				return 0;

}
fun void set_main(int nb, float g, float d, float r){
		int i;

				for (0 => i; i < 5; i++) {
					if (i == nb)
						seq_main[i].g << g;
					else
						seq_main[i].g << 0.;

				  seq_main[i].rel_dur << d;
				  seq_main[i].r << r;
				}
}


fun void seq(string in) {
		0=> int i;
		int c;
		1. => float g;

		1. => float duration;// private

		// reset remaining
		max_v => remaining;

		while(i< in.length()) {

				in.charAt(i)=> c;
//		<<<"c", c>>>;	
		  	if (c == ' ' ){
					// do nothing
				}
//			  else if (special_exists(c) ) { }
			  else if ( get_seq_main(c) != -1 ) { 
						set_main(get_seq_main(c), get_seq_main_gain(c), set_dur(duration), 1.);
				
				}
				else if (in.charAt(i) == '_') {
						set_main(-1, 0., set_dur(duration), 1.);
				}
				else if (in.charAt(i) == '*') {
						i++;
						in.charAt(i)=> c;
						duration /( (convert_note (c) ) $ float) => duration;
				}
				else if (in.charAt(i) == ':') {
						i++;
						in.charAt(i)=> c;
						duration * ( (convert_note (c)  ) $ float) => duration;
				}
					
	      i++;	
		}
		

}

		fun void go(){
				for (0 => int i; i <  5     ; i++) {
					seq_main[i].go();	
				
				}
				 
		}

}

SEQ_STR s0;

s0.reg(0, "../_SAMPLES/amen_kick.wav");
s0.reg(1, "../_SAMPLES/amen_snare.wav");
s0.reg(2, "../_SAMPLES/amen_snare2.wav");
s0.reg(3, "../_SAMPLES/amen_hit.wav");
//0 => s0.sync_on;

"*8 3_l_ d_lE  lE3l d_ll" => s0.seq;
"*8 3_3_ d_lE  lE3l d_ll" => s0.seq;
"*8 3__3 d_3E  lE3l d_ll" => s0.seq;
4 => s0.max;
"*4 d33d33*2d3d_dlld3_3ld_ld_dd____________" => s0.seq;
s0.go();



while(1) { 100::ms => now; }
 //data.meas_size * data.tick => now;
 
