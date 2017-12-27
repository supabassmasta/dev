
fun void PROG ( SEQ @ s) {
    "../_SAMPLES/PsytranceDrumKit1Examples/G-Sonique PsytranceDrumKit1 Examples/" => string dir;
    dir + "Clap 03.wav" => s.wav["c"];
    dir + "Clap 25.wav" => s.wav["C"];

    dir + "darbukah 13.wav" => s.wav["d"];
    dir + "darbukah 46.wav" => s.wav["e"];
    dir + "darbukah 56.wav" => s.wav["f"];
    dir + "darbukah 83.wav" => s.wav["g"];

    dir + "darbukah 03.wav" => s.wav["D"];
    dir + "darbukah 20.wav" => s.wav["E"];


    //dir + "" => s.wav[""];
    dir + "Proggy Kick 15.wav" => s.wav["k"];
    dir + "Proggy Kick 07.wav" => s.wav["l"];
    dir + "Proggy Kick 32.wav" => s.wav["m"];
    dir + "Kick 33.wav" => s.wav["n"];

    dir + "Kick 58.wav" => s.wav["K"];
    dir + "Kick 41.wav" => s.wav["L"];
    dir + "Kick 77.wav" => s.wav["M"];
    dir + "Kick 69.wav" => s.wav["N"];
    dir + "Kick 02.wav" => s.wav["O"];


    dir + "Snare 21.wav" => s.wav["s"];   
    dir + "Snare 15.wav" => s.wav["t"];   
    dir + "Snare 23.wav" => s.wav["u"];   
    dir + "Snare 04.wav" => s.wav["v"];   
    dir + "Sacral snare.wav" => s.wav["w"];   
    dir + "Sacral snare 4.wav" => s.wav["x"];   
    dir + "Sacral.wav" => s.wav["y"]   ;

    dir + "Hitek snare 31.wav" => s.wav["S"];
    dir + "Hitek snare 11.wav" => s.wav["T"];
    dir + "Hitek snare 07.wav" => s.wav["U"];
    dir + "Hitek snare 12.wav" => s.wav["V"];
    dir + "Hitek snare 15.wav" => s.wav["W"];
    dir + "Jungle snare 08.wav" => s.wav["X"];

    dir + "Closed hat 01.wav" => s.wav["h"];
    dir + "Closed hat 10.wav" => s.wav["i"];
    dir + "Closed hat 43.wav" => s.wav["j"];

    dir + "Open Hat 04.wav" => s.wav["H"];
    dir + "Open Hat 21.wav" => s.wav["I"];
    dir + "Open Hat 26.wav" => s.wav["J"];

}


SEQ s;PROG(s);  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 khk|Xh kc|hk|Xh khk|X|Ch kc|hk|Xh " => s.seq;
//"_i" => s.seq;
//"*4 D__dE_ee_dfd_ D_D_" => s.seq;
2.9 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 


while(1) {
       100::ms => now;
}
 
