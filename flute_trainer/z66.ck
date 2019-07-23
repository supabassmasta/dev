ST st;
SndBuf s => st.mono_in;


"../_SAMPLES/tabla/kehr_vaa.wav" => s.read;
0.7 => s.gain;

fun void f1 (){ 
  while(1) {

    s.length()  => now;
    0 => s.pos;
  }
} 
spork ~ f1 ();

while(1) {
       100::ms => now;
}
 
