


class synt0 extends SYNT{

		inlet => TriOsc s => PowerADSR padsr => outlet;		
				.5 => s.gain;
		.90 => s.width;
		padsr.set(0::ms , data.tick / 6 , .0000001, data.tick / 4);
		padsr.setCurves(2.0, 2.0, .5);

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		padsr.keyOn();}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.reg(synt0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.reg(synt0 s4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 
_1|3|5|8 _1|3|5|8
_5|7|9|c _5|7|9|c 
_3|5|7|a _3|5|7|a
_1|3|5|8 _1|3|5|8

_1|3|5|8 _1|3|5|8
_4|6|8|b _4|6|8|b
_2|4|6|9 _2|4|6|9
_1|3|5|8 _1|3|5|8

" => t.seq;
.21 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

ST st;

// filter to add in graph:
t.mono() => LPF filter => st.mono_in;
 
 //  BPF filter =>   HPF filter =>   BRF filter => 
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

// params
7 => filter.Q;
361 => base.next;
1395 => variable.gain;
1::second / (data.tick * 24 ) => mod.freq;
// If mod need to be synced
// 1 => int sync_mod;
// if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

fun void filter_freq_control (){ 
	    while(1) {
				      filter_freq.last() => filter.freq;
							      1::ms => now;
										    }
}
spork ~ filter_freq_control (); 

STECHO ech;
ech.connect(st $ ST , data.tick * 1/ 4 , .3); 

STAUTOPAN autopan;
autopan.connect(ech $ ST, -.6 /* span 0..1 */, 8*data.tick /* period */, 0.5 /* phase 0..1 */ );  autopan $ ST @=> ST @ last; 

/*
class STADSRC extends ST{
  ADSR al => outl;
  ADSR ar => outr;

  class control_a extends CONTROL {
    ADSR @ alp;
    ADSR @ arp;
    int state;
    int tog;
    int def_on;

    0 => update_on_reg ;

    fun void set (float in) {
      <<<"STADSRC in ", in>>>;

      if ( tog  ){
        if (in != 0.){
          if ( state  ){
            alp.keyOff();
            arp.keyOff();
            0 => state;
          }
          else {
            alp.keyOn();
            arp.keyOn();
            1 => state;
          }
        }
      }
      else { // NO TOG
        if (!def_on){
          if ( in != 0. ){
            alp.keyOn();
            arp.keyOn();
            1 => state;
          }
          else {
            alp.keyOff();
            arp.keyOff();
            0 => state;
          }
        }
        else {
          if ( in == 0. ){
            alp.keyOn();
            arp.keyOn();
            1 => state;
          }
          else {
            alp.keyOff();
            arp.keyOff();
            0 => state;
          }

        }

      }

      if ( state  ){
          <<<"STADSRC ON">>>;
      }
      else {
          <<<"STADSRC OFF">>>;
      }
    }
  }
  control_a ca;
  al @=> ca.alp;
  ar @=> ca.arp;

  fun void connect(ST @ tone, CONTROLER cont, dur attack, dur release, int default_on, int toggle) {
    default_on => ca.def_on;
    toggle =>  ca.tog;

    tone.left() => al;
    tone.right() => ar;
    al.set(attack, 0::ms, 1., release);
    ar.set(attack, 0::ms, 1., release);

    cont.reg(ca);

    if (default_on) {
      al.keyOn();
      ar.keyOn();
      1 => ca.state;
    }
    else {
      al.keyOff();
      ar.keyOff();
      0 => ca.state;
    }
  }


}
*/
// CONTROLLERS:
// HW.lpd8.potar[1][1]   HW.lpd8.pad[1][1]  
// HW.kb.updown          HW.kb.leftright
// HW.nano.potar[1][1]   HW.nano.fader[1][1]      HW.nano.button_up[1][1]   HW.nano.button_down[1][1]
// HW.nano.button_back   HW.nano.button_play   HW.nano.button_forward   HW.nano.button_loop    HW.nano.button_stop   HW.nano.button_rec
// HW.launchpad.keys[16*0 + 0] /* pad 1:1 */  HW.launchpad.controls[1] /* ? */ 
// HW.launchpad.red[16*0 + 0]   HW.launchpad.green[16*0 + 0]   HW.launchpad.amber[16*0 + 0]   HW.launchpad.clear[16*0 + 0]
// HW.launchpad.redc[?]  HW.launchpad.greenc[?]  HW.launchpad.amberc[?]  HW.launchpad.clearc[?]    

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*2 + 1] /* pad 3:2 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last;

STREV1 rev;
rev.connect(last, .3 /* mix */); 

//////////////////////////////////////
// ECHO SECTION
///////////////////////////////////
STADSRC stadsrc2;
stadsrc2.connect(autopan, HW.launchpad.keys[16*2 + 1] /* pad 3:2 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 0  /* toggle */); // stadsrc2 $ ST @=> last;

STECHO ech2;
ech2.connect(stadsrc2 $ ST , data.tick * 3/ 4 , .7); 

STAUTOPAN autopan2;
autopan2.connect(ech2 $ ST, -.6 /* span 0..1 */, 8*data.tick /* period */, 0.5 /* phase 0..1 */ );  

STREV1 rev2;
rev2.connect(autopan2 $ ST, .3 /* mix */); 

///////////////////////////////////////////////////

while(1) {
	     100::ms => now;
}
 

