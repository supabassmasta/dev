AMBIENT a;

//a.load(19);
a.load(3);

TONE t;
t.reg(a);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
//t.dor();// t.aeo(); 

t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//"*4 11_2 _3__ " => t.seq;
":2
11__ ____ 
55__ ____
11__ ____ 
77__ 44__


		" => t.seq;
2.1 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(17::ms, 400::ms, .5, 3000::ms);
t.adsr[0].setCurves(.3, .3, .2); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

//STLPFC lpfc;
//lpfc.connect(t $ ST , HW.lpd8.potar[1][3] /* freq */  , HW.lpd8.potar[1][4] /* Q */  );  
//
//STECHO ech;
//ech.connect(t $ ST , data.tick * 3 / 4 , .5); 

STREV1 rev;
rev.connect(t $ ST, .3 /* mix */); 

while(1) {
	     100::ms => now;
}
 
