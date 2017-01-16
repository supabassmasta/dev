SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); 
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"s_" => s.seq;
.9 => s.gain; // s.gain("s", .2); // for single wav 
// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

//NANO_CONTROLER nano;
STRESC resc;
resc.connect(s $ ST , HW.nano.potar[1][1] /* freq */  , HW.nano.fader[1][1] /* Q */  );  

HW.nano.potar[1][1].set(100);
HW.nano.fader[1][1].set(41);

4 * data.tick => now;

HW.nano.potar[1][1].set(80);

4 * data.tick => now;

HW.nano.potar[1][1].set(60);

4 * data.tick => now;

HW.nano.potar[1][1].set(40);

4 * data.tick => now;



while(1) {
       100::ms => now;
}
 
