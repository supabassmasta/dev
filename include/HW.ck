public class HW {
    static NANO_CONTROLER @ nano;
    static LAUNCHPAD @ launchpad;
}

NANO_CONTROLER dummy_nano @=> HW.nano;
LAUNCHPAD dummy_lp @=> HW.launchpad;

while(1) {
       100::ms => now;
}
 
