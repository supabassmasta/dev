

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , - 4 *data.tick /* offset */); 


// INTRO
HW.launchpad.virtual_key_on_only(48);  

40 * data.tick => now; // Wait for beat
64 * data.tick => now; // beat

// BRIDGE + 1 Theme
HW.launchpad.virtual_key_on_only(38);
32 * data.tick => now; // BRIDGE
64 * data.tick => now; //Theme

// BRIDGE 2 + 2 Theme
HW.launchpad.virtual_key_on_only(37);
32 * data.tick => now; // BRIDGE
HW.launchpad.virtual_key_on_only(46); // ARP
64 * data.tick => now; //Theme
HW.launchpad.virtual_key_off_only(46); // ARP OFF
64 * data.tick => now; //Theme

// BRIDGE 3 + 2 Theme
HW.launchpad.virtual_key_on_only(36);
32 * data.tick => now; // BRIDGE
64 * data.tick => now; //Theme
HW.launchpad.virtual_key_on_only(46); // ARP ( will be shut off by chorus )
( 64   - 8  /* for Chorus break */ )  * data.tick => now; //Theme

// CHORUS
HW.launchpad.virtual_key_on_only(18);
8 * data.tick => now; // BREAK
64 * data.tick => now; //CHORUS

HW.launchpad.virtual_key_off_only(18); // Off chorus to allow re on.

// BRIDGE 4 + 2 Theme
HW.launchpad.virtual_key_on_only(28);
16 * data.tick => now; // BRIDGE
64 * data.tick => now; //Theme
( 64   - 8  /* for Chorus break */ )  * data.tick => now; //Theme

// CHORUS
HW.launchpad.virtual_key_on_only(18);
8 * data.tick => now; // BREAK
( 64 * 2   - 8  /* for END */ ) * data.tick => now; //CHORUS

// END
HW.launchpad.virtual_key_on_only(17);

//HW.launchpad.virtual_key_off_only(87); 


while(1) {
       10000::ms => now;
}
 

