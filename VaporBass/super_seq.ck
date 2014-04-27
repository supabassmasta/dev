<<<"sup",now/1::second>>>;
0 => int i;
seq_script s[12];

// s0.ck vap_loop
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0.  ;
i++;
// S1.ck BASS 1
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0. ;
i++;

// s2.ck CHORD                                                                          
"./s" + i + ".ck" => s[i].read;
s[i].g      << 0. ;
i++;
// s3.ck BEAT HIP HOP
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0. ;
i++;
 // s4: 2nd Bass -1 octave
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0. ;
i++;

// s5.ck string
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0. << 0. << 0. << 0.;
i++;


"./s" + i + ".ck" => s[i].read;
s[i].g       << 0. ;
i++;

// s7
"./s" + i + ".ck" => s[i].read;
s[i].g       << 0. ;
i++;


for (0 => int j; j < i; j++) {
   data.bpm/data.meas_size => s[j].bpm;
	 0=>s[j].sync_on;
   s[j].go();
}


2 * data.meas_size * data.tick => now;

//<<<"sup2",now/1::second>>>;
data.super_seq_reset_ev.broadcast();
