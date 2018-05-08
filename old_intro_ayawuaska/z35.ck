     fun  void  TRIB ( SEQ @ s) {
			 "../_SAMPLES/NOIIZ/"  => string dir;

			 dir+"Perc_SP_300_48.wav"=>s.wav["a"];
			 dir+"Perc_SP_300_51.wav"=>s.wav["b"];
			 dir+"Perc_SP_300_61.wav"=>s.wav["c"];
			 dir+"Perc_SP_300_63.wav"=>s.wav["d"];
			 dir+"Perc_SP_300_66.wav"=>s.wav["e"];
			 dir+"Rattles_07_76_SP.wav"=>s.wav["f"];
			 dir+"Rattles_37_76_SP.wav"=>s.wav["g"];
			 dir+"Rattles_54_76_SP.wav"=>s.wav["h"];
			 dir+"RIQ_01_76_SP.wav"=>s.wav["i"];
			 dir+"ShakerNormal_03_92_SP.wav"=>s.wav["j"];
			 dir+"ShakerNormal_12_92_SP.wav"=>s.wav["k"];
			 dir+"Standard_Rim_01_321_SP.wav"=>s.wav["l"];
			 dir+"Stutter_Click_01_321_SP.wav"=>s.wav["m"];
			 dir+"Tech_Click_01_321_SP.wav"=>s.wav["n"];
			 dir+"Tech_Perc_01_321_SP.wav"=>s.wav["o"];
			 dir+"Underwater_Bomb_01_321_SP.wav"=>s.wav["p"];
			 dir+"Wanderer_01_255_SP.wav"=>s.wav["q"];
			 dir+"Wood_Foley_01_321_SP.wav"=>s.wav["r"];
			 dir+"Zilbel_01_92_SP.wav"=>s.wav["s"];
			 dir+"Smooth_Live_Kick_01_321_SP.wav"=>s.wav["t"];

				dir + "Darbuka/Darbuka_04_76_SP.wav" => s.wav["u"];
				dir + "Darbuka/Darbuka_116_76_SP.wav" => s.wav["v"];
				dir + "Darbuka/Darbuka_11_76_SP.wav" => s.wav["w"];
				dir + "Darbuka/Darbuka_128_76_SP.wav" => s.wav["x"];
				dir + "Darbuka/Darbuka_150_76_SP.wav" => s.wav["y"];
				dir + "Darbuka/Darbuka_153_76_SP.wav" => s.wav["z"];
				dir + "Darbuka/Darbuka_22_76_SP.wav" => s.wav["A"];
				dir + "Darbuka/Darbuka_44_76_SP.wav" => s.wav["B"];
				dir + "Darbuka/Darbuka_50_76_SP.wav" => s.wav["C"];
				dir + "Darbuka/Darbuka_62_76_SP.wav" => s.wav["D"];
				dir + "Darbuka/Darbuka_73_76_SP.wav" => s.wav["E"];
				dir + "Darbuka/Darbuka_79_76_SP.wav" => s.wav["F"];
				dir + "Metal/18_BellLead_C3_119_SP.wav" => s.wav["G"];
				dir + "Metal/34_Chimes_SP_222_03.wav" => s.wav["H"];
				dir + "Metal/34_HandBells_SP_222_05.wav" => s.wav["I"];
				dir + "Metal/34_HandBells_SP_222_08.wav" => s.wav["J"];
				dir + "Metal/34_HndBllsStr_SP_222_01.wav" => s.wav["K"];
				dir + "Metal/34_Rainstick_SP_222_02.wav" => s.wav["L"];
				dir + "Metal/34_Rainstick_SP_222_03.wav" => s.wav["M"];
				dir + "Metal/71_F_Bell_SP_194_02.wav" => s.wav["N"];
				dir + "Metal/78_Chime_SP_269_02.wav" => s.wav["O"];
				dir + "Metal/C_Bell_221_SP03.wav" => s.wav["P"];
				dir + "Metal/C_Cinematic_4_311_SP.wav" => s.wav["Q"];
				dir + "Metal/Cinematic_9_311_SP.wav" => s.wav["R"];
				dir + "Metal/F_Cinematic_27_311_SP.wav" => s.wav["S"];
				dir + "Metal/G_ChimeBar_05_483.wav" => s.wav["T"];
				dir + "Metal/TubularBell_1_Mallet_395_SP.wav" => s.wav["U"];
				dir + "Metal/TubularBell_3_Mallet_395_SP.wav" => s.wav["V"];
				dir + "Metal/TubularBell_3_Stick_395_SP.wav " => s.wav["W"];
				dir + "Metal/TubularBell_6_Stick_395_SP.wav " => s.wav["X"];
				dir + "Metal/TubularBell_7_Mallet_395_SP.wav" => s.wav["Y"];
				dir + "Metal/NoiseCrash_SP_168_01.wav" => s.wav["Z"];
				
     }


SEQ s;
SET_WAV.TRIBAL1(s);

//data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4 
G_______ 
________
________
________

P_______
________
________
________
G_P_____ 
________
________
________

P_______
________
________
L_______


" => s.seq;
.2 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
