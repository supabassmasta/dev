
fun static void _Dirt_samples_amencutup ( SEQ @ s) {
	"../_SAMPLES/Dirt_samples/amencutup/"  => string dir;

	dir + "009_AMENCUT_010.wav" => s.wav["a"];
	dir + "006_AMENCUT_007.wav" => s.wav["b"];
	dir + "005_AMENCUT_006.wav" => s.wav["c"];
	dir + "022_AMENCUT_023.wav" => s.wav["d"];
	dir + "021_AMENCUT_022.wav" => s.wav["e"];
	dir + "025_AMENCUT_026.wav" => s.wav["f"];
	dir + "008_AMENCUT_009.wav" => s.wav["g"];
	dir + "000_AMENCUT_001.wav" => s.wav["h"];
	dir + "013_AMENCUT_014.wav" => s.wav["i"];
	dir + "003_AMENCUT_004.wav" => s.wav["j"];
	dir + "010_AMENCUT_011.wav" => s.wav["k"];
	dir + "001_AMENCUT_002.wav" => s.wav["l"];
	dir + "017_AMENCUT_018.wav" => s.wav["m"];
	dir + "019_AMENCUT_020.wav" => s.wav["n"];
	dir + "016_AMENCUT_017.wav" => s.wav["o"];
	dir + "014_AMENCUT_015.wav" => s.wav["p"];
	dir + "029_AMENCUT_030.wav" => s.wav["q"];
	dir + "027_AMENCUT_028.wav" => s.wav["r"];
	dir + "020_AMENCUT_021.wav" => s.wav["s"];
	dir + "007_AMENCUT_008.wav" => s.wav["t"];
	dir + "015_AMENCUT_016.wav" => s.wav["u"];
	dir + "031_AMENCUT_032.wav" => s.wav["v"];
	dir + "028_AMENCUT_029.wav" => s.wav["w"];
	dir + "023_AMENCUT_024.wav" => s.wav["x"];
	dir + "024_AMENCUT_025.wav" => s.wav["y"];
	dir + "012_AMENCUT_013.wav" => s.wav["z"];
	dir + "018_AMENCUT_019.wav" => s.wav["A"];
	dir + "030_AMENCUT_031.wav" => s.wav["B"];
	dir + "004_AMENCUT_005.wav" => s.wav["C"];
	dir + "026_AMENCUT_027.wav" => s.wav["D"];
	dir + "002_AMENCUT_003.wav" => s.wav["E"];
	dir + "011_AMENCUT_012.wav" => s.wav["F"];

}
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
_Dirt_samples_amencutup(s);
"abcdefghijklmnopq" => s.seq;
 s.element_sync(); //s.no_sync(); s.full_sync();     //s.print();
// s.mono() => dac; s.left() => dac.left; s.right() => dac.right;
s.go(); 

while(1) {
	     100::ms => now;
}
 
