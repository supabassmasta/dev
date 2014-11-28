///////////////////////////////////////////////////////////////////////////////
// GVERB is a very smooth reverberator with the ability to produce very long //
// reverb times.                                                             //
//                                                                           //
// GVERB is based on the original "gverb/gigaverb" by Juhana Sadeharju       //
// (kouhia at nic.funet.fi). The code for this version was adapted from      //
// RTcmix (http://rtcmix.org), which in turn adapted it from the Max/MSP     //
// version by Olaf Mtthes (olaf.matthes at gmx.de).                          //
///////////////////////////////////////////////////////////////////////////////

 
class synt_def extends Chubgraph{

	// ****  SYNT *****
8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .2 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    1.8 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    2.01 => detune[i].gain;    .2 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    3.02 => detune[i].gain;    .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    4.03 => detune[i].gain;    .04 => s[i].gain; i++;  

	    fun void on(/* float p1 */)  {   /*<<<"synt_def on">>>; */		         }
			fun void off() {	    /* <<<"synt_def off">>>;*/         }
			fun void new_note(/* float p1 */)  {			/* <<<"synt_def new_note">>>;*/         }
}

// SEQ

FREQ freq_seq;
freq_seq.freq => synt_def  synt_u=> freq_seq.adsr => Gain g; 
freq_seq.adsr.set(100::ms, 70::ms, 0.7, 500::ms);
0=> freq_seq.sync_on;
.12 => g.gain;
freq_seq.rel_note  << 0 << 2 << 0 << 2      << 3 << 5 << 4 << 1      << 0 << -2 << 2 << 1     << 0 << 3 << -2 << -1     ;
freq_seq.g         <<.9 <<.9 <<.0 <<.9      <<.9 <<.9 <<.0 <<.7      <<.9 <<.9 <<.0 <<.9     <<.9 <<.9 <<.9 <<.9     ;
//freq_seq.g         <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
//freq_seq.slide     << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.rel_dur   <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
//freq_seq.note      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
//freq_seq.param[0]    <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;

data.ref_note + 6 => freq_seq.base_note;
data.scale.my_string => freq_seq.scale;
data.bpm => freq_seq.bpm;

// On off synt_def management
fun void call_on() {  while (1){ freq_seq.start_ev => now;  spork ~ synt_u.on(/*freq_seq.get_param(0)*/);		}  } spork ~ call_on();
fun void call_off(){  while (1){ freq_seq.stop_ev => now;   spork ~ synt_u.off();		}  } spork ~ call_off();
fun void new_note(){  while (1){ freq_seq.new_ev => now;   spork ~ synt_u.new_note(/*freq_seq.get_param(0)*/);			}  } spork ~ new_note();

freq_seq.go();

//data.meas_size * data.tick => now; 

// Options
// roomsize: (float) [1.0 - 300.0], default 30.0
// revtime: (dur), default 5::second
// damping: (float), [0.0 - 1.0], default 0.8
// spread: (float), default 15.0
// inputbandwidth: (float) [0.0 - 1.0], default 0.5
// dry (float) [0.0 - 1.0], default 0.6
// early (float) [0.0 - 1.0], default 0.4
// tail (float) [0.0 - 1.0], default 0.5
GVerb gverb; 
g => gverb =>  dac;
//g =>   dac;
//SinOsc s => ADSR a => gverb => dac;
//SinOsc s => ADSR a =>  dac;
240 => gverb.roomsize;
3::second => gverb.revtime;
0.4 => gverb.dry;
0.7 => gverb.early;
0.6 => gverb.tail;
0.8 => gverb.damping;
//0.5 => gverb.inputbandwidth;

//0.1 => s.gain;
//900 => s.freq;
//a.set(1::ms, 20::ms, 0.01, 10::ms);

while (true)
{
//	a.keyOn();
	20::ms=> now;
//	a.keyOff();
  2::second => now;
}
