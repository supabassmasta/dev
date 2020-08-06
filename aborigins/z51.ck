NOREPLACE no;

  LAUNCHPAD_VIRTUAL.on.set(41); // Intro 
2 * 32 * data.tick => now;
<<<"!!!!!!!!!!!! SHORT DJEMBE !!!!!!!!!!!! ">>>;


3 * 16 * data.tick => now; // Trance 1
  LAUNCHPAD_VIRTUAL.on.set(23); // Abos
1 * 16 * data.tick => now; // Trance 1
  LAUNCHPAD_VIRTUAL.off.set(23); // Abos
  LAUNCHPAD_VIRTUAL.off.set(45); // Trancy synt
<<<"!!!!!!!!!!!! DIDGE !!!!!!!!!!!!">>>;

(2 * 32 - 16 ) * data.tick => now; // Trance 2

  LAUNCHPAD_VIRTUAL.on.set(42); // AUto break

( 4 * 32 ) * data.tick => now; // AUto break

  LAUNCHPAD_VIRTUAL.off.set(42); // AUto break
<<<"!!!!!!!!!!!! LONG BREAK !!!!!!!!!!!!">>>;
  LAUNCHPAD_VIRTUAL.on.set(43); // long break
2 * 32 * data.tick => now; // AUto break
  LAUNCHPAD_VIRTUAL.off.set(43); // long break

32 * data.tick => now; // AUto break

LAUNCHPAD_VIRTUAL.on.set(42); // AUto break

6 * 32 * data.tick => now; // AUto break

  LAUNCHPAD_VIRTUAL.off.set(42); // AUto break
<<<"!!!!!!!!!!!! LONG BREAK ABOS !!!!!!!!!!!!">>>;
  LAUNCHPAD_VIRTUAL.on.set(43); // long break
1 * 32 * data.tick => now; 
//16 * data.tick => now;
  LAUNCHPAD_VIRTUAL.on.set(23); // Abos
16 * data.tick => now; 

  LAUNCHPAD_VIRTUAL.off.set(23); // Abos
16 * data.tick => now; 
  LAUNCHPAD_VIRTUAL.off.set(43); // long break

1 * 32 * data.tick => now; // AUto break
  LAUNCHPAD_VIRTUAL.on.set(42); // AUto break

4 * 32 * data.tick => now; // AUto break

