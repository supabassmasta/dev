class SERUM0 extends SYNT{

  inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
  .5 => w.gain;
  .5 => factor.gain;

  1. => p.gain;


  1 => w.sync;
  1 => w.interpolate;
  //[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
  //[-1.0,  1] @=> float myTable[];
  float myTable[0];

  SndBuf s => blackhole;
  
  2048 => int chunk_size;


  fun void config(int wn /* wave number */, int of /* chunk offset */) {

//    "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/"
//    "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M5-FX-Chords/01-Camchord.wav"
//    "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/26-Arctic.wav"

    string st[0];
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/02-Acid.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/03-Groan I.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/04-Groan II.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/05-Groan III.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/06-Groan IV.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/07-Crude.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/08-Drive I.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/09-Drive II.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/10-Drive III.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/11-Electric.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/12-Screamer.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/13-Dirty Needle.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/14-Dirty Throat.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/15-Dirty PWM.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/16-Strontium.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/17-Crusher.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/18-Reducer.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/19-Kangaroo.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/20-Frozen.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/21-Vulgar.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/22-Classic.wav" ;
    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/23-Disto.wav" ;
    
   if ( wn >= st.size()  ){
       <<<"SERUM: WARNING WAVTABLE NUMER TOO HIGH">>>;
       0 => wn;
   }
   else {
      <<<"serum wavtable :", wn, st[wn]>>>;
   }

   st[wn] => s.read;

    if ( of * chunk_size >=  s.samples() - chunk_size ){
      <<<"SERUM: WARNING CHUNK OFFSET TOO HIGH:", of>>>;
      0=> of;
  }

    of * chunk_size => int start;

    for (start => int i; i < s.samples() && i < start +  chunk_size   ; i++) {
      myTable << s.valueAt(i);
    }

    if ( myTable.size() == 0  ){
       <<<" SERUM ERROR: Empty wavtable !!!!!">>>;

       myTable << 0; 
    }

    w.setTable (myTable);
  }

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt4 extends SYNT{

    inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
      .5 => w.gain;
    .125 => factor.gain;

    1. => p.gain;


      1 => w.sync;
      1 => w.interpolate;
//[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
//[-1.0,  1] @=> float myTable[];
float myTable[0];

SndBuf s => blackhole;
//"../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/02-Acid.wav"=> s.read;
//"../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M5-FX-Chords/01-Camchord.wav"=> s.read;
//"../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M5-FX-Chords/01-Camchord.wav"=> s.read;
//"../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/26-Arctic.wav"=> s.read;   // COOL !!!
//"../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/01-Gentle Speech.wav"=> s.read;
//"../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/03-Deep Throat.wav"=> s.read;
//"../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/04-Melomantic.wav"=> s.read;
"../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/12-Duckorgan.wav"=> s.read;
//"../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/30-E-Bass Pulse.wav"=> s.read;
3 => int offs;
offs * 2048 => int start;

for (start => int i;  i < start +  2048   ; i++) {
  myTable << s.valueAt(i);
}
 

w.setTable (myTable);

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt3 extends SYNT{

    inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
      .5 => w.gain;
    .125 => factor.gain;

    .01 => p.gain;

    Step offset => w;
    0. => offset.next;


      1 => w.sync;
      1 => w.interpolate;
//[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
//[-1.0,  1] @=> float myTable[];
float myTable[0];

SndBuf s => blackhole;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 01.wav"=> s.read;

for (0 => int i; i <  s.samples() /* && i < 2048  */  ; i++) {
  myTable << s.valueAt(i);
}
 

w.setTable (myTable);

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;

class cont extends CONTROL {

     Phasor @ p;
      1 =>  update_on_reg ;
        fun void set(float in) {
          in * 0.001 => p.gain;
             }
} 

cont c;
p @=> c.p;
HW.lpd8.potar[1][5].reg(c);

class cont2 extends CONTROL {
      1 =>  update_on_reg ;
     Step @ s;
        fun void set(float in) {
            in * 0.01 => s.next;
             }
} 

cont2 c2;
offset @=> c2.s;
HW.lpd8.potar[1][6].reg(c2);



} 

class synt1 extends SYNT{

    inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
      .5 => w.gain;
    .125 => factor.gain;

    .01 => p.gain;


      1 => w.sync;
      1 => w.interpolate;
//[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
//[-1.0,  1] @=> float myTable[];
float myTable[0];

SndBuf s => blackhole;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 01.wav"=> s.read;

for (0 => int i; i <  s.samples() /* && i < 2048  */  ; i++) {
  myTable << s.valueAt(i);
}
 

w.setTable (myTable);

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt2 extends SYNT{

//    inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
    inlet => Gain factor => blackhole;
    Wavetable w =>  outlet; 
      .5 => w.gain;

    .125 => factor.gain;


//      1 => w.sync;
      0 => w.sync;
      1 => w.interpolate;
//[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
//[-1.0,  1] @=> float myTable[];
float myTable[0];

SndBuf s => blackhole;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 01.wav"=> s.read;

for (0 => int i; i <  s.samples() /* && i < 2048  */  ; i++) {
  myTable << s.valueAt(i);
}
 

w.setTable (myTable);

        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => w.freq;
        } 0 => own_adsr;
} 

class PAD1 extends SYNT{

inlet => Gain factor => blackhole;

1. / 8. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 05_short.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class PAD2 extends SYNT{

inlet => Gain factor => blackhole;

1. / 32. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 01_short.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class PAD3 extends SYNT{

inlet => Gain factor => blackhole;

1. / 32. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 02_short.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class PAD0 extends SYNT{

inlet => Gain factor => blackhole;

1. / 32. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 06_short.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class VIOLIN0 extends SYNT{

inlet => Gain factor => blackhole;

1. / 4. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/violin.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class VIOLIN1 extends SYNT{

inlet => Gain factor => blackhole;

1. / 32. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/violin2.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 

class CELLO0 extends SYNT{

inlet => Gain factor => blackhole;

1. / 1. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/cello0.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 


class CELLO1 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
CELLO0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.007 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.996 => detune[i].gain;    .4 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          1::samp => now;
          for (0 => int i; i <  synt_nb     ; i++) {
            s[i].new_note(0);
          }
           


 } 0 => own_adsr;
} 

class CELLO2 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
CELLO0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.007 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.996 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.003 => detune[i].gain;    .2 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.995 => detune[i].gain;    .2 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          1::samp => now;
          for (0 => int i; i <  synt_nb     ; i++) {
            s[i].new_note(0);
          }
           


 } 0 => own_adsr;
} 
class CELLO3 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
VIOLIN0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.007 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.996 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.003 => detune[i].gain;    .2 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.995 => detune[i].gain;    .2 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          1::samp => now;
          for (0 => int i; i <  synt_nb     ; i++) {
            s[i].new_note(0);
          }
           


 } 0 => own_adsr;
} 

class VOICEA0 extends SYNT{

inlet => Gain factor => blackhole;

1. / 1. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/voiceA0.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 
class VOICEA1 extends SYNT{

inlet => Gain factor => blackhole;

1. / 1. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/voiceA1.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 
class VOICEA2 extends SYNT{

inlet => Gain factor => blackhole;

1. / 1. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/voiceA2.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 


class CHORUSA0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
VOICEA0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.007 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.996 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.003 => detune[i].gain;    .2 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.995 => detune[i].gain;    .2 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          1::samp => now;
          for (0 => int i; i <  synt_nb     ; i++) {
            s[i].new_note(0);
          }
           


 } 0 => own_adsr;
} 
class CHORUSA1 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
VOICEA1 s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.007 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.996 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.003 => detune[i].gain;    .2 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.995 => detune[i].gain;    .2 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          1::samp => now;
          for (0 => int i; i <  synt_nb     ; i++) {
            s[i].new_note(0);
          }
           


 } 0 => own_adsr;
} 
class CHORUSA2 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
VOICEA2 s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.007 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.996 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.003 => detune[i].gain;    .2 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.995 => detune[i].gain;    .2 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          1::samp => now;
          for (0 => int i; i <  synt_nb     ; i++) {
            s[i].new_note(0);
          }
           


 } 0 => own_adsr;
} 



lpk25 l;
POLY synta; 
l.reg(synta);
//synta.reg(synt4 s0);  synta.a[0].set(100::ms, 300::ms, .7, 1000::ms);
//synta.reg(synt4 s1);  synta.a[1].set(100::ms, 300::ms, .7, 1000::ms);
//synta.reg(synt4 s2);  synta.a[2].set(100::ms, 300::ms, .7, 1000::ms);
//synta.reg(synt4 s3);  synta.a[3].set(100::ms, 300::ms, .7, 1000::ms);
////synta.reg(synt4 s4);  synta.a[3].set(100::ms, 300::ms, .7, 1000::ms);
//synta.reg(synt4 s5);  synta.a[3].set(100::ms, 300::ms, .7, 1000::ms);
//synta.reg(synt4 s6);  synta.a[3].set(100::ms, 300::ms, .7, 1000::ms);
12 => int wn;
14 => int of;
synta.reg(SERUM0 ser0); ser0.config( wn /* wave number */, of /* chunk offset */);
synta.reg(SERUM0 ser1); ser1.config( wn /* wave number */, of /* chunk offset */);
synta.reg(SERUM0 ser2); ser2.config( wn /* wave number */, of /* chunk offset */);
synta.reg(SERUM0 ser3); ser3.config( wn /* wave number */, of /* chunk offset */);
synta.reg(SERUM0 ser4); ser4.config( wn /* wave number */, of /* chunk offset */);
synta.reg(SERUM0 ser5); ser5.config( wn /* wave number */, of /* chunk offset */);
synta.reg(SERUM0 ser6); ser6.config( wn /* wave number */, of /* chunk offset */);


// Note info duration
10 * 100::ms => synta.ni.d;

synta $ ST @=> ST @ last; 

STLPFC lpfc;
lpfc.connect(last $ ST , HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */  );       lpfc $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 8. /* static gain */  );       gainc $ ST @=>  last; 

//STMIX stmix;
//stmix.send(last, 28);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 

