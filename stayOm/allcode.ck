// RYTHM
158 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// MIX
1. => data.master_gain;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
48 => data.ref_note;

// Start synchro
//HW.launchpad.virtual_key_on(7);

// LED STRIP
//HW.ledstrip.open();
//HW.ledstrip._load_preset('0');

//1::ms => now;

     
 digit dig;

Gain dac_temp => Pan2 P;

P.left => Gain gain_left => dac.left;
P.right => Gain gain_right => dac.right;
gain_right.gain(1);
 
// DUCKING
Gain ducking;
ADSR duck;
4::ms => dur duck_attack;
120::ms => dur duck_release;
duck.set (duck_release, 0::ms, 1, duck_attack);
duck.keyOn();

ducking => Gain remaining => dac_temp;
remaining.gain (0.1);

// SAMPLER

1=> int last_sampler_group;


class nano_sampler extends Chubgraph {
    9 => int nb_sp;
    sampler sp[nb_sp];
    ADSR    a[nb_sp];
    dur length;

   1 =>  int bypass_connected;

   inlet => Gain in => Gain bypass => outlet;
    for (0=>int i; i< nb_sp; i++){
     in => sp[i].connect => a[i] => outlet;
    a[i].keyOn();
       a[i].set(3::ms, 0::ms, 1, 3::ms);
    }   

    fun void set_dur (dur in) {
            in => length;
        for (0=>int i; i< nb_sp; i++){
        in => sp[i].max;
        in => sp[i].length;
        }
    }

    fun void on(int group, int on){
    if (on == 0) a[group -1].keyOff();
    else a[group -1].keyOn();
   }

   fun void add (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
   
        sp[group - 1].add();

        // Disconnet bypass while sampling
        in =< bypass;
				0=> bypass_connected;


   }
 
   fun void close (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
       
        // reconnect bypass when smapling is over
		if (!bypass_connected){
	        in => bypass;
				1=> bypass_connected;
    }

   }

   fun void remove_last (int group) {
           sp[group - 1].remove_last ();
   }
}


// EFFECT PATH 
 
Gain dig_in => disto dist => dig.connect => Gain tampon_phaser => PRCRev rev1 => PRCRev rev2 => Gain tampon => Gain tampon_in => Gain tampon_out => Gain tampon_bpf => LPF filt=> Gain out_effect => nano_sampler sp =>  ducking => duck =>  dac_temp;

sp.set_dur(16 * data.tick);


Std.mtof(127)=> filt.freq;

// ECHO GENERAL
tampon_out => Delay feed_back => tampon_out;
feed_back.gain(0);
15::second => feed_back.max;
data.tick => feed_back.delay ;

// REVERB
0 => rev1.mix => rev2.mix;


// ECHO SNARE
/* Gain input_snare => Gain tampon_snare => dig_in;
tampon_snare => Delay feed_back_snare => tampon_snare ;
feed_back_snare.gain(0);
3::second => feed_back_snare.max;
rythm_o.tick_delay => feed_back_snare.delay ;
*/


// BPF
tampon_out => BPF bpf_0 => out_effect;
bpf_0.Q (1);
bpf_0.freq (400);
bpf_0.gain (0);

tampon_out => BPF bpf_1 => out_effect;
bpf_1.Q (4);
bpf_1.freq (400);
bpf_1.gain (0);

tampon_out => BPF bpf_2 => out_effect;
bpf_2.Q (6);
bpf_2.freq (400);
bpf_2.gain (0);


fun void duck_run () {
    // sync
    // 2*rythm_o.tick_delay - (now % (2*rythm_o.tick_delay)) => now;

    while(1) {
    
        global_mixer.duck_trig => now;
        duck.keyOff();
        duck_attack => now;
        duck.keyOn();
    
        // duck_attack => now;
        // duck.keyOn();
        // 2*rythm_o.tick_delay - duck_attack => now;
        // duck.keyOff();
    }
    
}

spork ~  duck_run ();

// INIT inputs to dac_temp
global_mixer.line1 => dac_temp; // DIRECT NO EFFECT
global_mixer.line2 => dac_temp; // DIRECT NO EFFECT
global_mixer.line3 => ducking; // 
global_mixer.line4 => ducking; // 
global_mixer.line5 => ducking; // 
global_mixer.line6 => ducking; // 
// Stereo
global_mixer.stereo1 => gain_left;
global_mixer.stereo2 => gain_right;


 
/*********************************************
                NANO
*********************************************/
class nanomidi_ext extends nanomidi{
   
   fun void potar_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;
	 if (bank == 1 && group == 1) {
		Std.mtof(val)   => filt.freq;          
          
           }
        if (bank == 1 && group == 2) {
           
               if (val == 0) 1::samp => dig.ech;
               else {
                    (1./Std.mtof(127-val))::second => dig.ech;
               }
           
           }
      if (bank == 1 && group == 3) {
          (val + 1) * data.tick /8.  => feed_back.delay ;
          
           }

  	// REV
         if (bank == 1 && group == 4) {
	 
	 	val $ float / 256. => rev2.mix;
	 
//          	(val/4 + 1) * rythm_o.tick_delay / 2 => feed_back_snare.delay ;
	}

	// SAMPLER DUR
         if (bank == 1 && group == 5) {
		Math.pow (2, (val/16)) $ int => int nb_tick;
		sp.set_dur(nb_tick * data.tick);
		<<<"sampler dur =", 	nb_tick	, "* rythm_o.tick_delay">>>;
	}



	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain_in;          
          
           }
	// BPF
	 if (bank == 1 && group == 7) {
		Std.mtof(val)   => bpf_0.freq;          
          
           }
	 if (bank == 1 && group == 8) {
		Std.mtof(val)   => bpf_1.freq;          
          
           }
	 if (bank == 1 && group == 9) {
		Std.mtof(val)   => bpf_2.freq;          
          
           }

       
   }

   fun void fader_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;

if (bank == 1 ) {
        if (group == 1) {
          	(val $ float)/127   => out_effect.gain;
           }
        else if (group == 2) {
            (val $ float) / 1270. => dig.quant;
        }
        else  if (group == 3) {
            (val $ float) / 127. => feed_back.gain;
        }
	// REVERB
        else  if ( group == 4) {
	 	val $ float / 256. => rev1.mix;
//            (val $ float) / 127. => feed_back_snare.gain;
        }

        else  if (group ==5) {
        }
	

	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain;          
          
           }

	// BPF
        else  if (group == 7) {
            (val $ float) * 4 / 127. => bpf_0.gain;
        }
        else  if (group == 8) {
            (val $ float) * 4 / 127. => bpf_1.gain;
        }
        else  if (group == 9) {
            (val $ float) * 10 / 127. => bpf_2.gain;
		
        }
   }
   else if (bank == 2 ) {
	(val $ float)/127. * 4 => sp.a[group - 1].gain;

   }


   }
     

    fun void button_down_ext (int bank, int group, int val) {
        <<<"button down ", bank, group," : ",val>>>;
	if (bank == 1 && group == 1){
            // if (val != 0) {
                // global_mixer.line1 =< dac_temp; 
                // global_mixer.line1 => dig_in;  
            // }
            // else {
                // global_mixer.line1 =< dig_in; 
                // global_mixer.line1 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 2){
            // if (val != 0) {
                // global_mixer.line2 =< dac_temp; 
                // global_mixer.line2 => dig_in;  
            // }
            // else {
                // global_mixer.line2 =< dig_in; 
                // global_mixer.line2 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 3){
            if (val != 0) {
                global_mixer.line3 =< ducking; 
                global_mixer.line3 => dig_in;  
            }
            else {
                global_mixer.line3 =< dig_in; 
                global_mixer.line3 => ducking;  
            }
        }
        else if (bank == 1 && group == 4){
            if (val != 0) {
                global_mixer.line4 =< ducking; 
                global_mixer.line4 => dig_in;  
            }
            else {
                global_mixer.line4 =< dig_in; 
                global_mixer.line4 => ducking;  
            }
        }
        else if (bank == 1 && group == 5){
            if (val != 0) {
                global_mixer.line5 =< ducking; 
                global_mixer.line5 => dig_in;  
            }
            else {
                global_mixer.line5 =< dig_in; 
                global_mixer.line5 => ducking;  
            }
        }
        else if (bank == 1 && group == 6){
            if (val != 0) {
                global_mixer.line6 =< ducking; 
                global_mixer.line6 => dig_in;  
            }
            else {
                global_mixer.line6 =< dig_in; 
                global_mixer.line6 => ducking;  
            }
        }
        else if (bank == 2 ){
		sp.on(group, val);
	}
	

    }

// AUTO ECHO
0=> int echo_on_flag;

fun void echo_on (dur duration){
	//tampon_out => Delay feed_back => tampon_out;
	//feed_back.gain(0);
	
	feed_back.delay (1::ms);
	feed_back.gain(0);
	1::ms => now;

	1=> echo_on_flag;

	3 * data.tick => feed_back.delay ;
	feed_back.gain(.8);

	duration => now;

	if (echo_on_flag){
		feed_back.gain(1);
		tampon_in.gain(0);
	}
}

fun void echo_off (){

	0=> echo_on_flag;
	feed_back.gain(0);
	tampon_in.gain(1);
}


    fun void button_up_ext (int bank, int group, int val) {
/*       if (bank == 1 && group == 3){
            if (val != 0) {
                spork ~ echo_on(3::second);  
            }
	    else {
                spork ~ echo_off();  
            }
	}*/

        <<<"button up ", bank, group," : ",val>>>;
	if (bank == 1 || bank == 2){
	    if (val == 0) {
		sp.close (group);
	    }
	    else {
		 sp.add (group);
		// close last group to avoid simultaneous multi sampling
/*		if (last_sampler_group != 0 && last_sampler_group != group) {
		    <<< "FORCED CLOSE", last_sampler_group, group >>>;
		    sp.close (last_sampler_group);
		}
*/

		    group => last_sampler_group;


	    }
        }





    }     
    
    fun void button_rec_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
        	<<<"Add new buffer on sampler: ",last_sampler_group>>>;
	        sp.add (last_sampler_group);
        }
    }

    fun void button_loop_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
	      <<<"remove last buffer  on sampler: ",last_sampler_group>>>;
		sp.remove_last(last_sampler_group);
        } 
     }

// SAMPLE one meas

fun void stop_sample_meas (int g){
    sp.sp[0].length => now;       
        sp.close (g);
}


    fun void button_forward_ext (int val) {
         if (val != 0 && last_sampler_group!=0) {
                    <<<"Sample one meas on sampler: ", last_sampler_group>>>;
                sp.add (last_sampler_group);
                    spork ~ stop_sample_meas(last_sampler_group );
             }
            }

// STOP sampling

    fun void button_stop_ext (int val) {
			<<<"TOTO">>>;
            if (val != 0 && last_sampler_group!=0) {
                 <<<"Stop sampling on sampler:", last_sampler_group>>>;
                 sp.close (last_sampler_group);
             }           
        }

}


nanomidi_ext nano;
nano.start_midi_rcv();
<<<"Effects">>>;


launcher laun;

laun.load_file("files_launch.txt");

while(1) 100000::ms=> now;
32 =>  data.page_manager_page_nb;
1::samp =>  now;
  "Midi Through Port-0" => string device;

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;

  // open the device
  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    min.printerr( 0 );

    // open the device
    if( min.open( i ) )
    {
      if ( min.name() == device )  {

        <<< "device", i, "->", min.name(), "->", "open as input: SUCCESS" >>>;

        break;
      }
      else {
        //					min.close();
      }

    }
    else {
      <<<"Cannot open", device>>>; 	
      break;
    }

  }

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

0 => int synced;

// infinite time-loop
while( synced == 0 )
{
    // wait on the event 'min'
    min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
        // print out midi message
        <<< msg.data1, msg.data2, msg.data3 >>>;

        if (  msg.data1 == 148 && msg.data2 == 127 && msg.data3 == 127 ){
             MASTER_SEQ3.update_ref_times(now, data.tick * 4);

             1 => synced;
             <<<"PARALLEL SYNC message received, SYNCED, exit script">>>;

        }
    }
}

1::ms => now;
  "Midi Through Port-0" => string device;
MidiOut mout;

  // open the device
  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    mout.printerr( 0 );

    // open the device
    if( mout.open( i ) )
    {
      if ( mout.name() == device ) {

        if(mout.open(i)) {
          <<< "device", i, "->", mout.name(), "->", "open as output: SUCCESS" >>>;
        }
        else {
          <<<"Fail to open launchpad as output">>>; 
        }

        break;
      }
      else {
//        					mout.close();
      }

    }
    else {
      <<<"Cannot open", device>>>; 	
      break;
    }

  }

<<< "MIDI device:", mout.num(), " -> ", mout.name() >>>;


    MidiMsg msg;
    
    148 => msg.data1;
    127 => msg.data2;
    127 => msg.data3;
    mout.send(msg);

<<<"PARALLEL SYNC Message sent, exit script">>>;

    1::ms => now;
    
class string_dummy
{
    string my_string;
}

public class ROOTPATH {
  static  string_dummy @ str;
}

new string_dummy @=> ROOTPATH.str;


// CHANGE PATH HERE
"../" =>  ROOTPATH.str.my_string;


while(1) 1000::ms => now;

Machine.add("../include/include.ck");
me.yield();

1::ms => now;

if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

Machine.add("_save_replace_down.ck:" + me.arg(0) );

while (1) 1000::ms=>now;

if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

me.arg(0) => string file_name;

Machine.add( file_name) => int shred_id;

fun void kb_management (Hid hi)
    {
        HidMsg msg; 
        int num;
        // infinite event loop
        while( true )
        {
            // wait on event
            hi => now;
        
            // get one or more messages
            while( hi.recv( msg ) )
            {
                //<<<"note_active 1",note_active>>>;
                // check for action type
                if( msg.isButtonDown() )
                {
                     //<<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                    if(msg.which == 31 ){
												// Tempo to save file
												200::ms => now;
                        Machine.remove(shred_id);
                        Machine.add( file_name)=> shred_id;
                    
                    }

                }
            }
        }
    }
    
    
    
        //--------------------------------------------//
        //               kb Init                      //
        //--------------------------------------------//
        Hid hi;

        // open keyboard 0
        if( !hi.openKeyboard( 0 ) ) me.exit();
        <<< "keyboard '" + hi.name() + "' ready", "" >>>;

        spork ~ kb_management(hi);

        
while(1) 10::second => now;
Machine.add("rootpath.ck");
me.yield();

// CHANGE ALSO ROOT PATH HERE
Machine.add("../include/include.ck");
me.yield();

Machine.add( "launch.ck" );
//<<<data.bpm>>>;
//Machine.add( "test.ck" );
//Machine.add( "super_seq_top.ck" );

1::ms => now;
Machine.add("parallel_sync_receive.ck");

500::ms => now;

Machine.add("parallel_sync_send.ck");

while (1) 100000::ms=>now;
<<<"sup",now/1::second>>>;
0 => int i;
seq_script s[12];

// s0.ck vap_loop
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0.  << 0. ;
i++;


for (0 => int j; j < i; j++) {
   data.bpm/data.meas_size => s[j].bpm;
	 0=>s[j].sync_on;
   s[j].go();
}


2 * data.meas_size * data.tick => now;

//<<<"sup2",now/1::second>>>;
data.super_seq_reset_ev.broadcast();
// Wait to allow all includes to launch
data.wait_before_start => now;

while (1) {

	Machine.add("super_seq.ck");

	data.super_seq_reset_ev => now;

}
Machine.status();

1::ms => now;
            MASTER_SEQ3.update_ref_times(now, data.tick * 4);

            10::ms => now;

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); //
SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"k" => s.seq;
.6 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//*3:2
//k__ __k k__ u__
"*2
k___ u___
k___ u___
k___ u__k
k___ uk__

k___ u___
k___ u___
kk__ u__k
k___ uk__

" => s.seq;
.9 * data.master_gain => s.gain; // 
s.gain("u", .4); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// 
SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("k", s2.wav["l"]); //
s.gain_subwav("K", 0, .3);

s.go();     s $ ST @=> ST @ last; 

STDUCKMASTER2 duckm2;
duckm2.connect(last $ ST );      duckm2 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
class nirx extends note_info_rx {
  PowerADSR @ pa;  
  float rel_attack;
  float rel_decay;
  float sustain;
  float rel_release;
  float rel_release_pos;
  0 => int off_cnt;

  fun void off(int nb, dur att_dec_sus) {
    att_dec_sus => now;
    if (nb == off_cnt) {
      pa.keyOff();
//            <<<"OFF: ", nb>>>;
    }
    // else skip, new note already ongoing
    //    else {
    //      <<<"OFF skipped: ", nb, "off_cnt :", off_cnt>>>;
    //    }
  }

  fun void push(note_info_t @ ni ) {
    if(ni.on) {
      pa.set(rel_attack * ni.d , rel_decay * ni.d , sustain, rel_release * ni.d);
      1. / sustain => pa.gain;
      pa.keyOn();

      1 +=> off_cnt;
      spork ~ off( off_cnt,  ni.d + (rel_release_pos*ni.d) );
    }
  }

}


class ADSRMOD {

  Step stp => PowerADSR padsr;
  1. => stp.next;

  nirx nio;
  padsr @=> nio.pa;
  fun void connect(SYNT @ synt, note_info_tx @ ni_tx) {

    3 => synt.inlet.op;
    padsr => synt.inlet;

    // Register note info rx in tx
    ni_tx.reg(nio);

  }

  fun void adsr_set(float ra, float rd, float sustain, float rr_pos, float rr) {
    ra => nio.rel_attack;
    rd => nio.rel_decay;
    sustain => nio.sustain;
    rr_pos => nio.rel_release_pos;
    rr => nio.rel_release;
  }

}

class synt0 extends SYNT{
    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c _1" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, 1., 40::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ADSRMOD adsrmod;
adsrmod.adsr_set(0.001 /* relative attack dur */, 0.000001 /* relative decay dur */ , 1.0 /* sustain */, - 0.5 /* relative sustain pos */, .3 /* relative sustain dur */);
adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */);

while(1) {
       100::ms => now;
}
 
class nirx extends note_info_rx {
  PowerADSR @ pa;  
  float rel_attack;
  float rel_decay;
  float sustain;
  float rel_release;
  float rel_release_pos;
  0 => int off_cnt;

  fun void off(int nb, dur att_dec_sus) {
    att_dec_sus => now;
    if (nb == off_cnt) {
      pa.keyOff();
//            <<<"OFF: ", nb>>>;
    }
    // else skip, new note already ongoing
    //    else {
    //      <<<"OFF skipped: ", nb, "off_cnt :", off_cnt>>>;
    //    }
  }

  fun void push(note_info_t @ ni ) {
    if(ni.on) {
      pa.set(rel_attack * ni.d , rel_decay * ni.d , sustain, rel_release * ni.d);
      1. / sustain => pa.gain;
      pa.keyOn();

      1 +=> off_cnt;
      spork ~ off( off_cnt,  ni.d + (rel_release_pos*ni.d) );
    }
  }

}


class ADSRMOD {

  Step stp => PowerADSR padsr;
  1. => stp.next;

  nirx nio;
  padsr @=> nio.pa;
  fun void connect(SYNT @ synt, note_info_tx @ ni_tx) {

    3 => synt.inlet.op;
    padsr => synt.inlet;

    // Register note info rx in tx
    ni_tx.reg(nio);

  }

  fun void adsr_set(float ra, float rd, float sustain, float rr_pos, float rr) {
    ra => nio.rel_attack;
    rd => nio.rel_decay;
    sustain => nio.sustain;
    rr_pos => nio.rel_release_pos;
    rr => nio.rel_release;
  }

}

class synt0 extends SYNT{
8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => TriOsc s2 => final;    1. => detune[i].gain;    .8 =>s2.gain; i++;  
inlet => detune[i] => s[i] => final;    2. => detune[i].gain;    .5 => s[i].gain; i++;  

fun void on()  {   0. => s[0].phase => s[2].phase =>  s2.phase;
}  fun void off() { }  fun void new_note(int idx)  {
  
  } 0 => own_adsr;
}

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c*4 111_  " => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, 1., 20::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ADSRMOD adsrmod;
adsrmod.adsr_set(0.02 /* relative attack dur */, 0.2 /* relative decay dur */ , 0.3 /* sustain */, - 0.5 /* relative sustain pos */, .3 /* relative sustain dur */);
adsrmod.padsr.setCurves(1., 2., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */);

while(1) {
       100::ms => now;
}
 
class nirx extends note_info_rx {
  PowerADSR @ pa;  
  float rel_attack;
  float rel_decay;
  float sustain;
  float rel_release;
  float rel_release_pos;
  0 => int off_cnt;

  fun void off(int nb, dur att_dec_sus) {
    att_dec_sus => now;
    if (nb == off_cnt) {
      pa.keyOff();
//            <<<"OFF: ", nb>>>;
    }
    // else skip, new note already ongoing
    //    else {
    //      <<<"OFF skipped: ", nb, "off_cnt :", off_cnt>>>;
    //    }
  }

  fun void push(note_info_t @ ni ) {
    if(ni.on) {
      pa.set(rel_attack * ni.d , rel_decay * ni.d , sustain, rel_release * ni.d);
      1. / sustain => pa.gain;
      pa.keyOn();

      1 +=> off_cnt;
      spork ~ off( off_cnt,  ni.d + (rel_release_pos*ni.d) );
    }
  }

}


class ADSRMOD {

  Step stp => PowerADSR padsr;
  1. => stp.next;

  nirx nio;
  padsr @=> nio.pa;
  fun void connect(SYNT @ synt, note_info_tx @ ni_tx) {

    3 => synt.inlet.op;
    padsr => synt.inlet;

    // Register note info rx in tx
    ni_tx.reg(nio);

  }

  fun void adsr_set(float ra, float rd, float sustain, float rr_pos, float rr) {
    ra => nio.rel_attack;
    rd => nio.rel_decay;
    sustain => nio.sustain;
    rr_pos => nio.rel_release_pos;
    rr => nio.rel_release;
  }

}

class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
    .15 => s.width;
      .7 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {0 => s.phase; } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c *4 _!1!1!1  " => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, 1., 20::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(3 *10 /* Base */, 8 * 100 /* Variable */, 1.1 /* Q */);
stsynclpf.adsr_set(.1 /* Relative Attack */, .7/* Relative Decay */, .0001 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

ADSRMOD adsrmod;
adsrmod.adsr_set(0.1 /* relative attack dur */, 0.0000001 /* relative decay dur */ , 1.0 /* sustain */, - 0.5 /* relative sustain pos */, .3 /* relative sustain dur */);
adsrmod.padsr.setCurves(1., 2., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */);

while(1) {
       100::ms => now;
}
 
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 
hihihihihihihihi
hihihihihihi *3:2 hihi_i *2:3
hihihihihihihihi
hihihihi *3:2 hihiij hihi_i *2:3
" => s.seq;
.2 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STADSR stadsr;
stadsr.set(0::ms /* Attack */, 11::ms /* Decay */, .6 /* Sustain */, 6 * 10::ms /* Sustain dur */,  10::ms /* release */);
stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last; 

STDUCK2 duck2;
duck2.connect(last $ ST, 9. /* Side Chain Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 12 *10::ms /* Release */ );      duck2 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"1_" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ADSRMOD adsrmod;
adsrmod.adsr_set(0.001 /* relative attack dur */, 0.000001 /* relative decay dur */ , 1.0 /* sustain */, - 0.5 /* relative sustain pos */, .3 /* relative sustain dur */);
adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

while(1) {
       100::ms => now;
}
 
TONE t;
t.reg(SUPERSAW0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 {c
_1__ __1_
__1_ _#4__
_1_1 __1_
__1_ _A__

_1__ __1_
__1_ _#4_*2 #4!#4 :2
_1_1 __1_
__1_ _*2 A!A!A!A!A!A :2
" => t.seq;
.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

DETUNE detune;
detune.base_synt(s0 /* base synt, controlling others */);
detune.reg_aux(SUPERSAW0 aux1); /* declare and register aux here */
detune.config_aux(2.00 /* detune percentage */, .5 /* aux gain output */ );  

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 2::ms /* dur range */, 74 /* freq */); 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 7 * 100 /* Variable */, 3. /* Q */);
stsynclpf.adsr_set(.3 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .1 /* Relative Sustain dur */, 0.5 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .1);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//*3:2
//k__ __k k__ u__
"*2
____ ____
____ ____
____ ____
____ *2 ___u ____ :2

____ ____
____ ____
__ab ____
____ *2 ___u ____ :2

" => s.seq;
.4 * data.master_gain => s.gain; // 
s.gain("u", .3); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// 
SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("k", s2.wav["l"]); //
s.gain_subwav("K", 0, .3);

s.go();     s $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
" *4

k___ u__s __k_ u___
k___ u__k _sk_ u___
k___ u_ks _sk_ u___
k___ u__k _sk_ u___


" => s.seq;
.9 * data.master_gain => s.gain; // 
s.gain("u", .4); // for single wav 
s.gain("s", .1); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV ////
SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("k", s2.wav["l"]); //
s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STDUCKMASTER2 duckm2;
duckm2.connect(last $ ST );      duckm2 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 
_ihi_ihi_ihi_i *2hihi:2
_ihi_ihijihi *2hi_i:2 _i
" => s.seq;
.3 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STADSR stadsr;
stadsr.set(0::ms /* Attack */, 11::ms /* Decay */, .6 /* Sustain */, 6 * 10::ms /* Sustain dur */,  10::ms /* release */);
stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last; 

//STDUCK2 duck2;
//duck2.connect(last $ ST, 9. /* Side Chain Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 12 *10::ms /* Release */ );      duck2 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); //
SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
//SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
" *4

____ ____ ____ _xYz
____ ____ ____ __a_
____ ____ ____ _XzA
____ ____ ____ __a_


" => s.seq;
1.0 * data.master_gain => s.gain; // 
//s.gain("u", .4); // for single wav 
//s.gain("s", .1); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 


while(1) {
       100::ms => now;
}
 
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
SET_WAV.TRIBAL1(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
u_v_ __A_ v_u_ __B_
u_v_ __A_ v_u_ wxB_

u_v_ __A_ v_u_ __B_
u_vu _uA_ vvu_ wxB_
" => s.seq;
.5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last;

while(1) {
       100::ms => now;
}
 
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
SET_WAV.TRIBAL1(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
u_v_ __A_ v_u_ __B_
u_v_ __A_ v_u_ wxB_

u_v_ __A_ v_u_ __B_
u_vu _uA_ vvu_ wxB_
" => s.seq;
.5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{
    inlet => Gain in;
    Gain out =>  outlet;   

    0 => int i;
    Gain opin[8];
    Gain opout[8];
    PowerADSR adsrop[8];
    SinOsc osc[8];

    // build and config operators
    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1. => opin[i].gain;
    adsrop[i].set(1::ms, 20::ms, .9 , 200::ms);
    adsrop[i].setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] =>  SqrOsc sqr=> adsrop[i] => opout[i];
    1./2. + 0.00 => opin[i].gain;
    adsrop[i].set(20::ms, 2*data.tick, .00001 , 200::ms);
    adsrop[i].setCurves(.2, .2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    2 * 11 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    2. => opin[i].gain;
    adsrop[i].set(10::ms, 18::ms, .9 , 10::ms);
    adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    .2 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./2. +0.000 => opin[i].gain;
    adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
    adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    30 => adsrop[i].gain;
    i++;

    // connect operators
    // main osc
    in => opin[0]; opout[0]=> out; 

    // modulators
    in => opin[1];
    opout[1] => opin[0];

    in => opin[2];
    opout[2] => out;
    opout[1] => opin[2];

    in => opin[3];
    // opout[3] => opin[0];


    .5 => out.gain;

    fun void on()  
    {
      for (0 => int i; i < 8      ; i++)
      {
            adsrop[i].keyOn();
                // 0=> osc[i].phase;
      }
            
    } 
        
        fun void off() 
        {
          for (0 => int i; i < 8      ; i++) 
          {
                adsrop[i].keyOff();
          }
                      
                                        
        } 
            
            fun void new_note(int idx)  
            { 
                         
            }
             1 => own_adsr;
}  


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //
20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4
{c
AA__ AA__ 888_ ____
}c
A__A __1_ 3_1_ #4///#4_
{c
11__ 1_1_ 5__5 __5_
}c
1__1 __0_ 2_0_ 333_


" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //
t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF2 stsynclpf;
stsynclpf.freq(13 * 10 /* Base */, 3 * 100 /* Variable */, 1.1 /* Q */);
stsynclpf.adsr_set(.2 /* Relative Attack */, .1/* Relative Decay */, 0.8 /* Sustain */, .2 /* Relative Sustain dur */, 0.5 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STDUCK2 duck2;
duck2.connect(last $ ST, 3. /* Side Chain Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 13::ms /* Release */ );      duck2 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
LONG_WAV l;
"../_SAMPLES/stayOm/mingusmontageSatan4.wav" => l.read;
0.4 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


while(1) {
       100::ms => now;
}
 
// RYTHM
158 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// MIX
1. => data.master_gain;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
48 => data.ref_note;

// Start synchro
//HW.launchpad.virtual_key_on(7);

// LED STRIP
//HW.ledstrip.open();
//HW.ledstrip._load_preset('0');

//1::ms => now;

     
 digit dig;

Gain dac_temp => Pan2 P;

P.left => Gain gain_left => dac.left;
P.right => Gain gain_right => dac.right;
gain_right.gain(1);
 
// DUCKING
Gain ducking;
ADSR duck;
4::ms => dur duck_attack;
120::ms => dur duck_release;
duck.set (duck_release, 0::ms, 1, duck_attack);
duck.keyOn();

ducking => Gain remaining => dac_temp;
remaining.gain (0.1);

// SAMPLER

1=> int last_sampler_group;


class nano_sampler extends Chubgraph {
    9 => int nb_sp;
    sampler sp[nb_sp];
    ADSR    a[nb_sp];
    dur length;

   1 =>  int bypass_connected;

   inlet => Gain in => Gain bypass => outlet;
    for (0=>int i; i< nb_sp; i++){
     in => sp[i].connect => a[i] => outlet;
    a[i].keyOn();
       a[i].set(3::ms, 0::ms, 1, 3::ms);
    }   

    fun void set_dur (dur in) {
            in => length;
        for (0=>int i; i< nb_sp; i++){
        in => sp[i].max;
        in => sp[i].length;
        }
    }

    fun void on(int group, int on){
    if (on == 0) a[group -1].keyOff();
    else a[group -1].keyOn();
   }

   fun void add (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
   
        sp[group - 1].add();

        // Disconnet bypass while sampling
        in =< bypass;
				0=> bypass_connected;


   }
 
   fun void close (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
       
        // reconnect bypass when smapling is over
		if (!bypass_connected){
	        in => bypass;
				1=> bypass_connected;
    }

   }

   fun void remove_last (int group) {
           sp[group - 1].remove_last ();
   }
}


// EFFECT PATH 
 
Gain dig_in => disto dist => dig.connect => Gain tampon_phaser => PRCRev rev1 => PRCRev rev2 => Gain tampon => Gain tampon_in => Gain tampon_out => Gain tampon_bpf => LPF filt=> Gain out_effect => nano_sampler sp =>  ducking => duck =>  dac_temp;

sp.set_dur(16 * data.tick);


Std.mtof(127)=> filt.freq;

// ECHO GENERAL
tampon_out => Delay feed_back => tampon_out;
feed_back.gain(0);
15::second => feed_back.max;
data.tick => feed_back.delay ;

// REVERB
0 => rev1.mix => rev2.mix;


// ECHO SNARE
/* Gain input_snare => Gain tampon_snare => dig_in;
tampon_snare => Delay feed_back_snare => tampon_snare ;
feed_back_snare.gain(0);
3::second => feed_back_snare.max;
rythm_o.tick_delay => feed_back_snare.delay ;
*/


// BPF
tampon_out => BPF bpf_0 => out_effect;
bpf_0.Q (1);
bpf_0.freq (400);
bpf_0.gain (0);

tampon_out => BPF bpf_1 => out_effect;
bpf_1.Q (4);
bpf_1.freq (400);
bpf_1.gain (0);

tampon_out => BPF bpf_2 => out_effect;
bpf_2.Q (6);
bpf_2.freq (400);
bpf_2.gain (0);


fun void duck_run () {
    // sync
    // 2*rythm_o.tick_delay - (now % (2*rythm_o.tick_delay)) => now;

    while(1) {
    
        global_mixer.duck_trig => now;
        duck.keyOff();
        duck_attack => now;
        duck.keyOn();
    
        // duck_attack => now;
        // duck.keyOn();
        // 2*rythm_o.tick_delay - duck_attack => now;
        // duck.keyOff();
    }
    
}

spork ~  duck_run ();

// INIT inputs to dac_temp
global_mixer.line1 => dac_temp; // DIRECT NO EFFECT
global_mixer.line2 => dac_temp; // DIRECT NO EFFECT
global_mixer.line3 => ducking; // 
global_mixer.line4 => ducking; // 
global_mixer.line5 => ducking; // 
global_mixer.line6 => ducking; // 
// Stereo
global_mixer.stereo1 => gain_left;
global_mixer.stereo2 => gain_right;


 
/*********************************************
                NANO
*********************************************/
class nanomidi_ext extends nanomidi{
   
   fun void potar_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;
	 if (bank == 1 && group == 1) {
		Std.mtof(val)   => filt.freq;          
          
           }
        if (bank == 1 && group == 2) {
           
               if (val == 0) 1::samp => dig.ech;
               else {
                    (1./Std.mtof(127-val))::second => dig.ech;
               }
           
           }
      if (bank == 1 && group == 3) {
          (val + 1) * data.tick /8.  => feed_back.delay ;
          
           }

  	// REV
         if (bank == 1 && group == 4) {
	 
	 	val $ float / 256. => rev2.mix;
	 
//          	(val/4 + 1) * rythm_o.tick_delay / 2 => feed_back_snare.delay ;
	}

	// SAMPLER DUR
         if (bank == 1 && group == 5) {
		Math.pow (2, (val/16)) $ int => int nb_tick;
		sp.set_dur(nb_tick * data.tick);
		<<<"sampler dur =", 	nb_tick	, "* rythm_o.tick_delay">>>;
	}



	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain_in;          
          
           }
	// BPF
	 if (bank == 1 && group == 7) {
		Std.mtof(val)   => bpf_0.freq;          
          
           }
	 if (bank == 1 && group == 8) {
		Std.mtof(val)   => bpf_1.freq;          
          
           }
	 if (bank == 1 && group == 9) {
		Std.mtof(val)   => bpf_2.freq;          
          
           }

       
   }

   fun void fader_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;

if (bank == 1 ) {
        if (group == 1) {
          	(val $ float)/127   => out_effect.gain;
           }
        else if (group == 2) {
            (val $ float) / 1270. => dig.quant;
        }
        else  if (group == 3) {
            (val $ float) / 127. => feed_back.gain;
        }
	// REVERB
        else  if ( group == 4) {
	 	val $ float / 256. => rev1.mix;
//            (val $ float) / 127. => feed_back_snare.gain;
        }

        else  if (group ==5) {
        }
	

	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain;          
          
           }

	// BPF
        else  if (group == 7) {
            (val $ float) * 4 / 127. => bpf_0.gain;
        }
        else  if (group == 8) {
            (val $ float) * 4 / 127. => bpf_1.gain;
        }
        else  if (group == 9) {
            (val $ float) * 10 / 127. => bpf_2.gain;
		
        }
   }
   else if (bank == 2 ) {
	(val $ float)/127. * 4 => sp.a[group - 1].gain;

   }


   }
     

    fun void button_down_ext (int bank, int group, int val) {
        <<<"button down ", bank, group," : ",val>>>;
	if (bank == 1 && group == 1){
            // if (val != 0) {
                // global_mixer.line1 =< dac_temp; 
                // global_mixer.line1 => dig_in;  
            // }
            // else {
                // global_mixer.line1 =< dig_in; 
                // global_mixer.line1 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 2){
            // if (val != 0) {
                // global_mixer.line2 =< dac_temp; 
                // global_mixer.line2 => dig_in;  
            // }
            // else {
                // global_mixer.line2 =< dig_in; 
                // global_mixer.line2 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 3){
            if (val != 0) {
                global_mixer.line3 =< ducking; 
                global_mixer.line3 => dig_in;  
            }
            else {
                global_mixer.line3 =< dig_in; 
                global_mixer.line3 => ducking;  
            }
        }
        else if (bank == 1 && group == 4){
            if (val != 0) {
                global_mixer.line4 =< ducking; 
                global_mixer.line4 => dig_in;  
            }
            else {
                global_mixer.line4 =< dig_in; 
                global_mixer.line4 => ducking;  
            }
        }
        else if (bank == 1 && group == 5){
            if (val != 0) {
                global_mixer.line5 =< ducking; 
                global_mixer.line5 => dig_in;  
            }
            else {
                global_mixer.line5 =< dig_in; 
                global_mixer.line5 => ducking;  
            }
        }
        else if (bank == 1 && group == 6){
            if (val != 0) {
                global_mixer.line6 =< ducking; 
                global_mixer.line6 => dig_in;  
            }
            else {
                global_mixer.line6 =< dig_in; 
                global_mixer.line6 => ducking;  
            }
        }
        else if (bank == 2 ){
		sp.on(group, val);
	}
	

    }

// AUTO ECHO
0=> int echo_on_flag;

fun void echo_on (dur duration){
	//tampon_out => Delay feed_back => tampon_out;
	//feed_back.gain(0);
	
	feed_back.delay (1::ms);
	feed_back.gain(0);
	1::ms => now;

	1=> echo_on_flag;

	3 * data.tick => feed_back.delay ;
	feed_back.gain(.8);

	duration => now;

	if (echo_on_flag){
		feed_back.gain(1);
		tampon_in.gain(0);
	}
}

fun void echo_off (){

	0=> echo_on_flag;
	feed_back.gain(0);
	tampon_in.gain(1);
}


    fun void button_up_ext (int bank, int group, int val) {
/*       if (bank == 1 && group == 3){
            if (val != 0) {
                spork ~ echo_on(3::second);  
            }
	    else {
                spork ~ echo_off();  
            }
	}*/

        <<<"button up ", bank, group," : ",val>>>;
	if (bank == 1 || bank == 2){
	    if (val == 0) {
		sp.close (group);
	    }
	    else {
		 sp.add (group);
		// close last group to avoid simultaneous multi sampling
/*		if (last_sampler_group != 0 && last_sampler_group != group) {
		    <<< "FORCED CLOSE", last_sampler_group, group >>>;
		    sp.close (last_sampler_group);
		}
*/

		    group => last_sampler_group;


	    }
        }





    }     
    
    fun void button_rec_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
        	<<<"Add new buffer on sampler: ",last_sampler_group>>>;
	        sp.add (last_sampler_group);
        }
    }

    fun void button_loop_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
	      <<<"remove last buffer  on sampler: ",last_sampler_group>>>;
		sp.remove_last(last_sampler_group);
        } 
     }

// SAMPLE one meas

fun void stop_sample_meas (int g){
    sp.sp[0].length => now;       
        sp.close (g);
}


    fun void button_forward_ext (int val) {
         if (val != 0 && last_sampler_group!=0) {
                    <<<"Sample one meas on sampler: ", last_sampler_group>>>;
                sp.add (last_sampler_group);
                    spork ~ stop_sample_meas(last_sampler_group );
             }
            }

// STOP sampling

    fun void button_stop_ext (int val) {
			<<<"TOTO">>>;
            if (val != 0 && last_sampler_group!=0) {
                 <<<"Stop sampling on sampler:", last_sampler_group>>>;
                 sp.close (last_sampler_group);
             }           
        }

}


nanomidi_ext nano;
nano.start_midi_rcv();
<<<"Effects">>>;


launcher laun;

laun.load_file("files_launch.txt");

while(1) 100000::ms=> now;
32 =>  data.page_manager_page_nb;
1::samp =>  now;
  "Midi Through Port-0" => string device;

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;

  // open the device
  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    min.printerr( 0 );

    // open the device
    if( min.open( i ) )
    {
      if ( min.name() == device )  {

        <<< "device", i, "->", min.name(), "->", "open as input: SUCCESS" >>>;

        break;
      }
      else {
        //					min.close();
      }

    }
    else {
      <<<"Cannot open", device>>>; 	
      break;
    }

  }

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

0 => int synced;

// infinite time-loop
while( synced == 0 )
{
    // wait on the event 'min'
    min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
        // print out midi message
        <<< msg.data1, msg.data2, msg.data3 >>>;

        if (  msg.data1 == 148 && msg.data2 == 127 && msg.data3 == 127 ){
             MASTER_SEQ3.update_ref_times(now, data.tick * 4);

             1 => synced;
             <<<"PARALLEL SYNC message received, SYNCED, exit script">>>;

        }
    }
}

1::ms => now;
class string_dummy
{
    string my_string;
}

public class ROOTPATH {
  static  string_dummy @ str;
}

new string_dummy @=> ROOTPATH.str;


// CHANGE PATH HERE
"../../" =>  ROOTPATH.str.my_string;


while(1) 1000::ms => now;

Machine.add("../include/include.ck");
me.yield();

1::ms => now;

if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

Machine.add("_save_replace_down.ck:" + me.arg(0) );

while (1) 1000::ms=>now;

if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

me.arg(0) => string file_name;

Machine.add( file_name) => int shred_id;

fun void kb_management (Hid hi)
    {
        HidMsg msg; 
        int num;
        // infinite event loop
        while( true )
        {
            // wait on event
            hi => now;
        
            // get one or more messages
            while( hi.recv( msg ) )
            {
                //<<<"note_active 1",note_active>>>;
                // check for action type
                if( msg.isButtonDown() )
                {
                     //<<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                    if(msg.which == 31 ){
												// Tempo to save file
												200::ms => now;
                        Machine.remove(shred_id);
                        Machine.add( file_name)=> shred_id;
                    
                    }

                }
            }
        }
    }
    
    
    
        //--------------------------------------------//
        //               kb Init                      //
        //--------------------------------------------//
        Hid hi;

        // open keyboard 0
        if( !hi.openKeyboard( 0 ) ) me.exit();
        <<< "keyboard '" + hi.name() + "' ready", "" >>>;

        spork ~ kb_management(hi);

        
while(1) 10::second => now;
Machine.add("rootpath.ck");
me.yield();

// CHANGE ALSO ROOT PATH HERE
Machine.add("../../include/include.ck");
me.yield();

Machine.add( "launch.ck" );
//<<<data.bpm>>>;
//Machine.add( "test.ck" );
//Machine.add( "super_seq_top.ck" );

1::ms => now;
Machine.add("parallel_sync_receive.ck");

while (1) 100000::ms=>now;
<<<"sup",now/1::second>>>;
0 => int i;
seq_script s[12];

// s0.ck vap_loop
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0.  << 0. ;
i++;


for (0 => int j; j < i; j++) {
   data.bpm/data.meas_size => s[j].bpm;
	 0=>s[j].sync_on;
   s[j].go();
}


2 * data.meas_size * data.tick => now;

//<<<"sup2",now/1::second>>>;
data.super_seq_reset_ev.broadcast();
// Wait to allow all includes to launch
data.wait_before_start => now;

while (1) {

	Machine.add("super_seq.ck");

	data.super_seq_reset_ev => now;

}
Machine.status();

1::ms => now;
            MASTER_SEQ3.update_ref_times(now, data.tick * 4);

            10::ms => now;

LONG_WAV l;
"../../_SAMPLES/stayOm/pads0.wav" => l.read;
1.4 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(10::ms, 4000::ms);
l.start(16 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 7 * 10. /* room size */, 4::second /* rev time */, 0.3 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
      .3 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //
20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" }c
*2
____ ____ 63#4 1___ 
____ ____ ____ ____
____ ____ ___1/8 ____
____ ____ 5830 1___

____ ____ 5#45#4 1___ 
____ ____ ____ ____
____ ____ 8//1_#4 ____
____ __8_ 3__3 1___

" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

// DETUNE detune;
// detune.base_synt(s0 /* base synt, controlling others */);
// detune.reg_aux(synt0 aux1); /* declare and register aux here */
// detune.config_aux(1.01 /* detune percentage */, .6 /* aux gain output */ );  
// detune.reg_aux(synt0 aux2); /* declare and register aux here */
// detune.config_aux(0.994 /* detune percentage */, .6 /* aux gain output */ );  

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STDELAY stdelay;
stdelay.connect(last $ ST , data.tick * 2. / 4. /* static delay */ );       stdelay $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STAUTOPAN autopan2;
autopan2.connect(t $ ST, .3 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(autopan $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
TONE t;
0 => int n;
1 => int k;

t.reg(SERUM0 s0); s0.config(n, k);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM0 s1); s1.config(n, k);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM0 s2); s2.config(n, k);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c }c _A|1|3_A|1|3 _A|1|3_A|1|3   _1|3|5_1|3|5 _1|3|5_1|3|5" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 4 * 10::ms, .00002, 400::ms);
t.adsr[0].setCurves(1.0, 2.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2::ms, 4 * 10::ms, .00002, 400::ms);
t.adsr[1].setCurves(1.0, 2.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[2].set(2::ms, 4 * 10::ms, .00002, 400::ms);
t.adsr[2].setCurves(1.0, 2.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STDELAY stdelay;
stdelay.connect(last $ ST , data.tick * 1. / 4. /* static delay */ );       stdelay $ ST @=>  last;  

STGAIN stgain0;
stgain0.connect(last $ ST , 0.5 /* static gain */  );       stgain0 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(t $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 1200 /* f_base */ , 4800  /* f_var */, 1::second / (16 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 8 * 10. /* room size */, 2::second /* rev time */, 0.1 /* early */ , 0.4 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      3 * .01 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
*4
{c
A_A_ A___ 8_8_ __A/6_
}c
A__A __1_ 3_1_ #4_#4_
{c
1_1_ 1_1_ 5__5 __5_
}c
1__1 __0_ 2_0_ 333_

" => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  6::ms /* dur base */, 2::ms /* dur range */, .2 /* freq */); 

//STSYNCLPF2 stsynclpf;
//stsynclpf.freq(100 /* Base */, 12 * 100 /* Variable */, 3. /* Q */);
//stsynclpf.adsr_set(.05 /* Relative Attack */, .6/* Relative Decay */, .00001 /* Sustain */, .0 /* Relative Sustain dur */, 0.4 /* Relative release */); 
//stsynclpf.nio.padsr.setCurves(2.0, 0.9, .5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

//stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 



STSYNCBPF stsyncbpf;
stsyncbpf.freq(16*10 /* Base */, 12 * 100 /* Variable */, 2. /* Q */);
stsyncbpf.adsr_set(.05 /* Relative Attack */,  .6/* Relative Decay */, .00001 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsyncbpf.nio.padsr.setCurves(2.0, 0.9, .5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsyncbpf.connect(last $ ST, t.note_info_tx_o); stsyncbpf $ ST @=>  last;  



STFILTERMOD fmod;
fmod.connect( last , "HPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 60 * 10 /* f_base */ , 12 * 100  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 
//
//STAUTOPAN autopan;
//autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 12 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

//STLHPFC lhpfc;
//lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
LONG_WAV l;
"../../_SAMPLES/stayOm/saz_loop.wav" => l.read;
0.58 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(16 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 16 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STEQ steq;
steq.static_connect(last $ ST,  152.010417  /* HPF freq */,  1.000000  /* HPF Q */,  7811.369083  /* LPF freq */,  8.375000  /* LPF Q */
      ,  10071.747364  /* BRF1 freq */,  1.000000  /* BRF1 Q */,  279.000000  /* BRF2 freq */,  4.000000  /* BRF2 Q */
      ,  2489.015870  /* BPF1 freq */,  5.000000  /* BPF1 Q */,  1.937500  /* BPF1 Gain */
      ,  0.000000  /* BPF2 freq */,  1.000000  /* BPF2 Q */,  0.000000   /* BPF2 Gain */
      ,  1.000000  /* Output Gain */ ); steq $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.1 /* early */ , 0.3 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
LONG_WAV l;
"../../_SAMPLES/stayOm/accap/loop long.wav" => l.read;
0.3 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}
 
LONG_WAV l;
"../../_SAMPLES/stayOm/accap/loop short.wav" => l.read;
0.35 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}
 
LONG_WAV l;
"../../_SAMPLES/stayOm/accap/voix trigger.wav" => l.read;
0.35 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}
 
// RYTHM
158 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// MIX
1. => data.master_gain;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
48 => data.ref_note;

// Start synchro
//HW.launchpad.virtual_key_on(7);

// LED STRIP
//HW.ledstrip.open();
//HW.ledstrip._load_preset('0');

//1::ms => now;

     
 digit dig;

Gain dac_temp => Pan2 P;

P.left => Gain gain_left => dac.left;
P.right => Gain gain_right => dac.right;
gain_right.gain(1);
 
// DUCKING
Gain ducking;
ADSR duck;
4::ms => dur duck_attack;
120::ms => dur duck_release;
duck.set (duck_release, 0::ms, 1, duck_attack);
duck.keyOn();

ducking => Gain remaining => dac_temp;
remaining.gain (0.1);

// SAMPLER

1=> int last_sampler_group;


class nano_sampler extends Chubgraph {
    9 => int nb_sp;
    sampler sp[nb_sp];
    ADSR    a[nb_sp];
    dur length;

   1 =>  int bypass_connected;

   inlet => Gain in => Gain bypass => outlet;
    for (0=>int i; i< nb_sp; i++){
     in => sp[i].connect => a[i] => outlet;
    a[i].keyOn();
       a[i].set(3::ms, 0::ms, 1, 3::ms);
    }   

    fun void set_dur (dur in) {
            in => length;
        for (0=>int i; i< nb_sp; i++){
        in => sp[i].max;
        in => sp[i].length;
        }
    }

    fun void on(int group, int on){
    if (on == 0) a[group -1].keyOff();
    else a[group -1].keyOn();
   }

   fun void add (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
   
        sp[group - 1].add();

        // Disconnet bypass while sampling
        in =< bypass;
				0=> bypass_connected;


   }
 
   fun void close (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
       
        // reconnect bypass when smapling is over
		if (!bypass_connected){
	        in => bypass;
				1=> bypass_connected;
    }

   }

   fun void remove_last (int group) {
           sp[group - 1].remove_last ();
   }
}


// EFFECT PATH 
 
Gain dig_in => disto dist => dig.connect => Gain tampon_phaser => PRCRev rev1 => PRCRev rev2 => Gain tampon => Gain tampon_in => Gain tampon_out => Gain tampon_bpf => LPF filt=> Gain out_effect => nano_sampler sp =>  ducking => duck =>  dac_temp;

sp.set_dur(16 * data.tick);


Std.mtof(127)=> filt.freq;

// ECHO GENERAL
tampon_out => Delay feed_back => tampon_out;
feed_back.gain(0);
15::second => feed_back.max;
data.tick => feed_back.delay ;

// REVERB
0 => rev1.mix => rev2.mix;


// ECHO SNARE
/* Gain input_snare => Gain tampon_snare => dig_in;
tampon_snare => Delay feed_back_snare => tampon_snare ;
feed_back_snare.gain(0);
3::second => feed_back_snare.max;
rythm_o.tick_delay => feed_back_snare.delay ;
*/


// BPF
tampon_out => BPF bpf_0 => out_effect;
bpf_0.Q (1);
bpf_0.freq (400);
bpf_0.gain (0);

tampon_out => BPF bpf_1 => out_effect;
bpf_1.Q (4);
bpf_1.freq (400);
bpf_1.gain (0);

tampon_out => BPF bpf_2 => out_effect;
bpf_2.Q (6);
bpf_2.freq (400);
bpf_2.gain (0);


fun void duck_run () {
    // sync
    // 2*rythm_o.tick_delay - (now % (2*rythm_o.tick_delay)) => now;

    while(1) {
    
        global_mixer.duck_trig => now;
        duck.keyOff();
        duck_attack => now;
        duck.keyOn();
    
        // duck_attack => now;
        // duck.keyOn();
        // 2*rythm_o.tick_delay - duck_attack => now;
        // duck.keyOff();
    }
    
}

spork ~  duck_run ();

// INIT inputs to dac_temp
global_mixer.line1 => dac_temp; // DIRECT NO EFFECT
global_mixer.line2 => dac_temp; // DIRECT NO EFFECT
global_mixer.line3 => ducking; // 
global_mixer.line4 => ducking; // 
global_mixer.line5 => ducking; // 
global_mixer.line6 => ducking; // 
// Stereo
global_mixer.stereo1 => gain_left;
global_mixer.stereo2 => gain_right;


 
/*********************************************
                NANO
*********************************************/
class nanomidi_ext extends nanomidi{
   
   fun void potar_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;
	 if (bank == 1 && group == 1) {
		Std.mtof(val)   => filt.freq;          
          
           }
        if (bank == 1 && group == 2) {
           
               if (val == 0) 1::samp => dig.ech;
               else {
                    (1./Std.mtof(127-val))::second => dig.ech;
               }
           
           }
      if (bank == 1 && group == 3) {
          (val + 1) * data.tick /8.  => feed_back.delay ;
          
           }

  	// REV
         if (bank == 1 && group == 4) {
	 
	 	val $ float / 256. => rev2.mix;
	 
//          	(val/4 + 1) * rythm_o.tick_delay / 2 => feed_back_snare.delay ;
	}

	// SAMPLER DUR
         if (bank == 1 && group == 5) {
		Math.pow (2, (val/16)) $ int => int nb_tick;
		sp.set_dur(nb_tick * data.tick);
		<<<"sampler dur =", 	nb_tick	, "* rythm_o.tick_delay">>>;
	}



	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain_in;          
          
           }
	// BPF
	 if (bank == 1 && group == 7) {
		Std.mtof(val)   => bpf_0.freq;          
          
           }
	 if (bank == 1 && group == 8) {
		Std.mtof(val)   => bpf_1.freq;          
          
           }
	 if (bank == 1 && group == 9) {
		Std.mtof(val)   => bpf_2.freq;          
          
           }

       
   }

   fun void fader_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;

if (bank == 1 ) {
        if (group == 1) {
          	(val $ float)/127   => out_effect.gain;
           }
        else if (group == 2) {
            (val $ float) / 1270. => dig.quant;
        }
        else  if (group == 3) {
            (val $ float) / 127. => feed_back.gain;
        }
	// REVERB
        else  if ( group == 4) {
	 	val $ float / 256. => rev1.mix;
//            (val $ float) / 127. => feed_back_snare.gain;
        }

        else  if (group ==5) {
        }
	

	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain;          
          
           }

	// BPF
        else  if (group == 7) {
            (val $ float) * 4 / 127. => bpf_0.gain;
        }
        else  if (group == 8) {
            (val $ float) * 4 / 127. => bpf_1.gain;
        }
        else  if (group == 9) {
            (val $ float) * 10 / 127. => bpf_2.gain;
		
        }
   }
   else if (bank == 2 ) {
	(val $ float)/127. * 4 => sp.a[group - 1].gain;

   }


   }
     

    fun void button_down_ext (int bank, int group, int val) {
        <<<"button down ", bank, group," : ",val>>>;
	if (bank == 1 && group == 1){
            // if (val != 0) {
                // global_mixer.line1 =< dac_temp; 
                // global_mixer.line1 => dig_in;  
            // }
            // else {
                // global_mixer.line1 =< dig_in; 
                // global_mixer.line1 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 2){
            // if (val != 0) {
                // global_mixer.line2 =< dac_temp; 
                // global_mixer.line2 => dig_in;  
            // }
            // else {
                // global_mixer.line2 =< dig_in; 
                // global_mixer.line2 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 3){
            if (val != 0) {
                global_mixer.line3 =< ducking; 
                global_mixer.line3 => dig_in;  
            }
            else {
                global_mixer.line3 =< dig_in; 
                global_mixer.line3 => ducking;  
            }
        }
        else if (bank == 1 && group == 4){
            if (val != 0) {
                global_mixer.line4 =< ducking; 
                global_mixer.line4 => dig_in;  
            }
            else {
                global_mixer.line4 =< dig_in; 
                global_mixer.line4 => ducking;  
            }
        }
        else if (bank == 1 && group == 5){
            if (val != 0) {
                global_mixer.line5 =< ducking; 
                global_mixer.line5 => dig_in;  
            }
            else {
                global_mixer.line5 =< dig_in; 
                global_mixer.line5 => ducking;  
            }
        }
        else if (bank == 1 && group == 6){
            if (val != 0) {
                global_mixer.line6 =< ducking; 
                global_mixer.line6 => dig_in;  
            }
            else {
                global_mixer.line6 =< dig_in; 
                global_mixer.line6 => ducking;  
            }
        }
        else if (bank == 2 ){
		sp.on(group, val);
	}
	

    }

// AUTO ECHO
0=> int echo_on_flag;

fun void echo_on (dur duration){
	//tampon_out => Delay feed_back => tampon_out;
	//feed_back.gain(0);
	
	feed_back.delay (1::ms);
	feed_back.gain(0);
	1::ms => now;

	1=> echo_on_flag;

	3 * data.tick => feed_back.delay ;
	feed_back.gain(.8);

	duration => now;

	if (echo_on_flag){
		feed_back.gain(1);
		tampon_in.gain(0);
	}
}

fun void echo_off (){

	0=> echo_on_flag;
	feed_back.gain(0);
	tampon_in.gain(1);
}


    fun void button_up_ext (int bank, int group, int val) {
/*       if (bank == 1 && group == 3){
            if (val != 0) {
                spork ~ echo_on(3::second);  
            }
	    else {
                spork ~ echo_off();  
            }
	}*/

        <<<"button up ", bank, group," : ",val>>>;
	if (bank == 1 || bank == 2){
	    if (val == 0) {
		sp.close (group);
	    }
	    else {
		 sp.add (group);
		// close last group to avoid simultaneous multi sampling
/*		if (last_sampler_group != 0 && last_sampler_group != group) {
		    <<< "FORCED CLOSE", last_sampler_group, group >>>;
		    sp.close (last_sampler_group);
		}
*/

		    group => last_sampler_group;


	    }
        }





    }     
    
    fun void button_rec_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
        	<<<"Add new buffer on sampler: ",last_sampler_group>>>;
	        sp.add (last_sampler_group);
        }
    }

    fun void button_loop_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
	      <<<"remove last buffer  on sampler: ",last_sampler_group>>>;
		sp.remove_last(last_sampler_group);
        } 
     }

// SAMPLE one meas

fun void stop_sample_meas (int g){
    sp.sp[0].length => now;       
        sp.close (g);
}


    fun void button_forward_ext (int val) {
         if (val != 0 && last_sampler_group!=0) {
                    <<<"Sample one meas on sampler: ", last_sampler_group>>>;
                sp.add (last_sampler_group);
                    spork ~ stop_sample_meas(last_sampler_group );
             }
            }

// STOP sampling

    fun void button_stop_ext (int val) {
			<<<"TOTO">>>;
            if (val != 0 && last_sampler_group!=0) {
                 <<<"Stop sampling on sampler:", last_sampler_group>>>;
                 sp.close (last_sampler_group);
             }           
        }

}


nanomidi_ext nano;
nano.start_midi_rcv();
<<<"Effects">>>;


launcher laun;

laun.load_file("files_launch.txt");

while(1) 100000::ms=> now;
32 =>  data.page_manager_page_nb;
1::samp =>  now;
  "Midi Through Port-0" => string device;

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;

  // open the device
  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    min.printerr( 0 );

    // open the device
    if( min.open( i ) )
    {
      if ( min.name() == device )  {

        <<< "device", i, "->", min.name(), "->", "open as input: SUCCESS" >>>;

        break;
      }
      else {
        //					min.close();
      }

    }
    else {
      <<<"Cannot open", device>>>; 	
      break;
    }

  }

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

0 => int synced;

// infinite time-loop
while( synced == 0 )
{
    // wait on the event 'min'
    min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
        // print out midi message
        <<< msg.data1, msg.data2, msg.data3 >>>;

        if (  msg.data1 == 148 && msg.data2 == 127 && msg.data3 == 127 ){
             MASTER_SEQ3.update_ref_times(now, data.tick * 4);

             1 => synced;
             <<<"PARALLEL SYNC message received, SYNCED, exit script">>>;

        }
    }
}

1::ms => now;
class string_dummy
{
    string my_string;
}

public class ROOTPATH {
  static  string_dummy @ str;
}

new string_dummy @=> ROOTPATH.str;


// CHANGE PATH HERE
"../../" =>  ROOTPATH.str.my_string;


while(1) 1000::ms => now;

Machine.add("../include/include.ck");
me.yield();

1::ms => now;

if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

Machine.add("_save_replace_down.ck:" + me.arg(0) );

while (1) 1000::ms=>now;

if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

me.arg(0) => string file_name;

Machine.add( file_name) => int shred_id;

fun void kb_management (Hid hi)
    {
        HidMsg msg; 
        int num;
        // infinite event loop
        while( true )
        {
            // wait on event
            hi => now;
        
            // get one or more messages
            while( hi.recv( msg ) )
            {
                //<<<"note_active 1",note_active>>>;
                // check for action type
                if( msg.isButtonDown() )
                {
                     //<<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                    if(msg.which == 31 ){
												// Tempo to save file
												200::ms => now;
                        Machine.remove(shred_id);
                        Machine.add( file_name)=> shred_id;
                    
                    }

                }
            }
        }
    }
    
    
    
        //--------------------------------------------//
        //               kb Init                      //
        //--------------------------------------------//
        Hid hi;

        // open keyboard 0
        if( !hi.openKeyboard( 0 ) ) me.exit();
        <<< "keyboard '" + hi.name() + "' ready", "" >>>;

        spork ~ kb_management(hi);

        
while(1) 10::second => now;
Machine.add("rootpath.ck");
me.yield();

// CHANGE ALSO ROOT PATH HERE
Machine.add("../../include/include.ck");
me.yield();

Machine.add( "launch.ck" );
//<<<data.bpm>>>;
//Machine.add( "test.ck" );
//Machine.add( "super_seq_top.ck" );

1::ms => now;
Machine.add("parallel_sync_receive.ck");

while (1) 100000::ms=>now;
<<<"sup",now/1::second>>>;
0 => int i;
seq_script s[12];

// s0.ck vap_loop
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0.  << 0. ;
i++;


for (0 => int j; j < i; j++) {
   data.bpm/data.meas_size => s[j].bpm;
	 0=>s[j].sync_on;
   s[j].go();
}


2 * data.meas_size * data.tick => now;

//<<<"sup2",now/1::second>>>;
data.super_seq_reset_ev.broadcast();
// Wait to allow all includes to launch
data.wait_before_start => now;

while (1) {

	Machine.add("super_seq.ck");

	data.super_seq_reset_ev => now;

}
Machine.status();

1::ms => now;
            MASTER_SEQ3.update_ref_times(now, data.tick * 4);

            10::ms => now;

class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
SERUM0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

49 =>int  nb;
0 => int rk;

inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -4.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  4.51 => det_amount[i].next;      .1 => s[i].gain; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt1 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
SERUM0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

48 =>int  nb;
0 => int rk;

inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -4.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  4.51 => det_amount[i].next;      .1 => s[i].gain; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt3 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t[3];
0 => int id;
ST @ last;


t[id].reg(synt0 s0);  
t[id].reg(synt0 s1); .8 => s1.outlet.gain; 
t[id].reg(synt0 s2); .7 => s1.outlet.gain; 
t[id].reg(synt0 s3); .6 => s1.outlet.gain;  
t[id].reg(synt0 s4); .5 => s1.outlet.gain;  
//data.tick * 8 => t[id].max; //60::ms => t[id].glide;  // t[id].lyd(); // t[id].ion(); // t[id].mix();//
t[id].dor();// t[id].aeo(); // t[id].phr();// t[id].loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c:2
A|1|3___ ____ ____ 1|3|5___ 
" => t[id].seq;
1.4 * data.master_gain => t[id].gain;
//t[id].sync(4*data.tick);// t[id].element_sync();//  t[id].no_sync();//  t[id].full_sync(); // 
1 * data.tick => t[id].the_end.fixed_end_dur;  // 16 * data.tick => t[id].extra_end;   //t[id].print(); //t[id].force_off_action();
// t[id].mono() => dac;//  t[id].left() => dac.left; // t[id].right() => dac.right; // t[id].raw => dac;
t[id].adsr[0].set(2000::ms, 1000::ms, .8, 6 * data.tick );
t[id].adsr[0].setCurves(1.0, 1.0, 1.0); //6 * data.tick  > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[1].set(2000::ms, 1000::ms, .8, 6 * data.tick );
t[id].adsr[1].setCurves(1.0, 1.0, 1.0); //6 * data.tick  > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[2].set(2000::ms, 1000::ms, .8, 6 * data.tick );
t[id].adsr[2].setCurves(1.0, 1.0, 1.0); //6 * data.tick  > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[3].set(2000::ms, 1000::ms, .8, 6 * data.tick );
t[id].adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].go();   t[id] $ ST @=>  last; 
.8 => t[id].outl.gain;
1. => t[id].outr.gain;
1 +=> id; 

STSYNCLPF2 stsynclpf2;
stsynclpf2.freq(40 *10 /* Base */, 70 * 100 /* Variable */, 2.0 /* Q */);
stsynclpf2.adsr_set(.3 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf2.connect(last $ ST, t[0].note_info_tx_o); stsynclpf2 $ ST @=>  last; 


t[id].reg(synt1 S0);  
t[id].reg(synt1 S1); .8 => s1.outlet.gain; 
t[id].reg(synt1 S2); .7 => s1.outlet.gain; 
t[id].reg(synt1 S3); .6 => s1.outlet.gain;  
//data.tick * 8 => t[id].max; //60::ms => t[id].glide;  // t[id].lyd(); // t[id].ion(); // t[id].mix();//
t[id].dor();// t[id].aeo(); // t[id].phr();// t[id].loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c:2
 ____ 1|3|7___ A|1|3|#4___ ____ 
 
 " => t[id].seq;
1.8 * data.master_gain => t[id].gain;
//t[id].sync(4*data.tick);// t[id].element_sync();//  t[id].no_sync();//  t[id].full_sync(); // 
1 * data.tick => t[id].the_end.fixed_end_dur;  // 16 * data.tick => t[id].extra_end;   //t[id].print(); //t[id].force_off_action();
// t[id].mono() => dac;//  t[id].left() => dac.left; // t[id].right() => dac.right; // t[id].raw => dac;
t[id].adsr[0].set(2000::ms, 1000::ms, .8, 4 * data.tick);
t[id].adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[1].set(2000::ms, 1000::ms, .8, 4 * data.tick);
t[id].adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[2].set(2000::ms, 1000::ms, .8, 4 * data.tick);
t[id].adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[3].set(2000::ms, 1000::ms, .8, 4 * data.tick);
t[id].adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].go();   t[id] $ ST @=>  last; 
1 => t[id].outl.gain;
0.8 => t[id].outr.gain;

1 +=> id; 

STSYNCLPF2 stsynclpf22;
stsynclpf22.freq(40 *10 /* Base */, 70 * 100 /* Variable */, 2.0 /* Q */);
stsynclpf22.adsr_set(.3 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf22.connect(last $ ST, t[1].note_info_tx_o); stsynclpf22 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stsynclpf2 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STREC strec;
strec.connect(last $ ST, 32*data.tick, "../../_SAMPLES/stayOm/pads0.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); strec $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 




// RYTHM
158 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// MIX
1. => data.master_gain;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
48 => data.ref_note;

// Start synchro
//HW.launchpad.virtual_key_on(7);

// LED STRIP
//HW.ledstrip.open();
//HW.ledstrip._load_preset('0');

//1::ms => now;

     
 digit dig;

Gain dac_temp => Pan2 P;

P.left => Gain gain_left => dac.left;
P.right => Gain gain_right => dac.right;
gain_right.gain(1);
 
// DUCKING
Gain ducking;
ADSR duck;
4::ms => dur duck_attack;
120::ms => dur duck_release;
duck.set (duck_release, 0::ms, 1, duck_attack);
duck.keyOn();

ducking => Gain remaining => dac_temp;
remaining.gain (0.1);

// SAMPLER

1=> int last_sampler_group;


class nano_sampler extends Chubgraph {
    9 => int nb_sp;
    sampler sp[nb_sp];
    ADSR    a[nb_sp];
    dur length;

   1 =>  int bypass_connected;

   inlet => Gain in => Gain bypass => outlet;
    for (0=>int i; i< nb_sp; i++){
     in => sp[i].connect => a[i] => outlet;
    a[i].keyOn();
       a[i].set(3::ms, 0::ms, 1, 3::ms);
    }   

    fun void set_dur (dur in) {
            in => length;
        for (0=>int i; i< nb_sp; i++){
        in => sp[i].max;
        in => sp[i].length;
        }
    }

    fun void on(int group, int on){
    if (on == 0) a[group -1].keyOff();
    else a[group -1].keyOn();
   }

   fun void add (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
   
        sp[group - 1].add();

        // Disconnet bypass while sampling
        in =< bypass;
				0=> bypass_connected;


   }
 
   fun void close (int group) {
    if (sp[group - 1].array.size() != 0)
           sp[group - 1].array[sp[group - 1].array.size()-1].close_in ();
       
        // reconnect bypass when smapling is over
		if (!bypass_connected){
	        in => bypass;
				1=> bypass_connected;
    }

   }

   fun void remove_last (int group) {
           sp[group - 1].remove_last ();
   }
}


// EFFECT PATH 
 
Gain dig_in => disto dist => dig.connect => Gain tampon_phaser => PRCRev rev1 => PRCRev rev2 => Gain tampon => Gain tampon_in => Gain tampon_out => Gain tampon_bpf => LPF filt=> Gain out_effect => nano_sampler sp =>  ducking => duck =>  dac_temp;

sp.set_dur(16 * data.tick);


Std.mtof(127)=> filt.freq;

// ECHO GENERAL
tampon_out => Delay feed_back => tampon_out;
feed_back.gain(0);
15::second => feed_back.max;
data.tick => feed_back.delay ;

// REVERB
0 => rev1.mix => rev2.mix;


// ECHO SNARE
/* Gain input_snare => Gain tampon_snare => dig_in;
tampon_snare => Delay feed_back_snare => tampon_snare ;
feed_back_snare.gain(0);
3::second => feed_back_snare.max;
rythm_o.tick_delay => feed_back_snare.delay ;
*/


// BPF
tampon_out => BPF bpf_0 => out_effect;
bpf_0.Q (1);
bpf_0.freq (400);
bpf_0.gain (0);

tampon_out => BPF bpf_1 => out_effect;
bpf_1.Q (4);
bpf_1.freq (400);
bpf_1.gain (0);

tampon_out => BPF bpf_2 => out_effect;
bpf_2.Q (6);
bpf_2.freq (400);
bpf_2.gain (0);


fun void duck_run () {
    // sync
    // 2*rythm_o.tick_delay - (now % (2*rythm_o.tick_delay)) => now;

    while(1) {
    
        global_mixer.duck_trig => now;
        duck.keyOff();
        duck_attack => now;
        duck.keyOn();
    
        // duck_attack => now;
        // duck.keyOn();
        // 2*rythm_o.tick_delay - duck_attack => now;
        // duck.keyOff();
    }
    
}

spork ~  duck_run ();

// INIT inputs to dac_temp
global_mixer.line1 => dac_temp; // DIRECT NO EFFECT
global_mixer.line2 => dac_temp; // DIRECT NO EFFECT
global_mixer.line3 => ducking; // 
global_mixer.line4 => ducking; // 
global_mixer.line5 => ducking; // 
global_mixer.line6 => ducking; // 
// Stereo
global_mixer.stereo1 => gain_left;
global_mixer.stereo2 => gain_right;


 
/*********************************************
                NANO
*********************************************/
class nanomidi_ext extends nanomidi{
   
   fun void potar_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;
	 if (bank == 1 && group == 1) {
		Std.mtof(val)   => filt.freq;          
          
           }
        if (bank == 1 && group == 2) {
           
               if (val == 0) 1::samp => dig.ech;
               else {
                    (1./Std.mtof(127-val))::second => dig.ech;
               }
           
           }
      if (bank == 1 && group == 3) {
          (val + 1) * data.tick /8.  => feed_back.delay ;
          
           }

  	// REV
         if (bank == 1 && group == 4) {
	 
	 	val $ float / 256. => rev2.mix;
	 
//          	(val/4 + 1) * rythm_o.tick_delay / 2 => feed_back_snare.delay ;
	}

	// SAMPLER DUR
         if (bank == 1 && group == 5) {
		Math.pow (2, (val/16)) $ int => int nb_tick;
		sp.set_dur(nb_tick * data.tick);
		<<<"sampler dur =", 	nb_tick	, "* rythm_o.tick_delay">>>;
	}



	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain_in;          
          
           }
	// BPF
	 if (bank == 1 && group == 7) {
		Std.mtof(val)   => bpf_0.freq;          
          
           }
	 if (bank == 1 && group == 8) {
		Std.mtof(val)   => bpf_1.freq;          
          
           }
	 if (bank == 1 && group == 9) {
		Std.mtof(val)   => bpf_2.freq;          
          
           }

       
   }

   fun void fader_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;

if (bank == 1 ) {
        if (group == 1) {
          	(val $ float)/127   => out_effect.gain;
           }
        else if (group == 2) {
            (val $ float) / 1270. => dig.quant;
        }
        else  if (group == 3) {
            (val $ float) / 127. => feed_back.gain;
        }
	// REVERB
        else  if ( group == 4) {
	 	val $ float / 256. => rev1.mix;
//            (val $ float) / 127. => feed_back_snare.gain;
        }

        else  if (group ==5) {
        }
	

	// DISTO
	 if (bank == 1 && group == 6) {
		(val $ float) / 32.    => dist.gain;          
          
           }

	// BPF
        else  if (group == 7) {
            (val $ float) * 4 / 127. => bpf_0.gain;
        }
        else  if (group == 8) {
            (val $ float) * 4 / 127. => bpf_1.gain;
        }
        else  if (group == 9) {
            (val $ float) * 10 / 127. => bpf_2.gain;
		
        }
   }
   else if (bank == 2 ) {
	(val $ float)/127. * 4 => sp.a[group - 1].gain;

   }


   }
     

    fun void button_down_ext (int bank, int group, int val) {
        <<<"button down ", bank, group," : ",val>>>;
	if (bank == 1 && group == 1){
            // if (val != 0) {
                // global_mixer.line1 =< dac_temp; 
                // global_mixer.line1 => dig_in;  
            // }
            // else {
                // global_mixer.line1 =< dig_in; 
                // global_mixer.line1 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 2){
            // if (val != 0) {
                // global_mixer.line2 =< dac_temp; 
                // global_mixer.line2 => dig_in;  
            // }
            // else {
                // global_mixer.line2 =< dig_in; 
                // global_mixer.line2 => dac_temp;  
            // }
        }
        else if (bank == 1 && group == 3){
            if (val != 0) {
                global_mixer.line3 =< ducking; 
                global_mixer.line3 => dig_in;  
            }
            else {
                global_mixer.line3 =< dig_in; 
                global_mixer.line3 => ducking;  
            }
        }
        else if (bank == 1 && group == 4){
            if (val != 0) {
                global_mixer.line4 =< ducking; 
                global_mixer.line4 => dig_in;  
            }
            else {
                global_mixer.line4 =< dig_in; 
                global_mixer.line4 => ducking;  
            }
        }
        else if (bank == 1 && group == 5){
            if (val != 0) {
                global_mixer.line5 =< ducking; 
                global_mixer.line5 => dig_in;  
            }
            else {
                global_mixer.line5 =< dig_in; 
                global_mixer.line5 => ducking;  
            }
        }
        else if (bank == 1 && group == 6){
            if (val != 0) {
                global_mixer.line6 =< ducking; 
                global_mixer.line6 => dig_in;  
            }
            else {
                global_mixer.line6 =< dig_in; 
                global_mixer.line6 => ducking;  
            }
        }
        else if (bank == 2 ){
		sp.on(group, val);
	}
	

    }

// AUTO ECHO
0=> int echo_on_flag;

fun void echo_on (dur duration){
	//tampon_out => Delay feed_back => tampon_out;
	//feed_back.gain(0);
	
	feed_back.delay (1::ms);
	feed_back.gain(0);
	1::ms => now;

	1=> echo_on_flag;

	3 * data.tick => feed_back.delay ;
	feed_back.gain(.8);

	duration => now;

	if (echo_on_flag){
		feed_back.gain(1);
		tampon_in.gain(0);
	}
}

fun void echo_off (){

	0=> echo_on_flag;
	feed_back.gain(0);
	tampon_in.gain(1);
}


    fun void button_up_ext (int bank, int group, int val) {
/*       if (bank == 1 && group == 3){
            if (val != 0) {
                spork ~ echo_on(3::second);  
            }
	    else {
                spork ~ echo_off();  
            }
	}*/

        <<<"button up ", bank, group," : ",val>>>;
	if (bank == 1 || bank == 2){
	    if (val == 0) {
		sp.close (group);
	    }
	    else {
		 sp.add (group);
		// close last group to avoid simultaneous multi sampling
/*		if (last_sampler_group != 0 && last_sampler_group != group) {
		    <<< "FORCED CLOSE", last_sampler_group, group >>>;
		    sp.close (last_sampler_group);
		}
*/

		    group => last_sampler_group;


	    }
        }





    }     
    
    fun void button_rec_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
        	<<<"Add new buffer on sampler: ",last_sampler_group>>>;
	        sp.add (last_sampler_group);
        }
    }

    fun void button_loop_ext (int val) {
	if (val != 0 && last_sampler_group!=0) {
	      <<<"remove last buffer  on sampler: ",last_sampler_group>>>;
		sp.remove_last(last_sampler_group);
        } 
     }

// SAMPLE one meas

fun void stop_sample_meas (int g){
    sp.sp[0].length => now;       
        sp.close (g);
}


    fun void button_forward_ext (int val) {
         if (val != 0 && last_sampler_group!=0) {
                    <<<"Sample one meas on sampler: ", last_sampler_group>>>;
                sp.add (last_sampler_group);
                    spork ~ stop_sample_meas(last_sampler_group );
             }
            }

// STOP sampling

    fun void button_stop_ext (int val) {
			<<<"TOTO">>>;
            if (val != 0 && last_sampler_group!=0) {
                 <<<"Stop sampling on sampler:", last_sampler_group>>>;
                 sp.close (last_sampler_group);
             }           
        }

}


nanomidi_ext nano;
nano.start_midi_rcv();
<<<"Effects">>>;


launcher laun;

laun.load_file("files_launch.txt");

while(1) 100000::ms=> now;
32 =>  data.page_manager_page_nb;
1::samp =>  now;
  "Midi Through Port-0" => string device;

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;

  // open the device
  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    min.printerr( 0 );

    // open the device
    if( min.open( i ) )
    {
      if ( min.name() == device )  {

        <<< "device", i, "->", min.name(), "->", "open as input: SUCCESS" >>>;

        break;
      }
      else {
        //					min.close();
      }

    }
    else {
      <<<"Cannot open", device>>>; 	
      break;
    }

  }

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

0 => int synced;

// infinite time-loop
while( synced == 0 )
{
    // wait on the event 'min'
    min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
        // print out midi message
        <<< msg.data1, msg.data2, msg.data3 >>>;

        if (  msg.data1 == 148 && msg.data2 == 127 && msg.data3 == 127 ){
             MASTER_SEQ3.update_ref_times(now, data.tick * 4);

             1 => synced;
             <<<"PARALLEL SYNC message received, SYNCED, exit script">>>;

        }
    }
}

1::ms => now;
class string_dummy
{
    string my_string;
}

public class ROOTPATH {
  static  string_dummy @ str;
}

new string_dummy @=> ROOTPATH.str;


// CHANGE PATH HERE
"../../" =>  ROOTPATH.str.my_string;


while(1) 1000::ms => now;

Machine.add("../include/include.ck");
me.yield();

1::ms => now;

if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

Machine.add("_save_replace_down.ck:" + me.arg(0) );

while (1) 1000::ms=>now;

if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

me.arg(0) => string file_name;

Machine.add( file_name) => int shred_id;

fun void kb_management (Hid hi)
    {
        HidMsg msg; 
        int num;
        // infinite event loop
        while( true )
        {
            // wait on event
            hi => now;
        
            // get one or more messages
            while( hi.recv( msg ) )
            {
                //<<<"note_active 1",note_active>>>;
                // check for action type
                if( msg.isButtonDown() )
                {
                     //<<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                    if(msg.which == 31 ){
												// Tempo to save file
												200::ms => now;
                        Machine.remove(shred_id);
                        Machine.add( file_name)=> shred_id;
                    
                    }

                }
            }
        }
    }
    
    
    
        //--------------------------------------------//
        //               kb Init                      //
        //--------------------------------------------//
        Hid hi;

        // open keyboard 0
        if( !hi.openKeyboard( 0 ) ) me.exit();
        <<< "keyboard '" + hi.name() + "' ready", "" >>>;

        spork ~ kb_management(hi);

        
while(1) 10::second => now;
Machine.add("rootpath.ck");
me.yield();

// CHANGE ALSO ROOT PATH HERE
Machine.add("../../include/include.ck");
me.yield();

Machine.add( "launch.ck" );
//<<<data.bpm>>>;
//Machine.add( "test.ck" );
//Machine.add( "super_seq_top.ck" );

1::ms => now;
Machine.add("parallel_sync_receive.ck");

while (1) 100000::ms=>now;
<<<"sup",now/1::second>>>;
0 => int i;
seq_script s[12];

// s0.ck vap_loop
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0.  << 0. ;
i++;


for (0 => int j; j < i; j++) {
   data.bpm/data.meas_size => s[j].bpm;
	 0=>s[j].sync_on;
   s[j].go();
}


2 * data.meas_size * data.tick => now;

//<<<"sup2",now/1::second>>>;
data.super_seq_reset_ev.broadcast();
// Wait to allow all includes to launch
data.wait_before_start => now;

while (1) {

	Machine.add("super_seq.ck");

	data.super_seq_reset_ev => now;

}
Machine.status();

1::ms => now;
            MASTER_SEQ3.update_ref_times(now, data.tick * 4);

            10::ms => now;


REC rec;
rec.rec(4*4*16*data.tick, "../../../../EC/StayOm/loop/saz.wav", 16 * data.tick /* sync_dur, 0 == sync on full dur */); 

while(1) {
	     100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .1 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c G|f///h|H 1|G//G|f h|H/1|G " => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1159/1 1/81/831B14/8  " => arp.t.seq;16 * data.tick =>arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STCUTTER stcutter;
"*4  1_1_ 1111 ____ ____
 1_11 _111 ____ ____
" => stcutter.t.seq; 16 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STHPF hpf;
hpf.connect(last $ ST , 35 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 1400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 



while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .1 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c G|f///h|H 1|G//G|f h|H/1|G " => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1159/1 1/81/831B14/8  " => arp.t.seq;16 * data.tick =>arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STCUTTER stcutter;
"*4  1_1_ 1111 ____ ____
 1_11 _111 ____ ____
" => stcutter.t.seq; 16 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STHPF hpf;
hpf.connect(last $ ST , 35 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 



while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .1 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c G|f///h|H 1|G//G|f h|H/1|G " => t.seq;
.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1159/1 1/81/831B14/8  " => arp.t.seq;16 * data.tick =>arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STCUTTER stcutter;
"*4   ____ 1_1_ 1111 ____
 ____ 1_11 _111 ____
" => stcutter.t.seq; 16 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STHPF hpf;
hpf.connect(last $ ST , 35 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 



while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
      .2 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c G|f///h|H h|H/1|G 1|G//G|f " => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 11531B11/81/81/8  " => arp.t.seq;16 * data.tick =>arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STCUTTER stcutter;
"*4 ____ ____ 1_1_ 1111
____ ____ 1_11 _111
" => stcutter.t.seq; 16 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 1400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 



while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .1 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c G|f///h|H 1|G//G|f h|H/1|G " => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1159/1 1/831B14/8  " => arp.t.seq;16 * data.tick =>arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STCUTTER stcutter;
"*4 ____ ____ 1_1_ 1111
____ ____ 1_11 _111
" => stcutter.t.seq; 16 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 1400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 



while(1) {
       100::ms => now;
}
 
REC rec;
rec.rec(8.7::minute , "/home/toup/EC/StayOm/rec_glitchs/rec2.wav", 4 * data.tick /* sync_dur, 0 == sync on full dur */);
//rec.rec_no_sync(8*data.tick, "test.wav"); 

while(1) {
       100::ms => now;
}

class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .5 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c G|f///h|H 1|G//G|f h|H/1|G " => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1159/1 1/81/831B14/8  " => arp.t.seq;16 * data.tick =>arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STCUTTER stcutter;
"  
____ *8 1___ 1_1_ __1_ 1___   1_1_ __1_ 1_1_ 1_1_  :8 
" => stcutter.t.seq; 16 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STHPF hpf;
hpf.connect(last $ ST , 35 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 



while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .5 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" G|f///h|H  h|H/1|G 1|G//G|f" => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1159/1 1/81/831B14/8  " => arp.t.seq;16 * data.tick =>arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STCUTTER stcutter;
"  
*8 1___ 1_1_ 1_1_ __1_ 1_1_ 1_1_ __1_ 1___     :8 ____ 
" => stcutter.t.seq; 16 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STHPF hpf;
hpf.connect(last $ ST , 35 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 



while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c{c  G/ff//G " => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 8 /* Q */, 260 /* f_base */ , 4400  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERMOD fmod2;
fmod2.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (5 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 


STLHPFC2 lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][3] /* freq */  , HW.lpd8.potar[1][4] /* Q */  );       lhpfc $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 300 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

//STCOMPRESSOR stcomp;
//7. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 30::ms /* releaseTime */);   stcomp $ ST @=>  last;   

STLIMITER stlimiter;
4. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl  + 0.10/* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

<<<"~~~~~~~~~FROGGY FILTER~~~~~~~~~~">>>;
<<<"~~~  LPF freq  lpd8 1.3   ~~~~~~">>>;
<<<"~~~  LPF  Q    lpd8 1.4   ~~~~~~">>>;
<<<"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~">>>;

STGAIN stgain;
stgain.connect(last $ ST , 0.6 /* static gain */  );       stgain $ ST @=>  last; 



while(1) {
       100::ms => now;
}
 
class synt0 extends SYNT{

      8 => int synt_nb; 0 => int i;
      Gain detune[synt_nb];
      Step det_amount[synt_nb];
      SqrOsc s[synt_nb];
      Gain final => outlet; .8 => final.gain;

      inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c  G/ff//G " => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 8 /* Q */, 260 /* f_base */ , 4400  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERMOD fmod2;
fmod2.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (5 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 


STLHPFC2 lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 300 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

//STCOMPRESSOR stcomp;
//7. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 30::ms /* releaseTime */);   stcomp $ ST @=>  last;   

STLIMITER stlimiter;
4. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl  + 0.10/* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

<<<"~~~~~~~~~FROGGY FILTER~~~~~~~~~~">>>;
<<<"~~~  LPF freq  lpd8 1.1   ~~~~~~">>>;
<<<"~~~  LPF  Q    lpd8 1.2   ~~~~~~">>>;
<<<"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~">>>;

STGAIN stgain;
stgain.connect(last $ ST , 0.6 /* static gain */  );       stgain $ ST @=>  last; 



while(1) {
       100::ms => now;
}
 
LONG_WAV l;
"/home/toup/EC/StayOm/ConfitmontageSatan1.wav" => l.read;
0.3 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(16 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
LONG_WAV l;
"../../_SAMPLES/stayOm/ConfitPiano.wav" => l.read;
0.3 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(16 * data.tick /* sync */ , 128 * data.tick  /* offset */ , 4 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 

104
104
104
67
67
