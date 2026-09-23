class synt_def extends Chubgraph{

	// ****  SYNT *****
8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .8 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.03 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.06 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.09 => detune[i].gain;    .4 => s[i].gain; i++;  



	    fun void on(/* float p1 */)  {   /*<<<"synt_def on">>>; */		         }
			fun void off() {	    /* <<<"synt_def off">>>;*/         }
			fun void new_note(/* float p1 */)  {			/* <<<"synt_def new_note">>>;*/         }
}

// SEQ

FREQ freq_seq;
freq_seq.freq => synt_def  synt_u=> freq_seq.adsr => Gain g => dac;

0=> freq_seq.sync_on;
.3 => g.gain;

freq_seq.rel_note  << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << -2     << 0 << 0 << 0 << 0     ;
freq_seq.g         <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.1 <<.0 <<.0 <<.1     <<.1 <<.0 <<.1 <<.1       ;

freq_seq.rel_note  << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
freq_seq.g         << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;

freq_seq.rel_note  << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
freq_seq.g         << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;


freq_seq.rel_note  << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
freq_seq.g         << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;

//freq_seq.rel_note  << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.g         <<.1 <<.1 <<.1 <<.1      <<.1 <<.1 <<.1 <<.1      <<.1 <<.1 <<.1 <<.1     <<.1 <<.1 <<.1 <<.1       ;

//freq_seq.rel_note  << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.g         <<.1 <<.1 <<.1 <<.1      <<.1 <<.1 <<.1 <<.1      <<.1 <<.1 <<.1 <<.1     <<.1 <<.1 <<.1 <<.1       ;
//freq_seq.g         <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
//freq_seq.slide     << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
freq_seq.rel_dur   <<.25;
//freq_seq.note      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.param[0]    <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;

data.ref_note +12 => freq_seq.base_note;
data.scale.my_string => freq_seq.scale;
data.bpm => freq_seq.bpm;

// On off synt_def management
fun void call_on() {  while (1){ freq_seq.start_ev => now;  spork ~ synt_u.on(/*freq_seq.get_param(0)*/);		}  } spork ~ call_on();
fun void call_off(){  while (1){ freq_seq.stop_ev => now;   spork ~ synt_u.off();		}  } spork ~ call_off();
fun void new_note(){  while (1){ freq_seq.new_ev => now;   spork ~ synt_u.new_note(/*freq_seq.get_param(0)*/);			}  } spork ~ new_note();

freq_seq.go();

data.meas_size * data.tick => now; 
