class synt_def extends Chubgraph{

	// ****  SYNT *****
	inlet => SinOsc s => outlet;	

	    fun void on(/* float p1 */)  {   /*<<<"synt_def on">>>; */		         }
			fun void off() {	    /* <<<"synt_def off">>>;*/         }
			fun void new_note(/* float p1 */)  {			/* <<<"synt_def new_note">>>;*/         }
}

// SEQ

FREQ freq_seq;
freq_seq.freq => synt_def  synt_u=> freq_seq.adsr => Gain g => dac;
freq_seq.adsr.set(1::ms, 194::ms, 0.00001, 1::ms);
2=> freq_seq.sync_on;
.13 => g.gain;
freq_seq.rel_note  << 2 << 0 << 0 << 0  << 0 << 0 << 0 << 0  ; 
freq_seq.g         <<.9 <<.0 <<.9 <<.0  <<.9 <<.0 <<.9 <<.0   ;
//freq_seq.g         <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
//freq_seq.slide     << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
freq_seq.rel_dur     << .5  << .5  << .5  << .5    << .5   << .5  << .5 << .5 ; 
//freq_seq.note      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.param[0]    <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;

70 => freq_seq.base_note;
data.scale.my_string => freq_seq.scale;
data.bpm => freq_seq.bpm;

// On off synt_def management
fun void call_on() {  while (1){ freq_seq.start_ev => now;  spork ~ synt_u.on(/*freq_seq.get_param(0)*/);		}  } spork ~ call_on();
fun void call_off(){  while (1){ freq_seq.stop_ev => now;   spork ~ synt_u.off();		}  } spork ~ call_off();
fun void new_note(){  while (1){ freq_seq.new_ev => now;   spork ~ synt_u.new_note(/*freq_seq.get_param(0)*/);			}  } spork ~ new_note();

freq_seq.go();

while(1) {
	     100::ms => now;
}
 





