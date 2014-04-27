/*SawOsc s => */
/* Step f => Gain gin => */ibniz I => Gain g2 => Gain g =>/* NRev rev=>*/ dac;

//.0 => rev.mix;

.05 => g.gain;

//60 => f.next;



//.1 => rev.mix;

//"14*d1A|12E2&*" => I.code;
"d3r1A&*" => I.code;
// d1A|12E2&/
35 => I.param;


2::second => now;


/*while (1) {
	I.off();
	500::ms => now;
	I.on();
	500::ms => now;
	
<<<"hey">>>;
}*/


/*1::second => now;
ibniz I2 => Gain g3 => g2;
1=> g3.gain;
"2*drst"=>I2.code; 
*/
/*ibniz I3 => Gain g4 => g2;
.01=> g4.gain;
""=>I3.code; 
*/



1::week => now;


/*<<<I.code(), I2.code()>>>;

61 => I2.param;
<<<I.param(), I2.param()>>>;
*/

/*g =< dac;

SawOsc s => dac;
.5 => s.gain;
60 => s.freq;

5::second => now;

100000 => int i;
*/
/*while (i) {
i--;
<<<i, I.last()>>>;
1::samp => now;

}*/
