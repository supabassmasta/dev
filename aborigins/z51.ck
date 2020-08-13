NOREPLACE no;

MASTER_SEQ3.update_ref_times(now - 30*data.tick, data.tick * 16 * 128 );

LAUNCHPAD_VIRTUAL.on.set(41); // Intro 
spork ~ glitchs ();

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

2 * 32 * data.tick => now; // AUto break
        LAUNCHPAD_VIRTUAL.off.set(42); // AUto break
LAUNCHPAD_VIRTUAL.on.set(44); // Special break
2 * 32 * data.tick => now; // AUto break
        LAUNCHPAD_VIRTUAL.off.set(44); // Special break
LAUNCHPAD_VIRTUAL.on.set(42); // AUto break
2 * 32 * data.tick => now; // AUto break

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

  /// END
  LAUNCHPAD_VIRTUAL.off.set(12); // hh snr

  LAUNCHPAD_VIRTUAL.off.set(21); // BASS
  .5 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(11); // Kick

32 * data.tick => now; // AUto break

  LAUNCHPAD_VIRTUAL.off.set(42); // AUto break

while(1) {
       100::ms => now;
}
 


fun void glitchs(){ 

SYNC sy;
//sy.sync(64 * data.tick);
sy.sync(4 * data.tick , - .5 * data.tick /* offset */); 

 // Intro 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.on.set(25); 

8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(25); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.on.set(26); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(26); 
1 * 32 * data.tick => now;
<<<"!!!!!!!!!!!! SHORT DJEMBE !!!!!!!!!!!! ">>>;

1 * 32  * data.tick => now; 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.on.set(26); 

8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(26); 
//  LAUNCHPAD_VIRTUAL.on.set(25); 
8 * data.tick => now;
8 * data.tick => now;
//  LAUNCHPAD_VIRTUAL.off.set(25); 
<<<"!!!!!!!!!!!! DIDGE !!!!!!!!!!!!">>>;

2 * 32 * data.tick => now; // Trance 2

8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.on.set(26); 

8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(26); 
  LAUNCHPAD_VIRTUAL.on.set(25); 
8 * data.tick => now;
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(25); 

2 * 32 * data.tick => now; // AUto break


<<<"!!!!!!!!!!!! LONG BREAK !!!!!!!!!!!!">>>;
2 * 32 * data.tick => now; 

  LAUNCHPAD_VIRTUAL.on.set(18); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(18); 
  LAUNCHPAD_VIRTUAL.on.set(26); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(26); 
  LAUNCHPAD_VIRTUAL.on.set(18); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(18); 
  LAUNCHPAD_VIRTUAL.on.set(25); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(25); 

  LAUNCHPAD_VIRTUAL.on.set(28); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(28); 
  LAUNCHPAD_VIRTUAL.on.set(26); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(26); 
  LAUNCHPAD_VIRTUAL.on.set(38); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(38); 
  LAUNCHPAD_VIRTUAL.on.set(25); 
8 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(25); 
5 * 32 * data.tick => now; // AUto break

<<<"!!!!!!!!!!!! LONG BREAK ABOS !!!!!!!!!!!!">>>;
1 * 32 * data.tick => now; 

2 * 32 * data.tick => now; 

3 * 32 * data.tick => now; // AUto break


  /// END
32 * data.tick => now; 


 
} 

