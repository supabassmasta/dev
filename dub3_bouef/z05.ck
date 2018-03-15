MidiOut mout;
mout.open(3);
<<< "MIDI device:", mout.num(), " -> ", mout.name() >>>;

60000::ms / (115. *  24.) => dur period;

    MidiMsg msg;
    252 => msg.data1;
    9 => msg.data2;
    0 => msg.data3;
    mout.send(msg);

    242 => msg.data1;
    0 => msg.data2;
    0 => msg.data3;
    mout.send(msg);
    
    250 => msg.data1;
    9 => msg.data2;
    0 => msg.data3;
    mout.send(msg);
time n;
    248 => msg.data1;
    9 => msg.data2;
    0 => msg.data3;
while(true)
{
    now => n;
    spork ~ mout.send(msg);
    
    n + period => now;
    
//    176 => msg.data1;
//    123 => msg.data2;
//    0 => msg.data3;
//    mout.send(msg);
//    
//    1::second => now;
}

