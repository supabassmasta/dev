<<<"sup",now/1::second>>>;
0 => int i;
seq_script s[12];

// s0.ck vap_loop
"./s" + i + ".ck" => s[i].read;
s[i].g       << 1.  << 0. ;
i++;


for (0 => int j; j < i; j++) {
   data.bpm/data.meas_size => s[j].bpm;
	 0=>s[j].sync_on;
   s[j].go();
}


2 * data.meas_size * data.tick => now;

//<<<"sup2",now/1::second>>>;
data.super_seq_reset_ev.broadcast();
