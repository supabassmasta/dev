fun static void DUB ( SEQ @ s) {
  "../_SAMPLES/ONE_SHOT_REGGAE/" => string dir;
  dir + "RIMSHOT_01.wav" => s.wav["a"];
  dir + "RIMSHOT_02.wav" => s.wav["b"];
  dir + "RIMSHOT_03.wav" => s.wav["c"];
  dir + "RIMSHOT_04.wav" => s.wav["d"];
  dir + "RIMSHOT_01.wav" => s.wav["e"];
  dir + "SHaKER_01.wav" => s.wav["f"];
  dir + "SHaKER_02.wav" => s.wav["g"];

  dir + "HI_HaT_01.wav" => s.wav["h"];
  dir + "HI_HaT_02.wav" => s.wav["i"];
  dir + "HI_HaT_03.wav" => s.wav["j"];
  
  dir + "KICK_01.wav" => s.wav["k"];
  dir + "KICK_02.wav" => s.wav["l"];
  dir + "KICK_03.wav" => s.wav["m"];
  dir + "KICK_04.wav" => s.wav["n"];
  dir + "KICK_05.wav" => s.wav["o"];
  dir + "KICK_06.wav" => s.wav["p"];

  dir + "SNaRE_01.wav" => s.wav["s"];
  dir + "SNaRE_02.wav" => s.wav["t"];
  dir + "SNaRE_03.wav" => s.wav["u"];
  dir + "SNaRE_04.wav" => s.wav["v"];
  dir + "SNaRE_05.wav" => s.wav["x"];
  dir + "SNaRE_06.wav" => s.wav["y"];

  dir + "TaMBOURINE_01.wav" => s.wav["z"];


  "../_SAMPLES/REGGAE_SET_1/" => dir;
  
  dir + "Bongo3_Reaggae1.wav" => s.wav["q"];
  dir + "Bongo4_Reaggae1.wav" => s.wav["r"];

  dir + "COWBELL_Reaggae1.wav" => s.wav["A"];
  dir + "Dumfx_Reaggae1.wav" => s.wav["B"];
  dir + "Hand_Clap_Reaggae1.wav" => s.wav["C"];
  dir + "Rim_Shot.wav" => s.wav["D"];
  dir + "Rim_Shot2_Reaggae1.wav" => s.wav["E"];
  dir + "Tambourine_Reaggae1.wav" => s.wav["F"];
  dir + "Timbales1_Reaggae1.wav" => s.wav["G"];
  dir + "Timbales2_Reaggae1.wav" => s.wav["H"];
  dir + "Timbales4_Reaggae1.wav" => s.wav["I"];

  "../_SAMPLES/REGGAE_SET_2/" => dir;

  dir + "Bongo1.wav" => s.wav["J"];
  dir + "Bongo2.wav" => s.wav["K"];
  dir + "Conga_1.wav" => s.wav["L"];
  dir + "Vibraslap_Velo02_Reggae1.wav" => s.wav["M"];
  dir + "Vibraslap_Velo05_Reggae1.wav" => s.wav["N"];
  dir + "Vibraslap_Velo07_Reggae1.wav" => s.wav["O"];
  dir + "Vibraslap_Velo09_Reggae1.wav" => s.wav["P"];

  "../_SAMPLES/AFRICAN_SET/" => dir;

  dir + "AFRICAN_SET.wav" => s.wav["Q"];
  dir + "BONGOLOW.wav" => s.wav["R"];
  dir + "CABASA.wav" => s.wav["S"];
  dir + "INDPER01.wav" => s.wav["T"];
  dir + "INDPER02.wav" => s.wav["U"];
  dir + "INDPER05.wav" => s.wav["V"];
  dir + "INDPER06.wav" => s.wav["W"];
  dir + "INDPER09.wav" => s.wav["X"];
  dir + "TMBALELO.wav" => s.wav["Y"];
 

}

SEQ s;
DUB(s);
//data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 __vas_DQ__ f_v_sTD__P  f___s_D_A_ f_v_s_D__P " => s.seq;
.9 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

while(1) {
       100::ms => now;
}
 
