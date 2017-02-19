0 => int i ;

while(1) {
		HW.launchpad.red(i);
	  100::ms => now;
		HW.launchpad.clear(i);
		i + 1 => i;
		if (i > 128) 0 => i;
}
 

 

HW.launchpad.red(1);
