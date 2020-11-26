 data.bpm + 1 => data.bpm;   (60.0/data.bpm)::second => data.tick;
<<<"BPM UP : ", data.bpm>>>;
MASTER_SEQ3.update_durations(64 * data.tick, 64);
1::ms => now;

