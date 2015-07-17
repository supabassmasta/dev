SEQ s;

SET_WAV.DUBSTEP(s);
s.element_sync();
//data.tick * 8 => s.max;
"*4p___s_p_ _?pp_sp__ p_p?ps__p  p?p?pps__?s " => s.seq;
//":2k))))f(((((dks_*2kk:2s*2__------))H__((((j)))j " => s.seq;

SEQ s2;
SET_WAV.DUBSTEP(s2);
s2.element_sync();
"*4 __++(5j_ ++)5i(5j_++)5h " => s2.seq;

SEQ s3;
SET_WAV.DUBSTEP(s3);
s3.element_sync();
"*4 ____ _{1-----(5R_)5R __---(3L_ ---(5H___" => s3.seq;
"____ ____ __)3L_ )5JJ__" => s3.seq;

SEQ s4;
SET_WAV.DUBSTEP(s4);
s4.element_sync();
"*4 _---((w_((((w __))w))))w _(((w_))))w __((((((w_    _))))ww_ _(((((w__ _)))))w_(((((w _)))w_(((((w" => s4.seq;
//"*4_---w" => s4.seq;

s4.go();
s3.go();
s2.go();



s.go();

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
//SEQ s2;
//SET_WAV.DUBSTEP(s2);
//s2.element_sync();
//"" => s2.seq;

//s2.go();
