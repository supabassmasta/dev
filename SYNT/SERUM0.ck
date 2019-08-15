public class SERUM0 extends SYNT{

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

    string st[0];
/* 0 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/02-Acid.wav" ;
/* 1 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/03-Groan I.wav" ;
/* 2 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/04-Groan II.wav" ;
/* 3 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/05-Groan III.wav" ;
/* 4 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/06-Groan IV.wav" ;
/* 5 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/07-Crude.wav" ;
/* 6 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/08-Drive I.wav" ;
/* 7 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/09-Drive II.wav" ;
/* 8 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/10-Drive III.wav" ;
/* 9 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/11-Electric.wav" ;
/* 10 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/12-Screamer.wav" ;
/* 11 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/13-Dirty Needle.wav" ;
/* 12 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/14-Dirty Throat.wav" ;
/* 13 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/15-Dirty PWM.wav" ;
/* 14 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/16-Strontium.wav" ;
/* 15 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/17-Crusher.wav" ;
/* 16 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/18-Reducer.wav" ;
/* 17 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/19-Kangaroo.wav" ;
/* 18 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/20-Frozen.wav" ;
/* 19 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/21-Vulgar.wav" ;
/* 20 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/22-Classic.wav" ;
/* 21 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/23-Disto.wav" ;

/* 22 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/01-Gentle Speech.wav";
/* 23 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/02-Modern Talking.wav";
/* 24 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/03-Deep Throat.wav";
/* 25 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/04-Melomantic.wav";
/* 26 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/05-Melofant.wav";
/* 27 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/06-Digigrain I.wav";
/* 28 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/07-Digigrain II.wav";
/* 29 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/08-Formant Saw.wav";
/* 30 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/09-Formant Square.wav";
/* 31 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/10-Sonic.wav";
/* 32 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/11-Squelchy.wav";
/* 33 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/12-Duckorgan.wav";
/* 34 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/13-Flenders I.wav";
/* 35 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/14-Flenders II.wav";
/* 36 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/15-Flenders III.wav";
/* 37 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/16-Digi Cook I.wav";
/* 38 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/17-Digi Cook II.wav";
/* 39 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/18-Digi Cook III.wav";
/* 40 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/19-Chrome.wav";
/* 41 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/20-Magyr.wav";
/* 42 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/21-A.I.wav";
/* 43 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/22-Silver.wav";
/* 44 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/23-Scrap Yard.wav";
/* 45 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/24-Wicked.wav";
/* 46 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/25-Bronze.wav";
/* 47 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/26-Arctic.wav";
/* 48 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/27-Herby.wav";
/* 49 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/28-Bender.wav";
/* 50 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/29-Guitar Pulse.wav";
/* 51 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M4-Digital-Hybrid/30-E-Bass Pulse.wav";

/* 52 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/01-Square-Saw I.wav";
/* 53 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/02-Square-Saw II.wav";
/* 54 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/03-Smooth Square.wav";
/* 55 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/04-Sin-Square.wav";
/* 56 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/05-Sin-Triangle.wav";
/* 57 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/06-PolySaw I.wav";
/* 58 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/07-PolySaw II.wav";
/* 59 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/08-Roughmath I.wav";
/* 60 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/09-Roughmath II.wav";
/* 61 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/10-Roughmath III.wav";
/* 62 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/11-Escalation I.wav";
/* 63 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/12-Escalation II.wav";
/* 64 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/13-Multiplex.wav";
/* 65 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/14-SinFormant.wav";
/* 66 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/15-AdditiveOctaves.wav";
/* 67 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/16-AdditivMix I.wav";
/* 68 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/17-AdditivMix II.wav";
/* 69 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/18-AdditivMix III.wav";
/* 70 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/19-AdditivMix IV.wav";
/* 71 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/20-AdditivMix V.wav";
/* 72 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/21-AdditivMix VI.wav";
/* 73 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/22-Inharmonic.wav";
/* 74 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/23-Sinarmonic I.wav";
/* 75 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M2-Basic/24-Sinarmonic II.wav";

/* 75 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M5-FX-Chords/01-Camchord.wav";
/* 76 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M5-FX-Chords/02-Colors.wav";
/* 77 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M5-FX-Chords/03-Iron.wav";
/* 78 */    st << "../_SAMPLES/wavetable/TriSamples Wavetables For Serum/M5-FX-Chords/04-Cicada.wav";
    
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


