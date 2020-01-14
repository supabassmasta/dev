ST st;


// Disciated channel Stereo rev
global_mixer.rev2_right => GVerb gverb0  => st.outr;
50 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
5::second => gverb0.revtime;   // revtime: (dur), default 5::second
0.0 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.4 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
0.5 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5       
 
global_mixer.rev2_left => GVerb gverb1  => st.outl;
50 => gverb1.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
5::second => gverb1.revtime;   // revtime: (dur), default 5::second
0.0 => gverb1.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.4 => gverb1.early;           // early (float) [0.0 - 1.0], default 0.4
0.5 => gverb1.tail;            // tail (float) [0.0 - 1.0], default 0.5       

STDUCK duck;
duck.connect(st); 
 
while(1) {
	     100::ms => now;
}
 
