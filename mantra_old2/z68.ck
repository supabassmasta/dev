SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

HW.launchpad.virtual_key_on(41); // Kick
8 * data.tick => now;

HW.launchpad.virtual_key_on(43); // HH
8 * data.tick => now;

HW.launchpad.virtual_key_on(44); // Snare
12 * data.tick => now;

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(58); // BK kick 1
2 * data.tick => now;
HW.launchpad.virtual_key_on(56); // BK glitch 1
2 * data.tick => now;
HW.launchpad.virtual_key_on(56); // BK glitch 1
HW.launchpad.virtual_key_on(58); // BK kick 1

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(45); // BASS 1

/////////////////////////



(1 * 16 + 12) * data.tick => now;

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(45); // BASS 1
HW.launchpad.virtual_key_on(58); // BK kick 1
2 * data.tick => now;
HW.launchpad.virtual_key_on(55); // BK glitch 2
2 * data.tick => now;
HW.launchpad.virtual_key_on(55); // BK glitch 2
HW.launchpad.virtual_key_on(58); // BK kick 1

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(45); // BASS 1

(1 * 16 + 12) * data.tick => now;

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(45); // BASS 1
HW.launchpad.virtual_key_on(57); // BK kick 2
2 * data.tick => now;
HW.launchpad.virtual_key_on(56); // BK glitch 2
2 * data.tick => now;
HW.launchpad.virtual_key_on(56); // BK glitch 2
HW.launchpad.virtual_key_on(57); // BK kick 2

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(45); // BASS 1


(1 * 16 + 12) * data.tick => now;


////////////////////////


//(5 * 16 + 12) * data.tick => now;

//16 * data.tick => now; // For Test
//
//-------------------------------------------------------

// BREAK Silence
HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(45); // BASS 1


3 * data.tick => now;

HW.launchpad.virtual_key_on(58); // BK kick 1
1 * data.tick => now;
HW.launchpad.virtual_key_on(58); // BK kick 1

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(48); // BASS 2


(3 * 16 + 12 ) * data.tick => now;

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(48); // BASS 2




HW.launchpad.virtual_key_on(57); // BK kick 2
2 * data.tick => now;
HW.launchpad.virtual_key_on(56); // BK glitch 2
2 * data.tick => now;
HW.launchpad.virtual_key_on(56); // BK glitch 2
HW.launchpad.virtual_key_on(57); // BK kick 2






HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(48); // BASS 2



(1 * 16 + 6) * data.tick => now;

//-------------------------------------------------------

//(5 * 16 + 6) * data.tick => now;



//16 * data.tick => now; // For Test

// BREAK Silence
HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(48); // BASS 2
20 * data.tick => now;
HW.launchpad.virtual_key_on(57); // BK kick 2
2 * data.tick => now;
HW.launchpad.virtual_key_on(57); // BK kick 2

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(48); // BASS 2

(4 * 16 ) * data.tick => now;

HW.launchpad.virtual_key_on(41); // Kick
HW.launchpad.virtual_key_on(43); // HH
HW.launchpad.virtual_key_on(44); // Snare
HW.launchpad.virtual_key_on(48); // BASS 2

2 * data.tick => now;

