
SerialIO.list() @=> string list[];

for(int i; i < list.cap(); i++)
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}

0 => int device;
if(me.args()) me.arg(0) => Std.atoi => device;

SerialIO cereal;
cereal.open(device, SerialIO.B115200, SerialIO.BINARY);

fun void f1 (){ 
  while(true)
  {
    cereal.onByte() => now;
    cereal.getByte() => int byte;
    chout <= "byte: " <= byte <= IO.newline();
//<<<byte>>>;

  }

} 
spork ~ f1 ();

//['H', 'i', '!',  'H', 'i', '!', '!', '\n'] @=> int bytes[];
 int bytes[0];
0 => int cksum;
for (0 => int i; i <  255     ; i++) {
  bytes << i;
  i +=> cksum;
}
<<<"cksum", cksum>>>;



while(true)
{
  
    cereal.writeBytes(bytes);

    50::ms => now;

}

    

1::ms => now;
