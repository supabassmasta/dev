PoleZero allpass; 
Gain out => dac;
.1 => out.gain;

//Noise n => out;
//Noise n => allpass => out;
Gain minus; 2 => minus.op;
// 3 =>989//1+ 2- 3* 4/ 0 off -1 passthrough

//Envelope e0 =>  SinOsc sin0 => allpass =>  minus => out; 
Step stp0 => Envelope e0 =>  SinOsc sin0 => allpass => minus =>   out;  
1.0 => stp0.next;

sin0 => minus;



//10.0 => sin0.freq;
1.0 => sin0.gain;

20.0 => e0.value;
10000.0 => e0.target;
5::second => e0.duration ;// => now;


// find pole location from delay and omega
fun float polePos( float D, float omega )
{
    // here it is (a la Jaffe & Smith)
    return Math.sin( (1-D) * omega / 2 ) / 
           Math.sin( (1+D) * omega / 2 );
}
fun  setFreq( float freq )
{
    // sample rate
    second / samp => float SR;
    // omega
    2 * pi * freq / SR => float omega;
    // figure total delay needed
    SR / freq - .5 => float D;
    // the integer part
    D $ int => int Di;
    // the fraction
    D - Di => float Df;
    // set allpass using fractional and fundamental
    polePos( Df, omega ) => allpass.allpass;

    // return integer portion
}
  
setFreq( 200);

10::second => now;

