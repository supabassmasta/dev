//"Scarlett 2i4 USB MIDI 1" => string device;
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

-1 * 198::ms + 6::ms => dur experimental_offset;

0.01 => float tick_cor_percent;
5 => int tick_update_reload;
tick_update_reload => int tick_update_cnt;

0 => int total_midi_clocks;
0 => int start_recvd;
0 => int spp_recvd;
0 => int started;
1 => int first_sync;

0 => int midi_beats; // 1 midi beat == 6 midi clocks

1 * 24 * 2 => int midi_clock_interval_update;
0 => int last_total_midi_clocks; // initialize to trig on the first midi colock
data.T0 => time spp_ref_time;
data.T0 => time last_spp_ref_time;
0::ms => dur delta_acc;
0 => int delta_acc_cnt;
time last_midi_clock_time;

1 * 24 * 4 => int bpm_interval_update;
time bpm_last_midi_clock_time;
0 => int bpm_last_total_midi_clocks;
float bpm;

//100 => int dispaly_cnt;
//now => time start;
while(1) {
  // 0 => int nb_midi_clocks;
  min => now;
  while( min.recv(msg) )
  {
    if ( ! started  ){
      if (  msg.data1 == 242 ) {
        1 => spp_recvd;
        msg.data3 << 7 | msg.data2 => midi_beats;
        <<<"SPP midi beats: ", midi_beats >>>;
      }

      if (  msg.data1 == 250 || msg.data1 == 251 /* continue */ ) {
        1 => start_recvd;
      }
      if ( start_recvd && spp_recvd  ){
        1 => started;
        <<<"STARTED">>>;
      }

        <<<msg.data1, msg.data2, msg.data3>>>;

    }
    else { // started
      if ( msg.data1 == 248 ) {
        // 1 +=> nb_midi_clocks;
        now => last_midi_clock_time;
        1 +=> total_midi_clocks;
      }
      else {
        if (  msg.data1 == 242 ) {
          1 => spp_recvd;
          msg.data3 << 7 | msg.data2 => midi_beats;
          <<<"RESTARTED SPP midi beats: ", midi_beats >>>;
          1 => first_sync;
          0 => total_midi_clocks;
        }
        <<<msg.data1, msg.data2, msg.data3>>>;

      }
    }
  }

  // Exit loop, no more message in midi buffer

  if (started) {
    if (first_sync && total_midi_clocks > 0 ) { // At least one midi clock received
        0 => first_sync;
        // Last midi clock received is the most accurate in Chuck time
        // Use it to convert midi spp to chuck time
        
        // Compute spp message arrival
        last_midi_clock_time - total_midi_clocks * data.tick / (24*1) => spp_ref_time;
        // Adjust SPP with midi beats inside message
        spp_ref_time - midi_beats * data.tick / (4 * 1) => spp_ref_time;

        // We can adjust ref time
        MASTER_SEQ3.update_ref_times(spp_ref_time + experimental_offset, data.tick * 16 * 128 );
        <<<"REF TIME Updated with SPP. spp_ref_time: ", spp_ref_time, " last_midi_clock_time: ", last_midi_clock_time, " total_midi_clocks: ", total_midi_clocks >>>;
        
        spp_ref_time => last_spp_ref_time;
        total_midi_clocks => last_total_midi_clocks;

        last_midi_clock_time => bpm_last_midi_clock_time;
        total_midi_clocks => bpm_last_total_midi_clocks;
    }
    else {
       // Compute spp message arrival
        last_midi_clock_time - total_midi_clocks * data.tick / (24*1) => spp_ref_time;
        // Adjust SPP with midi beats inside message
        spp_ref_time - midi_beats * data.tick / (4 * 1) => spp_ref_time;

        // Accumulate delta in ref time calculation
        spp_ref_time - last_spp_ref_time +=> delta_acc;
        1 +=> delta_acc_cnt;
      
      if (total_midi_clocks > last_total_midi_clocks + midi_clock_interval_update) { // At least one midi clock received
        // Last midi clock received is the most accurate in Chuck time
        // Use it to convert midi spp to chuck time
        
        // Mean delta and add it to last spp ref time
        delta_acc/delta_acc_cnt => dur delta;
        last_spp_ref_time + delta => spp_ref_time;

        ////////////////////////////////////////////////
        // BPM
       
       if (total_midi_clocks > bpm_last_total_midi_clocks + bpm_interval_update) {

         (total_midi_clocks - bpm_last_total_midi_clocks ) * 60::second / ( ( last_midi_clock_time - bpm_last_midi_clock_time ) * 24 * 1) => bpm;
        
         // FILTER BPM
         0.5  => float fact_bpm; 
         bpm * fact_bpm + data.bpm * (1 - fact_bpm) => bpm;

         if (Std.fabs(bpm - data.bpm) > 0.2) {

           data.tick => dur old_tick;
           60::second / bpm => data.tick;
           bpm => data.bpm; 


           // Adjust ref_time to new BPM
           (now - spp_ref_time) * (data.tick / old_tick) => dur ref_time_from_now;
           now - ref_time_from_now => spp_ref_time;
         } 

         last_midi_clock_time => bpm_last_midi_clock_time;
         total_midi_clocks => bpm_last_total_midi_clocks;
       }
       <<<"Computed BPM:", bpm , " Used BPM:", data.bpm>>>;
 //        1 -=> tick_update_cnt;
 //        if (tick_update_cnt == 0) {
 //          tick_update_reload => tick_update_cnt;
 //          // UPDATE TICK
 
 //           10::samp => dur max_cor;  
 //           if (delta > 4::ms || delta < -1 * 4::ms) {
 //             delta * tick_cor_percent => dur cor;
//             if ( cor > max_cor ) max_cor => cor;
//             else if ( cor < -1 * max_cor )  -1 * max_cor => cor;
//             
//             
//             cor + data.tick => data.tick;
//           }


//           data.tick - delta * tick_cor_percent  => data.tick;


          // recompute spp ref time with new tick
////          last_midi_clock_time - total_midi_clocks * data.tick / (24*4) => spp_ref_time;
//          spp_ref_time - midi_beats * data.tick / (4 * 4) => spp_ref_time;
          // fix it with the rest of delta
//          delta * (1 - tick_cor_percent) + spp_ref_time => spp_ref_time;
//        }
          <<<"DATA.TICK ", data.tick / 1::ms >>>;


        /////////////////////////////////////////////////
        // We can adjust ref time
        MASTER_SEQ3.update_ref_times(spp_ref_time + experimental_offset, data.tick * 16 * 128 );
        <<<"REF TIME Updated with SPP. spp_ref_time: ", spp_ref_time, " last_midi_clock_time: ", last_midi_clock_time, " total_midi_clocks: ", total_midi_clocks, "delta ",  (delta_acc/delta_acc_cnt) / 1::ms, " delta_acc_cnt ", delta_acc_cnt >>>;




        total_midi_clocks => last_total_midi_clocks;
        spp_ref_time => last_spp_ref_time;
        0::ms =>  delta_acc;
        0 =>  delta_acc_cnt;


      }
    }
  }


  // 1 -=> dispaly_cnt;
  // if ( dispaly_cnt == 0 ){
  //   <<<"nb_midi_clocks", nb_midi_clocks>>>;
  //   <<<"total_midi_clocks", total_midi_clocks, total_midi_clocks * (data.tick / (4*24)) / 1::second>>>;
  //   <<<"time", ( now - start )/1::second >>>;
  //   100 =>  dispaly_cnt;
  // }



}
 
