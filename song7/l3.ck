class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet;   
        .5 => s.gain;
        .6 => s.width;
            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 5" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

STRESC lpfc;
lpfc.connect(t $ ST , HW.kb.leftright /* freq */  , NULL /* Q */  );  

STGAINC gainc;
gainc.connect(lpfc $ ST , HW.kb.updown /* gain */  , 1. /* static gain */  );  

// CONTROLLERS:
// HW.lpd8.potar[1][1]   HW.lpd8.pad[1][1]  
// HW.kb.updown          HW.kb.leftright
// HW.nano.potar[1][1]   HW.nano.fader[1][1]      HW.nano.button_up[1][1]   HW.nano.button_down[1][1]
// HW.nano.button_back   HW.nano.button_play   HW.nano.button_forward   HW.nano.button_loop    HW.nano.button_stop   HW.nano.button_rec
// HW.launchpad.keys[16*0 + 0] /* pad 1:1 */  HW.launchpad.controls[1] /* ? */ 
// HW.launchpad.red[16*0 + 0]   HW.launchpad.green[16*0 + 0]   HW.launchpad.amber[16*0 + 0]   HW.launchpad.clear[16*0 + 0]
// HW.launchpad.redc[?]  HW.launchpad.greenc[?]  HW.launchpad.amberc[?]  HW.launchpad.clearc[?]    



while(1) {
       100::ms => now;
}
 


