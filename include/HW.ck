public class HW {
    static NANO_CONTROLER @ nano;
    static LAUNCHPAD @ launchpad;
    static LPD8_CONTROLLER @ lpd8;
    static KBCONTROLLER @ kb;
}

NANO_CONTROLER dummy_nano @=> HW.nano;
LAUNCHPAD dummy_lp @=> HW.launchpad;
LPD8_CONTROLLER dummy_lpd8 @=> HW.lpd8;
KBCONTROLLER dummy_kb @=> HW.kb;

while(1) {
       100::ms => now;
}
 
