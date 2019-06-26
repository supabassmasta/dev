 data.bpm + 1 => data.bpm;   (60.0/data.bpm)::second => data.tick;
<<<"BPM UP : ", data.bpm>>>;
MASTER_SEQ3.update_durations(16 * data.tick, 16);
1::ms => now;

