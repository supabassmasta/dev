class PLOC0 extends SYNT{
    1 => own_adsr;
    inlet => Gain gin =>SinOsc s =>  PowerADSR padsr => outlet;   
    4 => gin.gain;
    padsr.set(1::ms, 20::ms, .00001 , 200::ms);
    padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
        .2 => s.gain;

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  { padsr.keyOn();  }
} 

class PLOC1 extends SYNT{
    1 => own_adsr;
    inlet => Gain gin =>SinOsc s => ABSaturator sat   =>   PowerADSR padsr => outlet;    
    4 => sat.drive;
    0 => sat.dcOffset;
    4 => gin.gain;
    padsr.set(1::ms, 20::ms, .00001 , 200::ms);
    padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
        .15 => s.gain;

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  { padsr.keyOn();  }
} 

class PLOC2 extends SYNT{
    1 => own_adsr;
    inlet => Gain gin =>TriOsc s=>   PowerADSR padsr => outlet;    
   4 => gin.gain;
    padsr.set(1::ms, 20::ms, .00001 , 200::ms);
    padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
        .14 => s.gain;

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  { padsr.keyOn();  }
} 

class PLOC3 extends SYNT{
    1 => own_adsr;
    inlet => Gain gin =>TriOsc s=>   PowerADSR padsr => outlet;    
   .45 => s.width;
   4 => gin.gain;
    padsr.set(1::ms, 15::ms, .00001 , 200::ms);
    padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
        .14 => s.gain;

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  { padsr.keyOn();  }
}

TONE t;

t.reg(PLOC3 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *4   11115555
" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 20::ms, .02, 400::ms);
//t.adsr[0].setCurves(0.5, .2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

//STAUTOPAN autopan;
//autopan.connect(t $ ST, .7 /* span 0..1 */, 4*data.tick /* period */, 0.62 /* phase 0..1 */ );  

//STREV1 rev;
//rev.connect(autopan $ ST, .3 /* mix */); 

while(1) {
       100::ms => now;
}

