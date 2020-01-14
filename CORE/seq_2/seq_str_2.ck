class synt_def extends SYNT{

	// ****  SYNT *****
	inlet => SinOsc s => JCRev rev => Gain fb => outlet;	

	Noise n => LPF lpf => s;	
	100=>lpf.freq;
	300 => n.gain;
	
	fb => Delay d => fb;
  data.tick *2./3. => d.max =>d.delay;
  .6 => d.gain;

  .1 => rev.mix;
fun void f1 (){ 
		while(1) {
			Std.rand2f(0.1, 0.5) => float g1;	
			Std.rand2(0, 1) => float sign;	
		  
			if (sign) g1 * -1 => s.gain;
			else g1 => s.gain;

			     Std.rand2f(22., 48.) * 1::ms => now;
		}
		 


	 } 
	 spork ~ f1 ();

fun void f2 (){ 

	 } 
	 spork ~ f2 ();
	  

//.15 => s.width;
		.5 => s.gain;
	    fun void on(/* float p1 */)  {  /* <<<"synt_def on">>>; */		         }
			fun void off() {	   /*  <<<"synt_def off">>>;     */    }
			fun void new_note(int idx)  {	/*		 <<<"synt_def new_note, idx:", idx>>>;    */     }
}
class synt_def2 extends SYNT{

	// ****  SYNT *****
	inlet => SinOsc s =>  outlet;	
	.5 => s.gain;

	    fun void on(/* float p1 */)  {  /* <<<"synt_def on">>>; */		         }
			fun void off() {	   /*  <<<"synt_def off">>>;     */    }
			fun void new_note(int idx)  {	/*		 <<<"synt_def new_note, idx:", idx>>>;    */     }
}
// SEQ
class FREQ_STR {

FREQ2 freq_seq;

0=> freq_seq.sync_on;
//freq_seq.rel_note  << 0 << 1 << 2 << 1  ; 
//freq_seq.g         <<.9 <<.9 <<.9 <<.9 ; 
//freq_seq.g         <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
//freq_seq.slide     << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.rel_dur   <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
//freq_seq.note      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.param[0]    <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;

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
				return 0;

}

fun void seq(string in) {
		0=> int i;
		int c;
		1. => float g;
		0 => int force;
		1. => float duration;
		0 => int note_offset_v;
		while(i< in.length()) {

				in.charAt(i)=> c;
		<<<"c", c>>>;	
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
								<<<"slide_dur", slide_dur>>>;
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
							freq_seq.rel_dur   << slide_dur * duration;
							freq_seq.force_new_note << force;
							freq_seq.slide << 1;
							freq_seq.note_offset << note_offset_v;
						}
						else {
							freq_seq.rel_note  << convert_note(c);
							freq_seq.g         << g; 
							freq_seq.rel_dur   << duration;
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
						freq_seq.rel_dur   << duration;
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
						note_offset_v + convert_note (c) => note_offset_v;
				}
				else if (in.charAt(i) == '-') {
						i++;
						in.charAt(i)=> c;
						note_offset_v - convert_note (c) => note_offset_v;
				}
				else if (in.charAt(i) == '>') {
						i++;
						in.charAt(i)=> c;
						note_offset_v + 12 * convert_note (c) => note_offset_v;
				}
				else if (in.charAt(i) == '<') {
						i++;
						in.charAt(i)=> c;
						note_offset_v - 12 * convert_note (c) => note_offset_v;
				}
				i++;
		}
		 
for (0 => int j; j < freq_seq.rel_note.size()      ; j++) {
		<<<"freq_seq.rel_note[j]      ",freq_seq.rel_note[j]      >>>;
		<<<"freq_seq.g[j]             ",freq_seq.g[j]             >>>;
		<<<"freq_seq.force_new_note[j]",freq_seq.force_new_note[j]>>>;
		<<<"freq_seq.rel_dur[j]       ",freq_seq.rel_dur[j]       >>>;
		<<<"freq_seq.slide[j]       ",freq_seq.slide[j]       >>>;
}
 

}


// On off synt_def management
fun void reg (SYNT @ in){
//fun void call_on() {  while (1){ freq_seq.start_ev => now;  spork ~ in.on(/*freq_seq.get_param(0)*/);		}  } spork ~ call_on();
//fun void call_off(){  while (1){ freq_seq.stop_ev => now;   spork ~ in.off();		}  } spork ~ call_off();
//fun void new_note(){  while (1){ freq_seq.new_ev => now;   spork ~ in.new_note(/*freq_seq.get_param(0)*/);			}  } spork ~ new_note();
		freq_seq.reg(in);
		freq_seq.freq => in => freq_seq.adsr => Gain g => dac;
.3 => g.gain;
		freq_seq.go();
}

}

FREQ_STR f;

//"a_A|2|3 *212*212 :2 3434 *2 34" => f.seq;
//" *2 04ZZ 4042 aedf ZdfZ Ze4Z " => f.seq;

//f.freq_seq.adsr.set(1::ms, 2::ms, .5 , 1::ms);
//f.reg(synt_def  synt_u);

FREQ_STR f1;   "*2  __0___0___1___1_" =>     f1.seq;     f1.reg(synt_def2 s1);
FREQ_STR f2;   "*2+3__0___0_+1__1___1_" =>     f2.seq;     f2.reg(synt_def2 s2);
FREQ_STR f3;   "*2+7__0___0___1___1_" =>     f3.seq;     f3.reg(synt_def2 s3);
FREQ_STR f4;   "*2>1__0___0___1___1_" =>     f4.seq;     f4.reg(synt_def2 s4);
while(1) {
	     100::ms => now;
}
		



