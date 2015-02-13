SAVE s;
s.init(me.path());
//s.save("toto", 33);
s.save("to", 35.1);

s.read("toto") => int i;

<<<"result", i>>>;
s.read_float("to")=> float v;
<<<v>>>;
