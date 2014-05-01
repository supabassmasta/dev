class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .2 => final.gain;

inlet => detune[i] => s[i] => final;    1.00 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.02 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.03 => detune[i].gain;    .6 => s[i].gain; i++;  

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; 4 => f0.max; 1=> f0.sync;

"*8 0__3__1___________________________________________________" =>     f0.seq;     
f0.reg(synt0 s0);
f0.post() => Gain fb => dac;
fb => Delay d => fb;
data.tick / 2 => d.max => d.delay;
.8 => d.gain;

class END extends end { 
	
	FREQ_STR @ f;
	
	fun void kill_me () {



				<<<"THE END">>>;		
				f.stop();
								2500::ms => now;		
												<<<"THE real END">>>;		
}}; END the_end; me.id() => the_end.shred_id; f0 @=> the_end.f; killer.reg(the_end);  


while(1) {  100::ms => now; }
				 
