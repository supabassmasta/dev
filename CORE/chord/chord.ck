public class chord{

6./5.=>float minor_third;
5./4.=>float major_third ;

3./2.=>float perfc_fifth ;
64./45.=>float dimin_fifth ;
8./5.=>float augmt_fifth;

5./3.=>float dimin_sevth ;
9./5.=>float minor_sevth;
15./8.=>float major_sevth;

//float perfc_elevn ;
//float major_thirt;

Gain input;
input => Gain third_u;
input => Gain fifth_u;
input => Gain seveth_u;
1=> input.gain;
0=> third_u.gain;
0=> fifth_u.gain;
0=> seveth_u.gain;


fun UGen fondamental (UGen @ in){
	in => input;
return input;	
}

fun UGen third (){
	return third_u;	
}

fun UGen fifth (){
	return fifth_u;	
}

fun UGen seventh(){
	return seveth_u;	
}

fun void set_chord(int num){

	if (num == 0){
		// reset chord 
		0=> third_u.gain;
		0=> fifth_u.gain;
		0=> seveth_u.gain;
	}
	else if (num == 1){
	//Major triad
		major_third=> third_u.gain;
		perfc_fifth=> fifth_u.gain;
		0=> seveth_u.gain;
	}
	else if (num == 2){
	//Minor triad
		minor_third=> third_u.gain;
		perfc_fifth=> fifth_u.gain;
		0=> seveth_u.gain;
	}

	else if (num == 3){
	//Augmented triad
		major_third=> third_u.gain;
		augmt_fifth=> fifth_u.gain;
		0=> seveth_u.gain;
	}

	else if (num == 4){
	//Diminished triad
		minor_third=> third_u.gain;
		dimin_fifth=> fifth_u.gain;
		0=> seveth_u.gain;
	}

	else if (num == 5){
	//Diminished seventh
		minor_third=> third_u.gain;
		dimin_fifth=> fifth_u.gain;
		dimin_sevth=> seveth_u.gain;
	}

	else if (num == 6){
	//Half-diminished seventh
		minor_third=> third_u.gain;
		dimin_fifth=> fifth_u.gain;
		minor_sevth=> seveth_u.gain;
	}

	else if (num == 7){
	//Minor seventh
		minor_third=> third_u.gain;
		perfc_fifth=> fifth_u.gain;
		minor_sevth=> seveth_u.gain;
	}

	else if (num == 8){
	//Minor major seventh
		minor_third=> third_u.gain;
		perfc_fifth=> fifth_u.gain;
		major_sevth=> seveth_u.gain;
	}

	else if (num == 9){
	//Dominant seventh
		major_third=> third_u.gain;
		perfc_fifth=> fifth_u.gain;
		minor_sevth=> seveth_u.gain;
	}

	else if (num == 10){
	//Major seventh
		major_third=> third_u.gain;
		perfc_fifth=> fifth_u.gain;
		major_sevth=> seveth_u.gain;
	}

	else if (num == 11){
	//Augmented seventh
		major_third=> third_u.gain;
		augmt_fifth=> fifth_u.gain;
		minor_sevth=> seveth_u.gain;
	}

	else if (num == 12){
	//Augmented major seventh
		major_third=> third_u.gain;
		augmt_fifth=> fifth_u.gain;
		major_sevth=> seveth_u.gain;
	}
	else {
		<<< "Invalid chord number">>>;
	}
   }
}

/* Chords number
0  reset chord 

1 Major triad
2 Minor triad
3 Augmented triad
4 Diminished triad

5  Diminished seventh
6  Half-diminished seventh 
7  Minor seventh
8  Minor major seventh
9  Dominant seventh
10 Major seventh
11 Augmented seventh
12 Augmented major seventh
*/

//Step input;
//Std.mtof(64) => input.next;

//chord chord_1;

//input => chord_1.fondamental => TriOsc s0 => ADSR ad => LPF filt =>NRev rev => dac;
//	 chord_1.third() => TriOsc s1 => ad; 
//	 chord_1.fifth() => TriOsc s2 => ad; 
//	 chord_1.seventh() => TriOsc s3 => ad; 

//chord_1.set_chord(8);

//rev.mix(.05);
//Std.mtof(89) => filt.freq;
//ad.gain (0.1);
//ad.set (1::ms,3::ms,0.8,50::ms);

//while (1){
//ad.keyOn();
//200::ms => now;
//ad.keyOff();
//400::ms => now;
//}






