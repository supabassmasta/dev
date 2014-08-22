Machine.add( "../include/global_data.ck" );
Machine.add( "../include/global_mixer.ck" );
Machine.add( "../include/global_event.ck" );
Machine.add( "../include/synt_interface.ck" );
//Machine.add( "../seq_decode/seq_decode.ck" );
//Machine.add( "../part_decode/part_decode_new.ck" );
Machine.add( "../nanomidi_5.ck" );
Machine.add( "../lpd8/lpd8.ck" );
Machine.add("../include/data_updater.ck");
Machine.add( "../include/end.ck" );
Machine.add( "../include/killer.ck" );

Machine.add( "../launcher/launcher_hold.ck" );

Machine.add("../VCF_LPF_light.ck");
Machine.add("../chord/chord.ck");
Machine.add( "../digit.ck" );
Machine.add( "../scales/scales.ck");
Machine.add( "../sampler/sampler.ck");
me.yield();
//Machine.add("../seq_2/top_seq.ck");
Machine.add("../seq_2/seq.ck");
Machine.add("../seq_2/seqSndBuf.ck");
Machine.add("../seq_2/freq.ck");
Machine.add("../seq_2/freq2.ck");
Machine.add("../seq_2/seq_script.ck");
Machine.add("../break/break.ck");
me.yield();
Machine.add("../seq_2/FREQ_STR.ck");
Machine.add("../seq_2/SEQ_STR.ck");
me.yield();

