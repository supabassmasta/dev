AMBIENT2 s1;
s1.load(21);
AMBIENT2 s2;
s2.load(21);
AMBIENT2 s3;
s3.load(21);



TONE t;
t.reg(s1); t.reg(s2); t.reg(s3);//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"  :2
!1|!3|!5 1|3|5 !5|!7|!8 5|7|8
!1|!4|!6 _     !1|!5|!8 1|5|8

!1|!3|!5 1|3|5 !5|!7|!8 5|7|8
!1|!4|!6 1|4|6 !1|!5|!8 _
" => t.seq;
.25 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(600::ms, 10::ms, 1., 2000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(600::ms, 10::ms, 1., 2000::ms);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[2].set(600::ms, 10::ms, 1., 2000::ms);
t.adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

//STAUTOPAN autopan;
//autopan.connect(t $ ST, .6 /* span 0..1 */, 4*data.tick /* period */, 0.95 /* phase 0..1 */ );  

//STECHO ech;
//ech.connect(autopan $ ST , data.tick * 3 / 1 , .4); 



//STREV1 rev;
//rev.connect(ech $ ST, .2/* mix */); 




while(1) {
       100::ms => now;
}
 

