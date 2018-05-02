// TEST

HW.launchpad.virtual_key_on(31);
HW.launchpad.virtual_key_on(32);
HW.launchpad.virtual_key_on(33);
HW.launchpad.virtual_key_on(34);

16 * data.tick => now;

HW.launchpad.virtual_key_on(31);
HW.launchpad.virtual_key_on(32);
HW.launchpad.virtual_key_on(33);
HW.launchpad.virtual_key_on(34);

HW.launchpad.virtual_key_on(71);
HW.launchpad.virtual_key_on(72);
HW.launchpad.virtual_key_on(73);
HW.launchpad.virtual_key_on(81);

16 * data.tick => now;
HW.launchpad.virtual_key_on(81);
HW.launchpad.virtual_key_on(82);
16 * data.tick => now;

HW.launchpad.virtual_key_on(71);
HW.launchpad.virtual_key_on(72);
HW.launchpad.virtual_key_on(73);
HW.launchpad.virtual_key_on(81);

HW.launchpad.virtual_key_on(82);
1 * data.tick => now;
