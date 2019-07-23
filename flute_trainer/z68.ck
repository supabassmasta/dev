ST st;
SndBuf s => st.mono_in;


"../_SAMPLES/tabla/teen_taal.wav" => s.read;
0.6 => s.gain;

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
 
