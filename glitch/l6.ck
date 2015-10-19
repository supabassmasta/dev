SEQ s;
SET_WAV.DUBSTEP(s);
s.element_sync();
//data.tick * 8 => s.max;
"*1 ++++k_++s_ " => s.seq;
//"(9f)9d" => s.seq;
s.go();
//s.left() => NRev rev =>   dac.left;
//s.right() => NRev rev2 =>  dac.right;
//.1=> rev.mix;
//.1=> rev2.mix;
while(1) {  100::ms => now; }
