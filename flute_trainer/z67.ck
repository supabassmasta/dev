ST st;
SndBuf s => st.mono_in;


"../_SAMPLES/tabla/80_TablaClose_04_239_SP.wav" => s.read;
0.9 => s.gain;

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
 
