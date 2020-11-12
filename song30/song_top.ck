Machine.add("rootpath.ck");
me.yield();

// CHANGE ALSO ROOT PATH HERE
Machine.add("../include/include.ck");
me.yield();

Machine.add( "launch.ck" );
//<<<data.bpm>>>;
//Machine.add( "test.ck" );
//Machine.add( "super_seq_top.ck" );

1::ms => now;
Machine.add("parallel_sync_receive.ck");

500::ms => now;

Machine.add("parallel_sync_send.ck");

while (1) 100000::ms=>now;
