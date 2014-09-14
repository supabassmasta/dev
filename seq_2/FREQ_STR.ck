public class FREQ_STR {

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

FREQ2 freq_seq;

0=> freq_seq.sync_on;

fun void sync(int in) {in => freq_seq.sync_on ;}
fun void stop() { freq_seq.stop(); }
freq_seq.adsr @=> ADSR @ adsr;

data.ref_note => freq_seq.base_note;
data.scale.my_string => freq_seq.scale;
data.bpm => freq_seq.bpm;

fun int is_note(int c) {
		 if (((c >= '0') && (c <= '9')) || 
			   ((c >= 'a') && (c <= 'z')) ||
				 ((c >= 'A') && (c <= 'Z')))
				return 1;
		else
				return 0;

}

fun int convert_note(int c) {
		 if ((c >= '0') && (c <= '9')) 
			 return  c - '0';
		else if	 ((c >= 'a') && (c <= 'z')) 
			 return  c - 'a' + 10;
		else if	((c >= 'A') && (c <= 'Z'))
				 return -1 - (c - 'A');
		else
				return 1;

}

fun void seq(string in) {
		0=> int i;
		int c;
		1. => float g;
		0 => int force;
		0 => int note_offset_v;
		1. => float duration;// private

		// reset remaining
		max_v => remaining;
		
		while(i< in.length()) {

				in.charAt(i)=> c;
//		<<<"c", c>>>;	
		  	if (c == ' ' ){
					// do nothing
				}
				else if (is_note(c) ) {
					  // Check slide
						0 => int slide_dur;
						while ( (i + 1< in.length() ) && 	(in.charAt(i + 1) == '/') )
						{
								slide_dur++;
								i++;
						}

						if (slide_dur) {
//								<<<"slide_dur", slide_dur>>>;
								// init freq with note at dur == 0		
							freq_seq.rel_note  << convert_note(c);
							freq_seq.g         << g; 
							freq_seq.rel_dur   << 0.;
							freq_seq.force_new_note << force;
							freq_seq.slide << 0;
							freq_seq.note_offset << note_offset_v;
							0 => force;
								
							// get next note
							i++;
							if ( (i < in.length() ) && (is_note(	in.charAt(i) )  ) ) 
									freq_seq.rel_note  << convert_note(in.charAt(i));
						  else 
									freq_seq.rel_note  << 0;	
							freq_seq.g         << g; 
							freq_seq.rel_dur   << set_dur(slide_dur * duration);
							freq_seq.force_new_note << force;
							freq_seq.slide << 1;
							freq_seq.note_offset << note_offset_v;
						}
						else {
							freq_seq.rel_note  << convert_note(c);
							freq_seq.g         << g; 
							freq_seq.rel_dur   << set_dur(duration);
							freq_seq.force_new_note << force;
							freq_seq.slide << 0;
							freq_seq.note_offset << note_offset_v;
							0 => force;
						}
				}
				else if (in.charAt(i) == '_') {
						freq_seq.rel_note  << 0;
						freq_seq.g         << .0; 
					  freq_seq.force_new_note << 0;
						freq_seq.rel_dur   << set_dur(duration);
						freq_seq.slide << 0;
						freq_seq.note_offset << note_offset_v;
				}
				else if (in.charAt(i) == '|') {
						1 => force;		

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
				else if (in.charAt(i) == '+') {
						i++;
						in.charAt(i)=> c;
						g + convert_note (c)* 0.05 => g;
				}
				else if (in.charAt(i) == '-') {
						i++;
						in.charAt(i)=> c;
						if (g < 0.1)
							g - convert_note (c)* 0.01 => g;
						else
							g - convert_note (c)* 0.05 => g;
				}
				else if (in.charAt(i) == '>') {
						i++;
						in.charAt(i)=> c;
						note_offset_v +  convert_note (c) => note_offset_v;
				}
				else if (in.charAt(i) == '<') {
						i++;
						in.charAt(i)=> c;
						note_offset_v -  convert_note (c) => note_offset_v;
				}
				i++;
		}
// DEBUG
/*
for (0 => int j; j < freq_seq.rel_note.size()      ; j++) {
		<<<"freq_seq.rel_note[j]      ",freq_seq.rel_note[j]      >>>;
		<<<"freq_seq.g[j]             ",freq_seq.g[j]             >>>;
		<<<"freq_seq.force_new_note[j]",freq_seq.force_new_note[j]>>>;
		<<<"freq_seq.rel_dur[j]       ",freq_seq.rel_dur[j]       >>>;
		<<<"freq_seq.slide[j]       ",freq_seq.slide[j]       >>>;
}
 */

}

// OUTPUT
Gain gain_out => dac;
.3 => gain_out.gain;
// On off synt_def management
fun void reg (SYNT @ in){
		freq_seq.reg(in);
		freq_seq.freq => in => freq_seq.adsr => gain_out;
		freq_seq.go();
}

fun UGen post() {
		gain_out =< dac;
		return gain_out;
}

}
/* TEST (add synt above)
FREQ_STR f;

//"a_A|2|3 *212*212 :2 3434 *2 34" => f.seq;
//" *2 04ZZ 4042 aedf ZdfZ Ze4Z " => f.seq;

//f.freq_seq.adsr.set(1::ms, 2::ms, .5 , 1::ms);
//f.reg(synt_def  synt_u);

//FREQ_STR f1;   ">c*2     __0___0___  1___1_" =>     f1.seq;     f1.reg(synt_def2 s1);
//FREQ_STR f2;   ">c*2>4   __0___0_<1__1___1_" =>     f2.seq;     f2.reg(synt_def2 s2);
//FREQ_STR f3;   ">c*2>7   __0___1___  2___1_" =>     f3.seq;     f3.reg(synt_def2 s3);
//FREQ_STR f4;   "-8>c*2>c __0___0___  1___1_" =>     f4.seq;     f4.reg(synt_def2 s4);

FREQ_STR f1; 8 => f1.max; 
"<c *2 +6 0_1_0_3_" =>     f1.seq;     
"<c *2 +6 0_3_ *4 0_2_0_2_0_2_0_2_" =>     f1.seq;     
 
2=> f1.sync;
 f1.reg(synt_def2 s1);

f1.post() => JCRev rev => dac;
.1 => rev.mix;

while(1) {
	     100::ms => now;
}
		

*/

