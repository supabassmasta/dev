
ROOTPATH.str.my_string => string rt;

Machine.add( rt + "CORE/EFFECTS/note_info.ck");
Machine.add( rt + "CORE/EFFECTS/note_info_rx.ck");
Machine.add( rt + "CORE/EFFECTS/note_info_tx.ck");
Machine.add( rt + "CORE/EFFECTS/ST.ck");
Machine.add( rt + "CORE/EFFECTS/OFFSET.ck");
Machine.add( rt + "CORE/EFFECTS/MULT.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/FILTERX.ck");
Machine.add( rt + "include/global_data.ck" );
Machine.add( rt + "include/global_mixer.ck" );
Machine.add( rt + "include/global_event.ck" );
Machine.add( rt + "include/synt_interface.ck" );

//Machine.add( rt + "CORE/seq_decode/seq_decode.ck" );
//Machine.add( rt + "CORE/part_decode/part_decode_new.ck" );
Machine.add( rt + "CORE/nanomidi_5.ck" );
Machine.add( rt + "CORE/lpd8/lpd8.ck" );
//Machine.add(rt + "include/data_updater.ck");
Machine.add( rt + "include/end.ck" );
Machine.add( rt + "include/killer.ck" );
Machine.add( rt + "CORE/save/SAVE.ck" );
Machine.add( rt + "CORE/SYNC/SYNC.ck" );

Machine.add( rt + "CORE/launcher/launcher_hold.ck" );

Machine.add( rt + "CORE/SYNT/list_SERUM0.ck" );

Machine.add( rt + "CORE/MISC/RAND.ck" );
Machine.add( rt + "CORE/MISC/MISC.ck" );
me.yield();
Machine.add( rt + "CORE/SYNTA/SYNTA.ck" );

Machine.add(rt + "CORE/VCF_LPF_light.ck");
Machine.add(rt + "CORE/chord/chord.ck");
Machine.add( rt + "CORE/digit.ck" );
//Machine.add( rt + "CORE/scales/scales.ck");
Machine.add( rt + "CORE/sampler/sampler.ck");
Machine.add( rt + "CORE/EFFECTS/DUCK_MASTER.ck");
Machine.add( rt + "CORE/EFFECTS/CONTROL.ck");
Machine.add( rt + "CORE/EFFECTS/REV0.ck");
Machine.add( rt + "CORE/EFFECTS/REV1.ck");
Machine.add( rt + "CORE/EFFECTS/REC.ck");
Machine.add( rt + "CORE/EFFECTS/STTOAUX.ck");

Machine.add( rt + "CORE/EFFECTS/FILTERX/FILTERX_FACTORY.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/LPFX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/BPFX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/BRFX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/HPFX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/RESX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/DLX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/KGX.ck");
Machine.add( rt + "CORE/EFFECTS/STFREEPAN.ck");
Machine.add( rt + "CORE/EFFECTS/STFREEGAIN.ck");

Machine.add( rt + "CORE/NANOKONTROL/NANO.ck");

Machine.add( rt + "CORE/seq_3/ACTION.ck");
Machine.add( rt + "CORE/seq_3/ELEMENT.ck");

Machine.add( rt + "include/SIN.ck");

Machine.add( rt + "include/NOREPLACE.ck");

Machine.add( rt + "include/WAIT.ck");

Machine.add( rt + "CORE/MISC/COUNTDOWN.ck" );


me.yield();
Machine.add( rt + "CORE/lpk25/lpk25.ck"); 
//Machine.add(rt + "CORE/seq_2/top_seq.ck");
//Machine.add(rt + "CORE/seq_2/seq.ck");
//Machine.add(rt + "CORE/seq_2/seqSndBuf.ck");
//Machine.add(rt + "CORE/seq_2/freq.ck");
//Machine.add(rt + "CORE/seq_2/freq2.ck");
//Machine.add(rt + "CORE/seq_2/seq_script.ck");
Machine.add(rt + "CORE/break/break.ck");
Machine.add(rt + "CORE/lpd8/lpd8_master.ck");
Machine.add(rt + "CORE/EFFECTS/DUCK.ck");

Machine.add( rt + "CORE/seq_3/SEQ3.ck");
Machine.add( rt + "CORE/seq_3/WAV.ck");

Machine.add( rt + "CORE/EFFECTS/FILTERX/LPF_XFACTORY.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/BPF_XFACTORY.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/BRF_XFACTORY.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/HPF_XFACTORY.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/RES_XFACTORY.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/DL_XFACTORY.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/KG_XFACTORY.ck");

Machine.add( rt + "CORE/EFFECTS/FILTERX/FILTERX_PATH.ck");

me.yield();
Machine.add( rt + "CORE/seq_3/MASTER_SEQ3.ck");

Machine.add( rt + "CORE/EFFECTS/CONTROLER.ck");

Machine.add( rt + "CORE/EFFECTS/FILTERX/STFILTERX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/STSYNCFILTERX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/STQSYNCFILTERX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/STFREEFILTERX.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/STAUTOFILTERX.ck");

me.yield();
Machine.add( rt + "CORE/EFFECTS/END_CONTROL.ck");
Machine.add( rt + "CORE/seq_3/MIDI_BPM_TRACKER.ck");
me.yield();

Machine.add( rt + "CORE/EFFECTS/FILTERX/STFILTERXC.ck");
Machine.add( rt + "CORE/EFFECTS/FILTERX/STFILTERXC2.ck");
// SYNTA
Machine.add(rt + "CORE/SYNTA/GLIDE.ck");
Machine.add(rt + "CORE/SYNTA/POLY.ck");


// SYNT
Machine.add(rt + "CORE/SYNT/SUPERSAW0.ck");
Machine.add(rt + "CORE/SYNT/SUPERSAW1.ck");
Machine.add(rt + "CORE/SYNT/SUPERSAW2.ck");
Machine.add(rt + "CORE/SYNT/SUPERSAW3.ck");
Machine.add(rt + "CORE/SYNT/SUPERSAW4.ck");
Machine.add(rt + "CORE/SYNT/SUPERSAW5.ck");
Machine.add(rt + "CORE/SYNT/CHILL.ck");
Machine.add(rt + "CORE/SYNT/HORROR.ck");
Machine.add(rt + "CORE/SYNT/GRAIN.ck");
Machine.add(rt + "CORE/SYNT/TB303.ck");
Machine.add(rt + "CORE/SYNT/TB303C.ck");
Machine.add(rt + "CORE/SYNT/MOD.ck");
Machine.add(rt + "CORE/SYNT/STRINGBASS.ck");
Machine.add(rt + "CORE/SYNT/AMBIENT.ck");
Machine.add(rt + "CORE/SYNT/AMBIENT2.ck");
Machine.add(rt + "CORE/SYNT/RESYNT.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS0.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS1.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS2.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS3.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS4.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS5.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS6.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS7.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS8.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS9.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS10.ck");
Machine.add(rt + "CORE/SYNT/PSYBASS11.ck");
Machine.add(rt + "CORE/SYNT/HPSYBASS0.ck");
Machine.add(rt + "CORE/SYNT/MOD0.ck");
Machine.add(rt + "CORE/SYNT/MOD1.ck");
Machine.add(rt + "CORE/SYNT/MOD2.ck");
Machine.add(rt + "CORE/SYNT/MOD3.ck");
Machine.add(rt + "CORE/SYNT/MOD4.ck");
Machine.add(rt + "CORE/SYNT/MOD5.ck");
Machine.add(rt + "CORE/SYNT/MOD6.ck");
Machine.add(rt + "CORE/SYNT/HMOD0.ck");
Machine.add(rt + "CORE/SYNT/HMOD1.ck");
Machine.add(rt + "CORE/SYNT/DUBBASS0.ck");
Machine.add(rt + "CORE/SYNT/DUBBASS1.ck");
Machine.add(rt + "CORE/SYNT/DUBBASS2.ck");
Machine.add(rt + "CORE/SYNT/DUBBASS3.ck");
Machine.add(rt + "CORE/SYNT/PLOC0.ck");
Machine.add(rt + "CORE/SYNT/PLOC1.ck");
Machine.add(rt + "CORE/SYNT/PLOC2.ck");
Machine.add(rt + "CORE/SYNT/PLOC3.ck");
Machine.add(rt + "CORE/SYNT/FROG0.ck");
Machine.add(rt + "CORE/SYNT/FROG1.ck");
Machine.add(rt + "CORE/SYNT/FROG2.ck");
Machine.add(rt + "CORE/SYNT/FROG3.ck");
Machine.add(rt + "CORE/SYNT/FROG4.ck");
Machine.add(rt + "CORE/SYNT/NOISE0.ck");
Machine.add(rt + "CORE/SYNT/NOISE1.ck");
Machine.add(rt + "CORE/SYNT/NOISE2.ck");
Machine.add(rt + "CORE/SYNT/NOISE3.ck");
Machine.add(rt + "CORE/SYNT/NOISE4.ck");
Machine.add(rt + "CORE/SYNT/AMB0.ck");
Machine.add(rt + "CORE/SYNT/AMB1.ck");
Machine.add(rt + "CORE/SYNT/AMB2.ck");
Machine.add(rt + "CORE/SYNT/AMB3.ck");
Machine.add(rt + "CORE/SYNT/AMB4.ck");
Machine.add(rt + "CORE/SYNT/AMB5.ck");
Machine.add(rt + "CORE/SYNT/AMB6.ck");
Machine.add(rt + "CORE/SYNT/AMB7.ck");
Machine.add(rt + "CORE/SYNT/AMB8.ck");
Machine.add(rt + "CORE/SYNT/AMB9.ck");
Machine.add(rt + "CORE/SYNT/AMB10.ck");
Machine.add(rt + "CORE/SYNT/AMB11.ck");
Machine.add(rt + "CORE/SYNT/SERUM0.ck");
Machine.add(rt + "CORE/SYNT/SERUM2.ck");
Machine.add(rt + "CORE/SYNT/SERUM00.ck");
Machine.add(rt + "CORE/SYNT/PAD0.ck");
Machine.add(rt + "CORE/SYNT/PAD1.ck");
Machine.add(rt + "CORE/SYNT/PAD2.ck");
Machine.add(rt + "CORE/SYNT/PAD3.ck");
Machine.add(rt + "CORE/SYNT/VIOLIN0.ck");
Machine.add(rt + "CORE/SYNT/VIOLIN1.ck");
Machine.add(rt + "CORE/SYNT/CELLO0.ck");
Machine.add(rt + "CORE/SYNT/VOICEA0.ck");
Machine.add(rt + "CORE/SYNT/VOICEA1.ck");
Machine.add(rt + "CORE/SYNT/VOICEA2.ck");
Machine.add(rt + "CORE/SYNT/SYNTWAV.ck");
Machine.add(rt + "CORE/SYNT/SYNTADD.ck");
Machine.add(rt + "CORE/SYNT/KIK.ck");

// MONO EFFECTS
Machine.add(rt + "CORE/EFFECTS/MGAINC.ck");
Machine.add(rt + "CORE/EFFECTS/MGAINC2.ck");

// STEREO EFFECTS
Machine.add(rt + "CORE/EFFECTS/LPF_ST.ck");
Machine.add(rt + "CORE/EFFECTS/STECHO.ck");
Machine.add(rt + "CORE/EFFECTS/STREV1.ck");
Machine.add(rt + "CORE/EFFECTS/STAUTOPAN.ck");
Machine.add( rt + "CORE/EFFECTS/STDUCKMASTER.ck");
Machine.add( rt + "CORE/EFFECTS/STDUCK.ck");
Machine.add( rt + "CORE/EFFECTS/STDIGIT.ck");
Machine.add( rt + "CORE/EFFECTS/STECHOC.ck");
Machine.add( rt + "CORE/EFFECTS/STECHOC0.ck");
Machine.add( rt + "CORE/EFFECTS/STECHOLHPFC.ck");
Machine.add( rt + "CORE/EFFECTS/STLPFC.ck");
Machine.add( rt + "CORE/EFFECTS/STLHPFC.ck");
Machine.add( rt + "CORE/EFFECTS/STBPFC.ck");
Machine.add( rt + "CORE/EFFECTS/STHPFC.ck");
Machine.add( rt + "CORE/EFFECTS/STBRFC.ck");
Machine.add( rt + "CORE/EFFECTS/STRESC.ck");
Machine.add( rt + "CORE/EFFECTS/STLPF.ck");
Machine.add( rt + "CORE/EFFECTS/STBPF.ck");
Machine.add( rt + "CORE/EFFECTS/STHPF.ck");
Machine.add( rt + "CORE/EFFECTS/STBRF.ck");
Machine.add( rt + "CORE/EFFECTS/STRES.ck");
Machine.add( rt + "CORE/EFFECTS/STWPDiodeLadder.ck");
Machine.add( rt + "CORE/EFFECTS/STWPKorg35.ck");
Machine.add( rt + "CORE/EFFECTS/STADC1.ck");
Machine.add( rt + "CORE/EFFECTS/STGAINC.ck");
Machine.add( rt + "CORE/EFFECTS/STGAIN.ck");
Machine.add( rt + "CORE/EFFECTS/STDIGITC.ck");
Machine.add( rt + "CORE/EFFECTS/STFADEIN.ck");
Machine.add( rt + "CORE/EFFECTS/STFADEOUT.ck");
Machine.add( rt + "CORE/EFFECTS/STFILTERMOD.ck");
Machine.add( rt + "CORE/EFFECTS/STBREAK.ck");
Machine.add( rt + "CORE/EFFECTS/STADSRC.ck");
Machine.add( rt + "CORE/EFFECTS/STABSATURATOR.ck");
Machine.add( rt + "CORE/EFFECTS/STMIX.ck");
Machine.add( rt + "CORE/EFFECTS/STMULT_BASE_ONE.ck");
Machine.add( rt + "CORE/EFFECTS/STMULT_BASE_ZERO.ck");
Machine.add( rt + "CORE/EFFECTS/STADSR.ck");
Machine.add( rt + "CORE/EFFECTS/STPADSR.ck");
Machine.add( rt + "CORE/EFFECTS/STSYNCLPF.ck");
Machine.add( rt + "CORE/EFFECTS/STSYNCLPF2.ck");
Machine.add( rt + "CORE/EFFECTS/STSYNCBPF.ck");
Machine.add( rt + "CORE/EFFECTS/STSYNCHPF.ck");
Machine.add( rt + "CORE/EFFECTS/STSYNCBRF.ck");
Machine.add( rt + "CORE/EFFECTS/STSYNCRES.ck");
Machine.add( rt + "CORE/EFFECTS/STSYNCWPDiodeLadder.ck");
Machine.add( rt + "CORE/EFFECTS/STSYNCWPKorg35.ck");
Machine.add( rt + "CORE/EFFECTS/STRECCONV.ck");
Machine.add( rt + "CORE/EFFECTS/STTREMOLO.ck");
Machine.add( rt + "CORE/EFFECTS/STCOMPRESSOR.ck");
Machine.add( rt + "CORE/EFFECTS/STLIMITER.ck");
Machine.add( rt + "CORE/EFFECTS/STGVERB.ck");
Machine.add( rt + "CORE/EFFECTS/STFLANGER.ck");
Machine.add( rt + "CORE/EFFECTS/STEPC.ck");
Machine.add( rt + "CORE/EFFECTS/DETUNE.ck");
Machine.add( rt + "CORE/EFFECTS/STREC.ck");
Machine.add( rt + "CORE/EFFECTS/STSAMPLER.ck");
Machine.add( rt + "CORE/EFFECTS/STDELAY.ck");
Machine.add( rt + "CORE/EFFECTS/STDELAY2.ck");
Machine.add( rt + "CORE/EFFECTS/STEQ.ck");
Machine.add( rt + "CORE/EFFECTS/STDUCK2.ck");
Machine.add( rt + "CORE/EFFECTS/STDUCKMASTER2.ck");
Machine.add( rt + "CORE/EFFECTS/ADSRMOD.ck");
Machine.add( rt + "CORE/EFFECTS/ADSRMOD2.ck");
Machine.add( rt + "CORE/EFFECTS/STOVERDRIVE.ck");
Machine.add( rt + "CORE/EFFECTS/STROTATE.ck");
Machine.add( rt + "CORE/EFFECTS/STECHOV.ck");
Machine.add( rt + "CORE/EFFECTS/STCROSSOUT.ck");
Machine.add( rt + "CORE/EFFECTS/STCROSSIN.ck");
Machine.add( rt + "CORE/EFFECTS/STCONVREV.ck");
me.yield();
Machine.add( rt + "CORE/EFFECTS/STLPFC2.ck");
Machine.add( rt + "CORE/EFFECTS/STHPFC2.ck");
Machine.add( rt + "CORE/EFFECTS/STLHPFC2.ck");
Machine.add( rt + "CORE/EFFECTS/STLPFN.ck");
Machine.add( rt + "CORE/EFFECTS/STHISHELF.ck");
Machine.add( rt + "CORE/EFFECTS/STLOSHELF.ck");
Machine.add( rt + "CORE/EFFECTS/STBELL.ck");
Machine.add( rt + "CORE/EFFECTS/STCROSSOVER.ck");

Machine.add( rt + "CORE/EFFECTS/MASTER_STADSR.ck");
Machine.add( rt + "CORE/EFFECTS/MULTIREC.ck");

Machine.add( rt + "CORE/LONG_WAV/LONG_WAV.ck");
Machine.add( rt + "CORE/LONG_WAV/LOOP_WAV.ck");
Machine.add( rt + "CORE/LONG_WAV/LOOP_DOUBLE_WAV.ck");
Machine.add( rt + "CORE/LONG_WAV/LOOP_DOUBLE_WAV_SYNC.ck");
Machine.add( rt + "CORE/EFFECTS/REV2.ck");
//Machine.add(rt + "CORE/seq_2/FREQ_STR.ck");
//Machine.add(rt + "CORE/seq_2/SEQ_STR.ck");
Machine.add( rt + "CORE/seq_3/SEQ.ck");
Machine.add( rt + "CORE/seq_3/TONE.ck");
Machine.add( rt + "CORE/NANOKONTROL/NANO_CONTROLER.ck");
Machine.add( rt + "CORE/launchpad/LAUNCHPAD_CONTROLER.ck");
Machine.add( rt + "CORE/launchpad/LAUNCHPAD_VIRTUAL.ck");
Machine.add( rt + "CORE/lpd8/LPD8_CONTROLLER.ck");
Machine.add( rt + "CORE/KBCONTROLLER/KBCONTROLLER.ck");
Machine.add( rt + "CORE/ledstrip/ledstrip.ck");

// Composite SYNTs
Machine.add(rt + "CORE/SYNT/CELLO1.ck");
Machine.add(rt + "CORE/SYNT/CELLO2.ck");
Machine.add(rt + "CORE/SYNT/CELLO3.ck");
Machine.add(rt + "CORE/SYNT/CHORUSA0.ck");
Machine.add(rt + "CORE/SYNT/CHORUSA1.ck");
Machine.add(rt + "CORE/SYNT/CHORUSA2.ck");
Machine.add(rt + "CORE/SYNT/SERUM1.ck");
Machine.add(rt + "CORE/SYNT/SERUM01.ck");
Machine.add(rt + "CORE/SYNT/SERUM3.ck");
Machine.add(rt + "CORE/SYNT/SYNTLAB.ck");



me.yield();
Machine.add(rt + "CORE/seq_3/POLYTONE.ck");
Machine.add(rt + "CORE/seq_3/POLYSEQ.ck");
Machine.add(rt + "CORE/EFFECTS/STREV2.ck");
Machine.add( rt + "include/HW.ck");
Machine.add( rt + "CORE/seq_3/SET_WAV.ck");
Machine.add( rt + "CORE/seq_3/SET_WAV2.ck");
Machine.add(rt + "CORE/EFFECTS/ARP.ck");
Machine.add(rt + "CORE/EFFECTS/STCUTTER.ck");
Machine.add(rt + "CORE/EFFECTS/STREVAUX.ck");
Machine.add("page_manager_nb_page_config.ck"); // PAGE MANAGER : NUMBER OF PAGES
Machine.add(rt + "CORE/SYNT/AUTO.ck");
me.yield();
Machine.add( rt + "CORE/EFFECTS/STSAMPLERC.ck");
Machine.add( rt + "CORE/launchpad/script_launcher.ck");
Machine.add("config.ck");
me.yield();

<<<"---------------------------------------------------------------------------------------" >>>;
<<<"SERUM Memo:" >>>;
<<<"SERUM0 : Single wav with rank for distortion">>>;
<<<"SERUM1 : multi wav from SERUM0 with ADSR for each, classic synt can be added">>>;
<<<"SERUM2 : InspectorGadget single wav collection, with dynamic on the flight rank ">>>;
<<<"SERUM3 : InspectorGadget multi wav collection, smooth trnasition from wav to wav with a UGen input ">>>;
<<<"SERUM00 : Single wav massive collection">>>;
<<<"SERUM01 : Same as SERUM1 with massive collection">>>;
<<<"---------------------------------------------------------------------------------------" >>>;
<<<"---------------------------------------------------------------------------------------" >>>;
<<<"Notes MEMO:">>>;
<<<" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz">>>;
<<<"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567">>>;
<<<"---------------------------------------------------------------------------------------" >>>;
<<<"LATENCY Memo:">>>;
<<<"ctopp: 334ms">>>;
<<<"ctopj internatl card: 188ms">>>;
<<<"ctopj Scarlett: 390ms">>>;
<<<"---------------------------------------------------------------------------------------" >>>;


