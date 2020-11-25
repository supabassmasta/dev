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

6::ms => dur experimental_offset;

0 => int total_midi_clocks;
0 => int start_recvd;
0 => int spp_recvd;
0 => int started;
1 => int first_sync;

0 => int midi_beats; // 1 midi beat == 6 midi clocks

1 * 24 * 12 => int midi_clock_interval_update;
0 => int last_total_midi_clocks; // initialize to trig on the first midi colock
data.T0 => time spp_ref_time;
data.T0 => time last_spp_ref_time;
0::ms => dur delta_acc;
0 => int delta_acc_cnt;
time last_midi_clock_time;
time old_last_midi_clock_time;

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

      if (  msg.data1 == 250 ) {
        1 => start_recvd;
      }
      if ( start_recvd && spp_recvd  ){
        1 => started;
        <<<"STARTED">>>;
      }
    }
    else { // started
      if ( msg.data1 == 248 ) {
        // 1 +=> nb_midi_clocks;
        now => last_midi_clock_time;
        1 +=> total_midi_clocks;
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
        last_midi_clock_time - total_midi_clocks * data.tick / (24*4) => spp_ref_time;
        // Adjust SPP with midi beats inside message
        spp_ref_time - midi_beats * data.tick / (4 * 4) => spp_ref_time;

        // We can adjust ref time
        MASTER_SEQ3.update_ref_times(spp_ref_time + experimental_offset, data.tick * 16 * 128 );
        <<<"REF TIME Updated with SPP. spp_ref_time: ", spp_ref_time, " last_midi_clock_time: ", last_midi_clock_time, " total_midi_clocks: ", total_midi_clocks >>>;
        
        spp_ref_time => last_spp_ref_time;
        total_midi_clocks => last_total_midi_clocks;
        last_midi_clock_time => old_last_midi_clock_time;

    }
    else {
       // Compute spp message arrival
        last_midi_clock_time - total_midi_clocks * data.tick / (24*4) => spp_ref_time;
        // Adjust SPP with midi beats inside message
        spp_ref_time - midi_beats * data.tick / (4 * 4) => spp_ref_time;

        // Accumulate delta in ref time calculation
        spp_ref_time - last_spp_ref_time +=> delta_acc;
        1 +=> delta_acc_cnt;
      
      if (total_midi_clocks > last_total_midi_clocks + midi_clock_interval_update) { // At least one midi clock received
        // Last midi clock received is the most accurate in Chuck time
        // Use it to convert midi spp to chuck time
        
        // Mean delta and add it to last spp ref time
        last_spp_ref_time + delta_acc/delta_acc_cnt => spp_ref_time;

        // We can adjust ref time
        MASTER_SEQ3.update_ref_times(spp_ref_time + experimental_offset, data.tick * 16 * 128 );
        <<<"REF TIME Updated with SPP. spp_ref_time: ", spp_ref_time, " last_midi_clock_time: ", last_midi_clock_time, " total_midi_clocks: ", total_midi_clocks, "delta ",  (delta_acc/delta_acc_cnt) / 1::ms, " delta_acc_cnt ", delta_acc_cnt >>>;


        // BPM
       (total_midi_clocks - last_total_midi_clocks ) * 60::second / ( ( last_midi_clock_time - old_last_midi_clock_time ) * 24 * 4) => float bpm;

        <<<"BPM:", bpm >>>;


        total_midi_clocks => last_total_midi_clocks;
        spp_ref_time => last_spp_ref_time;
        0::ms =>  delta_acc;
        0 =>  delta_acc_cnt;
        last_midi_clock_time => old_last_midi_clock_time;


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
 
