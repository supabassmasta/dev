ST st;

STDUCK duck;
duck.connect(st $ ST); 

ibniz ib => LPF lpf => st.mono_in;
1000 => lpf.freq;
.1 => ib.gain;
"2*3/ddr4%rt" => ib.code;

class ACT extends ACTION {
  ibniz @ i;
    fun int on_time() {
          <<<"test">>>; 
          i.reset();
            }
}

ACT act; 
ib @=> act.i;
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);
SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); 
 "" => s.wav["a"];  
 
 act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2k|a k|s k k|s k k|s  
*4 kk _ k _k _k  :4
k|a k|s k k|s k k|s  
*4 k_ k k _k kk  :4
" => s.seq;
1.9 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

STDUCKMASTER duckm;
duckm.connect(s $ ST, 9. /* In Gain */, .07 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ ); 

while(1) {
       100::ms => now;
}
 
