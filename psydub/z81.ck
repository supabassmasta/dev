class synt0 extends SYNT{

		inlet => blackhole;
		Noise n => BPF bpf =>  outlet;		

		12 => bpf.Q;	

		fun void f1 (){ 
			while(1) {
				inlet.last() *2 => bpf.freq;

				1::ms => now;
			}

		} 
		spork ~ f1 ();



		fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
	} 

class synt1 extends SYNT{

		inlet => blackhole;
		Noise n => BPF bpf =>  outlet;		

		12 => bpf.Q;	

		fun void f1 (){ 
			while(1) {
				inlet.last() *4 => bpf.freq;

				1::ms => now;
			}

		} 
		spork ~ f1 ();



		fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
	} 


class synt2 extends SYNT{

		inlet => blackhole;
		Noise n => BPF bpf =>  outlet;		

		12 => bpf.Q;	

		fun void f1 (){ 
			while(1) {
				inlet.last()  => bpf.freq;

				1::ms => now;
			}

		} 
		spork ~ f1 ();



		fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
	} 


fun void f2 (){ 



	TONE t;
	t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
	// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
	"}c *2 1/zz/1" => t.seq;
	.9 => t.gain;
	t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
	// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
	//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
	t.go(); 

	STGAINC gainc;
	gainc.connect(t $ ST , HW.launchpad.keys[16*7 + 1] /* gain */  , .5 /* static gain */  );  

	STREV1 rev;
	rev.connect(gainc $ ST, .3 /* mix */); 

while(1) {
	     100::ms => now;
}

} 
spork ~ f2 ();

fun void f3 (){ 



	TONE t;
	t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
	// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
	"}c *3 1/zz/1" => t.seq;
	.9 => t.gain;
	t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
	// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
	//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
	t.go(); 

	STGAINC gainc;
	gainc.connect(t $ ST , HW.launchpad.keys[16*7 + 2] /* gain */  , .5 /* static gain */  );  

	STREV1 rev;
	rev.connect(gainc $ ST, .3 /* mix */); 
while(1) {
	     100::ms => now;
}

} 
spork ~ f3 ();

fun void f4 (){ 



	TONE t;
	t.reg(synt1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
	// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
	"}c *4 1/zz/1" => t.seq;
	.9 => t.gain;
	t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
	// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
	//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
	t.go(); 

	STGAINC gainc;
	gainc.connect(t $ ST , HW.launchpad.keys[16*7 + 3] /* gain */  , .5 /* static gain */  );  

	STREV1 rev;
	rev.connect(gainc $ ST, .3 /* mix */); 
while(1) {
	     100::ms => now;
}

} 
spork ~ f4 ();

fun void f5 (){ 



	TONE t;
	t.reg(synt1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
	// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
	"}c *2 1/zz/1" => t.seq;
	.9 => t.gain;
	t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
	// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
	//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
	t.go(); 

	STGAINC gainc;
	gainc.connect(t $ ST , HW.launchpad.keys[16*7 + 4] /* gain */  , .5 /* static gain */  );  

	STREV1 rev;
	rev.connect(gainc $ ST, .3 /* mix */); 
while(1) {
	     100::ms => now;
}

} 
spork ~ f5 ();

fun void f6 (){ 



	TONE t;
	t.reg(synt2 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
	// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
	"}c  1/zz/1" => t.seq;
	.9 => t.gain;
	t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
	// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
	//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
	t.go(); 

	STGAINC gainc;
	gainc.connect(t $ ST , HW.launchpad.keys[16*7 + 5] /* gain */  , .5 /* static gain */  );  

	STREV1 rev;
	rev.connect(gainc $ ST, .3 /* mix */); 
while(1) {
	     100::ms => now;
}

} 
spork ~ f6 ();

fun void f7 (){ 



	TONE t;
	t.reg(synt2 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
	// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
	"{c  z/11/z" => t.seq;
	.9 => t.gain;
	t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
	// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
	//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
	t.go(); 

	STGAINC gainc;
	gainc.connect(t $ ST , HW.launchpad.keys[16*7 + 6] /* gain */  , 1.8 /* static gain */  );  

	STREV1 rev;
	rev.connect(gainc $ ST, .3 /* mix */); 
while(1) {
	     100::ms => now;
}

} 
spork ~ f7 ();


while(1) {
	     100::ms => now;
}


