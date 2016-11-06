SndBuf s;
.9 => s.gain;

// "../../Test/_SAMPLES/trance/FX/001 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/002 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/003 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/004 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/005 FX Loops 145-BPM.wav" => s.read;
 "../../../tmp/string.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/007 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/008 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/009 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/010 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/011 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/012 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/013 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/014 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/015 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/016 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/017 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/018 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/019 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/020 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/021 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/022 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/023 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/024 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/025 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/026 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/027 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/028 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/029 FX Loops 145-BPM.wav" => s.read;
// "../../Test/_SAMPLES/trance/FX/030 FX Loops 145-BPM.wav" => s.read;



s => dac;

s.length() => now;
