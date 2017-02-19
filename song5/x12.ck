128 => int i ;

while(1) {
		HW.launchpad.green(i);
	  50 ::ms => now;
		HW.launchpad.clear(i);
		i - 1 => i;
		if (i < 0) 128 => i;
}
 

 

HW.launchpad.red(1);
