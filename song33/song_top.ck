Machine.add("rootpath.ck");
me.yield();

// CHANGE ALSO ROOT PATH HERE
Machine.add("../include/include.ck");
me.yield();

Machine.add( "launch.ck" );
//<<<data.bpm>>>;
//Machine.add( "test.ck" );
//Machine.add( "super_seq_top.ck" );

while (1) 100000::ms=>now;
