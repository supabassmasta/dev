SAVE s;
s.init(me.path());
s.savei("toto", 33);
s.savef("to", 35.1);

s.readi("toto") => int i;

<<<"result", i>>>;
s.readf("to")=> float v;
<<<v>>>;

s.saves("tata","lel dev rrfg /frefé");
<<<s.reads("tata")>>>; 
