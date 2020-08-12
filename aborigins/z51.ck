NOREPLACE no;

  LAUNCHPAD_VIRTUAL.on.set(41); // Intro 
2 * 32 * data.tick => now;
<<<"!!!!!!!!!!!! SHORT DJEMBE !!!!!!!!!!!! ">>>;

1 * 32  * data.tick => now; 
  LAUNCHPAD_VIRTUAL.on.set(24); // Abos
        LAUNCHPAD_VIRTUAL.off.set(45); // Trancy synt
1 * 32  * data.tick => now; 
<<<"!!!!!!!!!!!! DIDGE !!!!!!!!!!!!">>>;

1 * 32 * data.tick => now; // Trance 2
        LAUNCHPAD_VIRTUAL.off.set(24); // Abos

  LAUNCHPAD_VIRTUAL.on.set(42); // AUto break

4 * 32 * data.tick => now; // AUto break

        LAUNCHPAD_VIRTUAL.off.set(42); // AUto break

<<<"!!!!!!!!!!!! LONG BREAK !!!!!!!!!!!!">>>;
  LAUNCHPAD_VIRTUAL.on.set(43); // long break
3 * 32 * data.tick => now; 

        LAUNCHPAD_VIRTUAL.off.set(43); // long break
LAUNCHPAD_VIRTUAL.on.set(42); // AUto break

6 * 32 * data.tick => now; // AUto break

        LAUNCHPAD_VIRTUAL.off.set(42); // AUto break
<<<"!!!!!!!!!!!! LONG BREAK ABOS !!!!!!!!!!!!">>>;
  LAUNCHPAD_VIRTUAL.on.set(43); // long break
1 * 32 * data.tick => now; 
  LAUNCHPAD_VIRTUAL.on.set(24); // Abos

2 * 32 * data.tick => now; 
      LAUNCHPAD_VIRTUAL.off.set(24); // Abos
      LAUNCHPAD_VIRTUAL.off.set(43); // long break
  LAUNCHPAD_VIRTUAL.on.set(42); // AUto break

3 * 32 * data.tick => now; // AUto break

SYNC sy;
sy.sync(32 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 
  LAUNCHPAD_VIRTUAL.off.set(42); // AUto break

  /// END
  LAUNCHPAD_VIRTUAL.off.set(12); // hh snr

  LAUNCHPAD_VIRTUAL.off.set(21); // BASS
  .5 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(11); // Kick

32 * data.tick => now; // AUto break


