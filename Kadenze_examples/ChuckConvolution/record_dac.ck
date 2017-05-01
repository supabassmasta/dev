// chuck this with other shreds to record to file
// example> chuck foo.ck bar.ck rec (see also rec2.ck)

// pull samples from the dac
// WvOut2 -> stereo operation
dac => WvOut2 w => blackhole;

// this is the output file name
"convolved_file" => w.wavFilename;

// print it out
<<<"writing to file: ", w.filename()>>>;

// any gain you want for the output
.9 => w.fileGain;

// temporary workaround to automatically close file on remove-shred
null @=> w;

// infinite time loop...
// ctrl-c will stop it, or modify to desired duration
while( true ) 1::second => now;
