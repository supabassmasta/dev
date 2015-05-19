class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.2 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max; 
2=> f0.sync;

"DOR" => f0.scale;
"*2 04050406" =>     f0.seq;     
"<5 *2 04050406" =>     f0.seq;     
"*2 04050406" =>     f0.seq;     
"<7 *2 04050406" =>     f0.seq;     
f0.reg(synt0 s0);

class synt1 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .1 => final.gain;

inlet => detune[i] => s[i] => final;    1.  => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.2 => detune[i].gain;    .5 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.5 => detune[i].gain;    .5 => s[i].gain; i++;  

				fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {	}
}


FREQ_STR f1; //8 => f1.max;

2=> f1.sync;
"*4 >c     __4_0_4_ __4_0_4_  " =>     f1.seq;     
"*4 >c <5  __4_0_4_ __4_0_4_  " =>     f1.seq;     
"*4 >c     __4_0_4_ __4_0_4_  " =>     f1.seq;     
"*4 >c <7  __4_0_4_ __4_0_4_  " =>     f1.seq;     
f1.reg(synt1 s1);
//f1.post()  => dac;

SEQ s;

class test extends ACTION {

  SinOsc s => dac;
  .0 => s.gain;
  880 => s.freq;

  fun void bleep() {
    .1 => s.gain;
    100::ms => now;
    .0 => s.gain;
  }
  
  fun int on_time() {
    spork ~ bleep();
    return 0;
  }

}

test T;
 T @=> s.action["t"];
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Snares/Wsc_Snr2.wav" => s.wav["s"];
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Hi-Hats/Str_H1.wav" => s.wav["h"];
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Kicks/Wal_K.wav" =>s.wav["k"];
// * data.tick => s.max;
//"*2k$k:2_s|k _" => s.seq;
//"*2k|t$k|t:2ts|k _  k t s|k  _" => s.seq;
"*8}0s}1s}2s}3s}4s}5s}6s}7s" => s.seq;
//"{s{{s{{{s{{{{s{{{{{s{{{{{{s{{{{{{{s{{{{{{{{s" => s.seq;
//"*2k$k:2ts|k _ *2 tk  _*2 __<<<sk<3sk _<5s_*8:3sss" => s.seq;
s.element_sync();

s.go();




while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
"}s}s}s}s}s}s}s}s" => s.seq;
//"*2k$k:2ts|k _ *2 tk  _*2 __<<<sk<3sk _<5s_*8:3sss" => s.seq;
s.element_sync();

s.go();




while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
