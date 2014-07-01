Step s => ibniz i => LPF l => dac;

ibniz j => dac;
"drst" => j.code;
.3 => j.gain;

1000 => l.freq;

.3 => i.gain;

"d7&*" => i.code;

while(1) {
				60 => s.next;
	     500::ms => now;
				80 => s.next;
	  500::ms => now;
				100 => s.next;
	  500::ms => now;
				80 => s.next;
}
 

