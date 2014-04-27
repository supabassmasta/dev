class synt_def extends Chubgraph{

	// ****  SYNT *****
	inlet => SqrOsc s => LPF filt ; // => outlet;	
	s => BPF f2 => outlet;
filt.freq(1715);
		.14 => s.width;

		fun void f1 (){ 
			   for (0=> int i ; i < 10 ; 	i++)
				 { 
					    i * 200 => f2.freq;
							data.tick / 10 => now;
				 }
			 } 
			  

	    fun void on(/* float p1 */)  {   /*<<<"synt_def on">>>; */		   
						spork ~ f1 ();
			}
			fun void off() {	    /* <<<"synt_def off">>>;*/         }
			fun void new_note(/* float p1 */)  {			/* <<<"synt_def new_note">>>;*/         }
}

// SEQ

FREQ freq_seq;
freq_seq.freq => synt_def  synt_u=> freq_seq.adsr => Gain g => dac;

2=> freq_seq.sync_on;
.29 => g.gain;
freq_seq.rel_note  << 0 << 0 << 0 << 0      << 0 << 2 << 0 << -1      << 0 << 1 << 0 << -2     << 0 << -1 << 0 << 2     ;
freq_seq.g         <<.0 <<.9 <<.0 <<.9  ; 
//freq_seq.g         <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
//freq_seq.slide     << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.rel_dur   <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
//freq_seq.note      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.param[0]    <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;

data.ref_note  -12 => freq_seq.base_note;
data.scale.my_string => freq_seq.scale;
data.bpm*4 => freq_seq.bpm;

// On off synt_def management
fun void call_on() {  while (1){ freq_seq.start_ev => now;  spork ~ synt_u.on(/*freq_seq.get_param(0)*/);		}  } spork ~ call_on();
fun void call_off(){  while (1){ freq_seq.stop_ev => now;   spork ~ synt_u.off();		}  } spork ~ call_off();
fun void new_note(){  while (1){ freq_seq.new_ev => now;   spork ~ synt_u.new_note(/*freq_seq.get_param(0)*/);			}  } spork ~ new_note();

freq_seq.go();

while(1) {
	     100::ms => now;
}
 
