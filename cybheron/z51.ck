<<<" EFFECT LINE z5* ">>>;
<<<" STMIX line 1 & 2">>>;


fun void EFFECT1   (){ 
  STMIX stmix;
  stmix.receive( 1); stmix $ ST @=> ST @ last; 
STECHOONLY ech;
ech.connect(last $ ST , data.tick * 2 / 4 + 5::ms , .7);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 2 / 3 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STMIX stmix2;
  stmix2.send(last, 2);

  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT1();

fun void EFFECT2   (){ 
  STMIX stmix;
  stmix.receive( 2); stmix $ ST @=> ST @ last; 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 119/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .05 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  


  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT2();





while(1) {
       100::ms => now;
}
 
