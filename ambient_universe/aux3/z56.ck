SAVE s;
"fname" => string fname;
//s.init(me.path());
"." => s.dir;
s.readi("fname") => int i;
 i + 1 => i;
s.savei("fname", i);


<<<"saved", i>>>;
1::ms => now;
