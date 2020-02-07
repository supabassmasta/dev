MidiOut mout;
mout.open(0);

0 => int i;

while(true)
{
  MidiMsg msg;

  0x90 => msg.data1;
  60 => msg.data2;
  i => msg.data3;
  mout.send(msg);
  1+=> i;
  if ( i >127  ){ 
    0=> i;
  }
  3::samp => now;
    
}
