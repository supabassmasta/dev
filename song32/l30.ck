class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{cFFFEFFF81" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 1.5 /* Q */, 3 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
AUTO.freq(":4 M////m") => stfreelpfx0.freq; // CONNECT THIS 

//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 

//STFREEPAN stfreepan0;
//stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
//SinOsc sin0 =>  stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0 
//0.1 => sin0.freq;
//1.0 => sin0.gain;
class STFREEPANX extends ST{

  Gain pan => OFFSET ofs0 => MULT ml => outl;
  1. => ofs0.offset;
//  0.5 => ofs0.gain;

  pan => OFFSET ofs1 => MULT mr => outr;
  -1. => ofs1.offset;
//  0.5 => ofs1.gain;


  fun void connect(ST @ tone) {
    tone.left() => ml;
    tone.right() => mr;
  }
}

//STFREEPANX stfreepan0;
//stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
//AUTO.pan("1///88////1")  => stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0 

while(1) {
       100::ms => now;
}
 
