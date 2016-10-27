fun static void ACOUSTIC ( SEQ @ s) {
    "../_SAMPLES/AVL_Drumkits_1.1-fix/" => string dir;

    //dir + "" => s.wav[""];
    dir + "36-Ludwig26Kick-1.wav" => s.wav["K"];
    dir + "36-Ludwig26Kick-2.wav" => s.wav["L"];
    dir + "36-Ludwig26Kick-3.wav" => s.wav["M"];
    dir + "36-Ludwig26Kick-4.wav" => s.wav["N"];
    dir + "36-Ludwig26Kick-5.wav" => s.wav["O"];

    dir + "36-Pearl22Kick-1.wav" => s.wav["k"];
    dir + "36-Pearl22Kick-2.wav" => s.wav["l"];
    dir + "36-Pearl22Kick-3.wav" => s.wav["m"];
    dir + "36-Pearl22Kick-4.wav" => s.wav["n"];
    dir + "36-Pearl22Kick-5.wav" => s.wav["o"];

    dir + "38-PearlSnare-1.wav" => s.wav["s"];
    dir + "38-PearlSnare-2.wav" => s.wav["t"];
    dir + "38-PearlSnare-3.wav" => s.wav["u"];
    dir + "38-PearlSnare-4.wav" => s.wav["v"];
    dir + "38-PearlSnare-5.wav" => s.wav["w"];

    dir + "38-PearlSnare2-1.wav" => s.wav["S"];
    dir + "38-PearlSnare2-2.wav" => s.wav["T"];
    dir + "38-PearlSnare2-3.wav" => s.wav["U"];
    dir + "38-PearlSnare2-4.wav" => s.wav["V"];
    dir + "38-PearlSnare2-5.wav" => s.wav["W"];

    dir + "42-SabianRockHatClosed-1.wav" => s.wav["f"];
    dir + "42-SabianRockHatClosed-2.wav" => s.wav["g"];
    dir + "42-SabianRockHatClosed-3.wav" => s.wav["h"];
    dir + "42-SabianRockHatClosed-4.wav" => s.wav["i"];
    dir + "42-SabianRockHatClosed-5.wav" => s.wav["j"];
    
    dir + "46-SabianRockHatSemiOpen-1.wav" => s.wav["F"];
    dir + "46-SabianRockHatSemiOpen-2.wav" => s.wav["G"];
    dir + "46-SabianRockHatSemiOpen-3.wav" => s.wav["H"];
    dir + "46-SabianRockHatSemiOpen-4.wav" => s.wav["I"];
    dir + "46-SabianRockHatSemiOpen-5.wav" => s.wav["J"];

    dir + "37-Sidestick2-1.wav" => s.wav["a"];
    dir + "37-Sidestick2-2.wav" => s.wav["b"];
    dir + "37-Sidestick2-3.wav" => s.wav["c"];
    dir + "37-Sidestick2-4.wav" => s.wav["d"];
    dir + "37-Sidestick2-5.wav" => s.wav["e"];

    dir + "37-Sidestick-1.wav" => s.wav["A"];
    dir + "37-Sidestick-2.wav" => s.wav["B"];
    dir + "37-Sidestick-3.wav" => s.wav["C"];
    dir + "37-Sidestick-4.wav" => s.wav["D"];
    dir + "37-Sidestick-5.wav" => s.wav["E"];
}


SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s);
ACOUSTIC(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//"*4k_k_w__<<s_<<sk_w__s" => s.seq;
"*4hfhfhfifhfiHhfhf" => s.seq;
//"*4fh" => s.seq;
 s.element_sync(); //s.no_sync(); //s.full_sync();     //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 


while(1) {
       100::ms => now;
}
 
