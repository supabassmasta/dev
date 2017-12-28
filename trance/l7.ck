
fun void TRANCE_VARIOUS ( SEQ @ s) {
  "../_SAMPLES/PsytranceDrumKit1Examples/G-Sonique PsytranceDrumKit1 Examples/" => string dir;
 
    dir + "Acid.wav" => s.wav["a"];
    dir + "Android 1.wav" => s.wav["b"];
    dir + "Ayahuasskkah 1.wav" => s.wav["c"];
    dir + "Aztec 2.wav" => s.wav["d"];
    dir + "Aztek 2.wav" => s.wav["e"];
    dir + "Aztek.wav" => s.wav["f"];
    dir + "Bass 09.wav" => s.wav["g"];
    dir + "Blip 03.wav" => s.wav["h"];
    dir + "darbukah 03.wav" => s.wav["i"];
    dir + "darbukah 13.wav" => s.wav["j"];
    dir + "darbukah 20.wav" => s.wav["k"];
    dir + "darbukah 46.wav" => s.wav["l"];
    dir + "darbukah 56.wav" => s.wav["m"];
    dir + "darbukah 83.wav" => s.wav["n"];
    dir + "Dark 01.wav" => s.wav["o"];
    dir + "Dark 11.wav" => s.wav["p"];
    dir + "Dark 17.wav" => s.wav["q"];
    dir + "Electro snare 6.wav" => s.wav["r"];
    dir + "Fullon hit 07.wav" => s.wav["s"];
    dir + "Fullon hit 33.wav" => s.wav["t"];
    dir + "FX Clap 11.wav" => s.wav["u"];
    dir + "FX Clap 12.wav" => s.wav["v"];
    dir + "Hammer 01.wav" => s.wav["w"];
    dir + "Hammer 04.wav" => s.wav["x"];
    dir + "Hammer 20.wav" => s.wav["y"];
    dir + "Hammer 42.wav" => s.wav["z"];
    dir + "Hit 06.wav" => s.wav["A"];
    dir + "Hit 07.wav" => s.wav["B"];
    dir + "Hit 12.wav" => s.wav["C"];
    dir + "Hit 16.wav" => s.wav["D"];
    dir + "Hit 22.wav" => s.wav["E"];
    dir + "Laser 01.wav" => s.wav["F"];
    dir + "Metalic clap 6.wav" => s.wav["G"];
    dir + "Peyoetlah 5.wav" => s.wav["H"];
    dir + "Proggy bong 6.wav" => s.wav["I"];
    dir + "Proggy clap 01.wav" => s.wav["J"];
    dir + "Proggy clap 08.wav" => s.wav["K"];
    dir + "Proggy conga 29.wav" => s.wav["L"];
    dir + "Proggy wood 02.wav" => s.wav["M"];
    dir + "Proggy wood 12.wav" => s.wav["N"];
    dir + "Proggy wood 21.wav" => s.wav["O"];
           
           
  dir + "BoZolodh 3.wav" => s.wav["P"];
  dir + "BoElectroindustrial click.wavng 13.wav" => s.wav["Q"];
  dir + "Bong 29.wav" => s.wav["R"];
  dir + "Bong 51.wav" => s.wav["S"];
  dir + "Bong 61.wav" => s.wav["T"];
  dir + "darbukah 13.wav" => s.wav["U"];
  dir + "darbukah 56.wav" => s.wav["V"];
  dir + "darbukah 83.wav" => s.wav["W"];
  dir + "darbukah 46.wav" => s.wav["X"];
  dir + "Sacral.wav" => s.wav["Y"];
  dir + "Sacral snare 4.wav" => s.wav["Z"];

}


SEQ s;TRANCE_VARIOUS(s);  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 _g " => s.seq;
//"_i" => s.seq;
//"*4 D__dE_ee_dfd_ D_D_" => s.seq;
1.9 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 


while(1) {
       100::ms => now;
}
 
