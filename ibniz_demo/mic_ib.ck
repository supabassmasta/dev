adc => Gain g => dac;
//Gain g => dac;
.5 => g.gain;
3 => g.op;

ibniz ib => g;
.05 => ib.gain;

"dF&*" => ib.code;
Step s => ib;
24 => s.next;
while(1) {
	     100::ms => now;
}
 
