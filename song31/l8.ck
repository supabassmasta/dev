class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c 1" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


  STADSR stadsr;
  stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
  //stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
  stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
//   stadsr.keyOn(); //stadsr.keyOff(); 
  
  MASTER_STADSR.reg(stadsr, 1);

//   class END extends end {
//     STADSR @ sta;
//     fun void kill_me () {
//     MASTER_STADSR.unreg(sta, 0);
//   }}; END the_end; me.id() => the_end.shred_id; killer.reg(the_end);  
//   stadsr @=> the_end.sta;

while(1) {
       100::ms => now;
}
