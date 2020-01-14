<<<"Hi,
Welcome to the IBNIZ chugin demo!
Please visit original IBNIZ program website:
http://pelulamu.net/ibniz/\n
To know how to use IBNIZ please read ibniz.txt\n
This is a temptative to integrate IBNIZ in a Chuck chugin, there is only sound and it probably doesn't work exaclty the same way as the original program.">>>;

2::second => now;

<<<"\nLet's start with the more simple example: empty code">>>;

ibniz I => dac;
.2 => I.gain;

<<<"It is like a 60 MHz SawOsc ">>>;
3::second => now;

<<<"\nNow adding code">>>;
"dd*&11a" => I.code;
.4 => I.gain;

6::second => now;

<<<"You can also pause (.off()) and restart (.on()) like F1 key in original program">>>;
I.off();
1::second => now;
I.on();
1::second => now;

<<<"or reset (.reset()) like F2 key ">>>;
I.reset();
500::ms=>now;
I.reset();
500::ms=>now;
I.reset();
2000::ms=>now;

<<<"\n\nNow an additional feature: frequency control with input signal.
if there is no input or input value is 0 or 60, IBNIZ runs at its original frequency.
Else IBNIZ runs with a factor (input/60) so it will modify the frequency of sound.\n
!!!WARNING: Be careful, Higher frequency will make IBNIZ run faster so CPU usage will increase proportionnally!!!">>>;

Step freq => I;
120 => freq.next;
I.reset();

6::second => now;
