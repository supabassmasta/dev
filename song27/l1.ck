Step s0 => Envelope e0 => SinOsc sin0 =>  dac;
1.0 => s0.next;
372.0 => sin0.freq;
0.2 => sin0.gain;

//Envelope e0;
//0.0 => e0.value;
//1.0 => e0.target;
//4.0 * data.tick => e0.time  => now  ;

550.0 => e0.value;
 

while(1) {
  440.0 => e0.target;
  4.0 * data.tick => e0.duration => now;
//  4.0 * data.tick  => now;
  880.0 => e0.target;
  4.0 * data.tick => e0.duration => now ;
//  4.0 * data.tick => now;
}
 
