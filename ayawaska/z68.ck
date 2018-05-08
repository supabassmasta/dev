SndBuf2 buf;
buf.chan(0) => dac.right;
buf.chan(1) => dac.left;
"test.wav" =>buf.read;

buf.length() => now;
