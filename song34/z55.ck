class cont extends CONTROL {
     Event @ e;
     // 0 =>  update_on_reg ;
        fun void set(float in) {
          if ( in !=0  ){
              e.signal();
          }
        }
} 

class STSAMPLERC extends ST {
  Gain in[2];
  Gain out[2];
  Delay del[2];
  out[0] => outl;
  out[1] => outr;

  string path;
  string name;
  
  int file_nb, file_x, file_y;
  Event rec_e;

  cont cont_rec;
  rec_e @=> cont_rec.e;

  in => out;
  in[0] => del[0] => blackhole;
  in[1] => del[1] => blackhole;
  1. => del[0].gain => del[1].gain;


  fun void f1 ( dur sync_dur, int no_sync ){ 

    // get file index
    SAVE sav;
    "." => sav.dir; // save index in current directory
    "sampler_index_" + name => string fname;
    
    while(1) {

      // Wait event to start
      rec_e => now;     

      sav.readi(fname) => int findex;
      findex + 1 => findex;
      sav.savei(fname, findex);


      // sync
      if ( !no_sync ){
        if (sync_dur == 0::ms)  {
          // sync on full seq
          <<<"ERROR STSAMPLERC NO Sync on full dur">>>;
        }
        else {
          sync_dur  - ((now - data.wait_before_start)%sync_dur) => now;
        }
      }

      now => time start_rec_t;

      <<<"********************">>>; 
      <<<"********************">>>; 
      <<<"***   REC       ****">>>; 
      <<<"********************">>>; 
      <<<"********************">>>; 

      in =>  WvOut2 w => blackhole;
      path + name + findex + ".wav" => w.wavFilename;

      // Wait event to stop
      rec_e => now;     

      // sync
      if ( !no_sync ){
        if (sync_dur == 0::ms)  {
          // sync on full seq
          <<<"ERROR STSAMPLERC NO Sync on full dur">>>;
        }
        else {
          sync_dur  - ((now - data.wait_before_start)%sync_dur) => now;
        }
      }


      


      w =< blackhole;

      del => del;
      del => out;

      in[0] =< del[0];
      in[1] =< del[1];
      in[0] =< out[0];
      in[1] =< out[1];
      del[0] =< blackhole;
      del[1] =< blackhole;
      now - start_rec_t =>  del[0].delay => del[1].delay;
      <<<"********************">>>; 
      <<<"********************">>>; 
      <<<"***  END  REC   ****">>>; 
      <<<"********************">>>; 
      <<<"********************">>>; 


      1::ms => now;
    }

  } 

  fun void connect(ST @ tone, dur max, string p, string n,  dur sync_dur, int no_sync) {
    // sync_dur is used to sync: start rec, stop rec, start play, stop play
    tone.left() => in[0];
    tone.right() => in[1];

    // Arbitrary max delay to have a lot to record
    max => del[0].max => del[0].delay => del[1].max => del[1].delay;

    p => path;
    n => name;

    MISC.file_nb(me.path()) => file_nb;

    // Compute coordinate on launchpad
    file_nb/ 10 -1 => file_x;
    file_nb%10 -1 =>  file_y;

    // REC button
    HW.launchpad.color(16*(file_x+1) + file_y ,52);
    HW.launchpad.keys[ 16*(file_x+1) + file_y].reg(cont_rec);

    // play button
    HW.launchpad.color(16*(file_x+2) + file_y ,44);


    spork ~ f1 (sync_dur, no_sync );
  }
}

class STADC1 extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1. => gainl.gain => gainr.gain;

  adc => gainl;
  adc => gainr;

}

STADC1 stadc1; stadc1 $ ST @=>  ST @ last; 

//STCONVREV stconvrev;
//stconvrev.connect(last $ ST , 6/* ir index */, 2 /* chans */, 10::ms /* pre delay*/, .3 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

STSAMPLERC stsamplerc;
stsamplerc.connect(last $ ST, 2::minute /*max delay*/, "./" /* path for wav */,  "sample" /* wav name, /!\ NO EXTENSION */, 4 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); stsamplerc $ ST @=>  last;  


while(1) {
       100::ms => now;
}
 
