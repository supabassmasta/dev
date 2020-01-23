public class LAUNCHPAD_VIRTUAL {
  static CONTROLER @ on;
  static CONTROLER @ off;
  static CONTROLER @ toggle;
  static CONTROLER @ kill_page;
}

new CONTROLER @=> LAUNCHPAD_VIRTUAL.on;
new CONTROLER @=> LAUNCHPAD_VIRTUAL.off;
new CONTROLER @=> LAUNCHPAD_VIRTUAL.toggle;
new CONTROLER @=> LAUNCHPAD_VIRTUAL.kill_page;

while(1) 100000::ms => now;

