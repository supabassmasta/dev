class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c}c 1___ ____" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//  class STREVAUX extends ST{
//    STREV1 rev1;
//    STTOAUX toaux;
//  
//    fun void connect(ST @ tone, float mix) {
//      if ( check_output_nb() >= 4  ){
//        toaux.connect(tone, 1. - mix, mix, 1);
//        toaux.left() => outl;
//        toaux.right() => outr;
//      }
//      else {
//        <<<"STREVAUX: Not enough output, use STREV1 instead">>>;
//  
//        rev1.connect(tone, mix);
//        rev1.left() => outl;
//        rev1.right() => outr;
//      }
//  
//    }
//  
//  
//    fun int check_output_nb  (){ 
//       2 => int outnb; // By default assume there is two outputs
//  
//       FileIO fio;
//       fio.open( "./output_numbers.txt", FileIO.READ );
//       if( !fio.good() )
//       {
//          return 2;
//       }
//  
//       fio => outnb;
//       // <<<"STTOAUX: output number: ", outnb>>>;
//       return outnb;
//  
//    } 
//  
//  }

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
