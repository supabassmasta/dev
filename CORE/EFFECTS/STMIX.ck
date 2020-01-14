
public class STMIX extends ST{
  static Gain @ stl0;
  static Gain @ str0;
  static Gain @ stl1;
  static Gain @ str1;
  static Gain @ stl2;
  static Gain @ str2;
  static Gain @ stl3;
  static Gain @ str3;
  static Gain @ stl4;
  static Gain @ str4;
  static Gain @ stl5;
  static Gain @ str5;
  static Gain @ stl6;
  static Gain @ str6;
  static Gain @ stl7;
  static Gain @ str7;
  static Gain @ stl8;
  static Gain @ str8;
  static Gain @ stl9;
  static Gain @ str9;
  static Gain @ stl10;
  static Gain @ str10;
  static Gain @ stl11;
  static Gain @ str11;
  static Gain @ stl12;
  static Gain @ str12;
  static Gain @ stl13;
  static Gain @ str13;
  static Gain @ stl14;
  static Gain @ str14;
  static Gain @ stl15;
  static Gain @ str15;
  static Gain @ stl16;
  static Gain @ str16;
  static Gain @ stl17;
  static Gain @ str17;
  static Gain @ stl18;
  static Gain @ str18;
  static Gain @ stl19;
  static Gain @ str19;
  static Gain @ stl20;
  static Gain @ str20;
  static Gain @ stl21;
  static Gain @ str21;
  static Gain @ stl22;
  static Gain @ str22;
  static Gain @ stl23;
  static Gain @ str23;
  static Gain @ stl24;
  static Gain @ str24;
  static Gain @ stl25;
  static Gain @ str25;
  static Gain @ stl26;
  static Gain @ str26;
  static Gain @ stl27;
  static Gain @ str27;
  static Gain @ stl28;
  static Gain @ str28;
  static Gain @ stl29;
  static Gain @ str29;
  static Gain @ stl30;
  static Gain @ str30;
  static Gain @ stl31;
  static Gain @ str31;
  static Gain @ stl32;
  static Gain @ str32;
  static Gain @ stl33;
  static Gain @ str33;
  static Gain @ stl34;
  static Gain @ str34;
  static Gain @ stl35;
  static Gain @ str35;
  static Gain @ stl36;
  static Gain @ str36;
  static Gain @ stl37;
  static Gain @ str37;
  static Gain @ stl38;
  static Gain @ str38;
  static Gain @ stl39;
  static Gain @ str39;
  static Gain @ stl40;
  static Gain @ str40;
  static Gain @ stl41;
  static Gain @ str41;
  static Gain @ stl42;
  static Gain @ str42;
  static Gain @ stl43;
  static Gain @ str43;
  static Gain @ stl44;
  static Gain @ str44;
  static Gain @ stl45;
  static Gain @ str45;
  static Gain @ stl46;
  static Gain @ str46;
  static Gain @ stl47;
  static Gain @ str47;
  static Gain @ stl48;
  static Gain @ str48;
  static Gain @ stl49;
  static Gain @ str49;
  static Gain @ stl50;
  static Gain @ str50;
  static Gain @ stl51;
  static Gain @ str51;
  static Gain @ stl52;
  static Gain @ str52;
  static Gain @ stl53;
  static Gain @ str53;
  static Gain @ stl54;
  static Gain @ str54;
  static Gain @ stl55;
  static Gain @ str55;
  static Gain @ stl56;
  static Gain @ str56;
  static Gain @ stl57;
  static Gain @ str57;
  static Gain @ stl58;
  static Gain @ str58;
  static Gain @ stl59;
  static Gain @ str59;
  static Gain @ stl60;
  static Gain @ str60;
  static Gain @ stl61;
  static Gain @ str61;
  static Gain @ stl62;
  static Gain @ str62;
  static Gain @ stl63;
  static Gain @ str63;
  static Gain @ stl64;
  static Gain @ str64;
  static Gain @ stl65;
  static Gain @ str65;
  static Gain @ stl66;
  static Gain @ str66;
  static Gain @ stl67;
  static Gain @ str67;
  static Gain @ stl68;
  static Gain @ str68;
  static Gain @ stl69;
  static Gain @ str69;
  static Gain @ stl70;
  static Gain @ str70;
  static Gain @ stl71;
  static Gain @ str71;
  static Gain @ stl72;
  static Gain @ str72;
  static Gain @ stl73;
  static Gain @ str73;
  static Gain @ stl74;
  static Gain @ str74;
  static Gain @ stl75;
  static Gain @ str75;
  static Gain @ stl76;
  static Gain @ str76;
  static Gain @ stl77;
  static Gain @ str77;
  static Gain @ stl78;
  static Gain @ str78;
  static Gain @ stl79;
  static Gain @ str79;
  static Gain @ stl80;
  static Gain @ str80;
  static Gain @ stl81;
  static Gain @ str81;
  static Gain @ stl82;
  static Gain @ str82;
  static Gain @ stl83;
  static Gain @ str83;
  static Gain @ stl84;
  static Gain @ str84;
  static Gain @ stl85;
  static Gain @ str85;
  static Gain @ stl86;
  static Gain @ str86;
  static Gain @ stl87;
  static Gain @ str87;
  static Gain @ stl88;
  static Gain @ str88;



//  static Gain @ stl_test;
//  static Gain @ str_test;

  fun void send(ST @ tone, int line) {
    if ( line < 89  ){
      if (line == 0) {
        tone.left() => stl0;
        tone.right() => str0;
      } else if (line == 1) {
        tone.left() => stl1;
        tone.right() => str1;
      } else if (line == 2) {
        tone.left() => stl2;
        tone.right() => str2;
      } else if (line == 3) {
        tone.left() => stl3;
        tone.right() => str3;
      } else if (line == 4) {
        tone.left() => stl4;
        tone.right() => str4;
      } else if (line == 5) {
        tone.left() => stl5;
        tone.right() => str5;
      } else if (line == 6) {
        tone.left() => stl6;
        tone.right() => str6;
      } else if (line == 7) {
        tone.left() => stl7;
        tone.right() => str7;
      } else if (line == 8) {
        tone.left() => stl8;
        tone.right() => str8;
      } else if (line == 9) {
        tone.left() => stl9;
        tone.right() => str9;
      } else if (line == 10) {
        tone.left() => stl10;
        tone.right() => str10;
      } else if (line == 11) {
        tone.left() => stl11;
        tone.right() => str11;
      } else if (line == 12) {
        tone.left() => stl12;
        tone.right() => str12;
      } else if (line == 13) {
        tone.left() => stl13;
        tone.right() => str13;
      } else if (line == 14) {
        tone.left() => stl14;
        tone.right() => str14;
      } else if (line == 15) {
        tone.left() => stl15;
        tone.right() => str15;
      } else if (line == 16) {
        tone.left() => stl16;
        tone.right() => str16;
      } else if (line == 17) {
        tone.left() => stl17;
        tone.right() => str17;
      } else if (line == 18) {
        tone.left() => stl18;
        tone.right() => str18;
      } else if (line == 19) {
        tone.left() => stl19;
        tone.right() => str19;
      } else if (line == 20) {
        tone.left() => stl20;
        tone.right() => str20;
      } else if (line == 21) {
        tone.left() => stl21;
        tone.right() => str21;
      } else if (line == 22) {
        tone.left() => stl22;
        tone.right() => str22;
      } else if (line == 23) {
        tone.left() => stl23;
        tone.right() => str23;
      } else if (line == 24) {
        tone.left() => stl24;
        tone.right() => str24;
      } else if (line == 25) {
        tone.left() => stl25;
        tone.right() => str25;
      } else if (line == 26) {
        tone.left() => stl26;
        tone.right() => str26;
      } else if (line == 27) {
        tone.left() => stl27;
        tone.right() => str27;
      } else if (line == 28) {
        tone.left() => stl28;
        tone.right() => str28;
      } else if (line == 29) {
        tone.left() => stl29;
        tone.right() => str29;
      } else if (line == 30) {
        tone.left() => stl30;
        tone.right() => str30;
      } else if (line == 31) {
        tone.left() => stl31;
        tone.right() => str31;
      } else if (line == 32) {
        tone.left() => stl32;
        tone.right() => str32;
      } else if (line == 33) {
        tone.left() => stl33;
        tone.right() => str33;
      } else if (line == 34) {
        tone.left() => stl34;
        tone.right() => str34;
      } else if (line == 35) {
        tone.left() => stl35;
        tone.right() => str35;
      } else if (line == 36) {
        tone.left() => stl36;
        tone.right() => str36;
      } else if (line == 37) {
        tone.left() => stl37;
        tone.right() => str37;
      } else if (line == 38) {
        tone.left() => stl38;
        tone.right() => str38;
      } else if (line == 39) {
        tone.left() => stl39;
        tone.right() => str39;
      } else if (line == 40) {
        tone.left() => stl40;
        tone.right() => str40;
      } else if (line == 41) {
        tone.left() => stl41;
        tone.right() => str41;
      } else if (line == 42) {
        tone.left() => stl42;
        tone.right() => str42;
      } else if (line == 43) {
        tone.left() => stl43;
        tone.right() => str43;
      } else if (line == 44) {
        tone.left() => stl44;
        tone.right() => str44;
      } else if (line == 45) {
        tone.left() => stl45;
        tone.right() => str45;
      } else if (line == 46) {
        tone.left() => stl46;
        tone.right() => str46;
      } else if (line == 47) {
        tone.left() => stl47;
        tone.right() => str47;
      } else if (line == 48) {
        tone.left() => stl48;
        tone.right() => str48;
      } else if (line == 49) {
        tone.left() => stl49;
        tone.right() => str49;
      } else if (line == 50) {
        tone.left() => stl50;
        tone.right() => str50;
      } else if (line == 51) {
        tone.left() => stl51;
        tone.right() => str51;
      } else if (line == 52) {
        tone.left() => stl52;
        tone.right() => str52;
      } else if (line == 53) {
        tone.left() => stl53;
        tone.right() => str53;
      } else if (line == 54) {
        tone.left() => stl54;
        tone.right() => str54;
      } else if (line == 55) {
        tone.left() => stl55;
        tone.right() => str55;
      } else if (line == 56) {
        tone.left() => stl56;
        tone.right() => str56;
      } else if (line == 57) {
        tone.left() => stl57;
        tone.right() => str57;
      } else if (line == 58) {
        tone.left() => stl58;
        tone.right() => str58;
      } else if (line == 59) {
        tone.left() => stl59;
        tone.right() => str59;
      } else if (line == 60) {
        tone.left() => stl60;
        tone.right() => str60;
      } else if (line == 61) {
        tone.left() => stl61;
        tone.right() => str61;
      } else if (line == 62) {
        tone.left() => stl62;
        tone.right() => str62;
      } else if (line == 63) {
        tone.left() => stl63;
        tone.right() => str63;
      } else if (line == 64) {
        tone.left() => stl64;
        tone.right() => str64;
      } else if (line == 65) {
        tone.left() => stl65;
        tone.right() => str65;
      } else if (line == 66) {
        tone.left() => stl66;
        tone.right() => str66;
      } else if (line == 67) {
        tone.left() => stl67;
        tone.right() => str67;
      } else if (line == 68) {
        tone.left() => stl68;
        tone.right() => str68;
      } else if (line == 69) {
        tone.left() => stl69;
        tone.right() => str69;
      } else if (line == 70) {
        tone.left() => stl70;
        tone.right() => str70;
      } else if (line == 71) {
        tone.left() => stl71;
        tone.right() => str71;
      } else if (line == 72) {
        tone.left() => stl72;
        tone.right() => str72;
      } else if (line == 73) {
        tone.left() => stl73;
        tone.right() => str73;
      } else if (line == 74) {
        tone.left() => stl74;
        tone.right() => str74;
      } else if (line == 75) {
        tone.left() => stl75;
        tone.right() => str75;
      } else if (line == 76) {
        tone.left() => stl76;
        tone.right() => str76;
      } else if (line == 77) {
        tone.left() => stl77;
        tone.right() => str77;
      } else if (line == 78) {
        tone.left() => stl78;
        tone.right() => str78;
      } else if (line == 79) {
        tone.left() => stl79;
        tone.right() => str79;
      } else if (line == 80) {
        tone.left() => stl80;
        tone.right() => str80;
      } else if (line == 81) {
        tone.left() => stl81;
        tone.right() => str81;
      } else if (line == 82) {
        tone.left() => stl82;
        tone.right() => str82;
      } else if (line == 83) {
        tone.left() => stl83;
        tone.right() => str83;
      } else if (line == 84) {
        tone.left() => stl84;
        tone.right() => str84;
      } else if (line == 85) {
        tone.left() => stl85;
        tone.right() => str85;
      } else if (line == 86) {
        tone.left() => stl86;
        tone.right() => str86;
      } else if (line == 87) {
        tone.left() => stl87;
        tone.right() => str87;
      } else if (line == 88) {
        tone.left() => stl88;
        tone.right() => str88;
      }

    }
    else {
      <<<"ERROR: STMIX line too high">>>;
    }

  }
  fun void receive(int line) {
    if ( line < 89  ){
      if (line == 0) {
        stl0 => outl;
        str0 => outr;
      } else if (line == 1) {
        stl1 => outl;
        str1 => outr;
      } else if (line == 2) {
        stl2 => outl;
        str2 => outr;
      } else if (line == 3) {
        stl3 => outl;
        str3 => outr;
      } else if (line == 4) {
        stl4 => outl;
        str4 => outr;
      } else if (line == 5) {
        stl5 => outl;
        str5 => outr;
      } else if (line == 6) {
        stl6 => outl;
        str6 => outr;
      } else if (line == 7) {
        stl7 => outl;
        str7 => outr;
      } else if (line == 8) {
        stl8 => outl;
        str8 => outr;
      } else if (line == 9) {
        stl9 => outl;
        str9 => outr;
      } else if (line == 10) {
        stl10 => outl;
        str10 => outr;
      } else if (line == 11) {
        stl11 => outl;
        str11 => outr;
      } else if (line == 12) {
        stl12 => outl;
        str12 => outr;
      } else if (line == 13) {
        stl13 => outl;
        str13 => outr;
      } else if (line == 14) {
        stl14 => outl;
        str14 => outr;
      } else if (line == 15) {
        stl15 => outl;
        str15 => outr;
      } else if (line == 16) {
        stl16 => outl;
        str16 => outr;
      } else if (line == 17) {
        stl17 => outl;
        str17 => outr;
      } else if (line == 18) {
        stl18 => outl;
        str18 => outr;
      } else if (line == 19) {
        stl19 => outl;
        str19 => outr;
      } else if (line == 20) {
        stl20 => outl;
        str20 => outr;
      } else if (line == 21) {
        stl21 => outl;
        str21 => outr;
      } else if (line == 22) {
        stl22 => outl;
        str22 => outr;
      } else if (line == 23) {
        stl23 => outl;
        str23 => outr;
      } else if (line == 24) {
        stl24 => outl;
        str24 => outr;
      } else if (line == 25) {
        stl25 => outl;
        str25 => outr;
      } else if (line == 26) {
        stl26 => outl;
        str26 => outr;
      } else if (line == 27) {
        stl27 => outl;
        str27 => outr;
      } else if (line == 28) {
        stl28 => outl;
        str28 => outr;
      } else if (line == 29) {
        stl29 => outl;
        str29 => outr;
      } else if (line == 30) {
        stl30 => outl;
        str30 => outr;
      } else if (line == 31) {
        stl31 => outl;
        str31 => outr;
      } else if (line == 32) {
        stl32 => outl;
        str32 => outr;
      } else if (line == 33) {
        stl33 => outl;
        str33 => outr;
      } else if (line == 34) {
        stl34 => outl;
        str34 => outr;
      } else if (line == 35) {
        stl35 => outl;
        str35 => outr;
      } else if (line == 36) {
        stl36 => outl;
        str36 => outr;
      } else if (line == 37) {
        stl37 => outl;
        str37 => outr;
      } else if (line == 38) {
        stl38 => outl;
        str38 => outr;
      } else if (line == 39) {
        stl39 => outl;
        str39 => outr;
      } else if (line == 40) {
        stl40 => outl;
        str40 => outr;
      } else if (line == 41) {
        stl41 => outl;
        str41 => outr;
      } else if (line == 42) {
        stl42 => outl;
        str42 => outr;
      } else if (line == 43) {
        stl43 => outl;
        str43 => outr;
      } else if (line == 44) {
        stl44 => outl;
        str44 => outr;
      } else if (line == 45) {
        stl45 => outl;
        str45 => outr;
      } else if (line == 46) {
        stl46 => outl;
        str46 => outr;
      } else if (line == 47) {
        stl47 => outl;
        str47 => outr;
      } else if (line == 48) {
        stl48 => outl;
        str48 => outr;
      } else if (line == 49) {
        stl49 => outl;
        str49 => outr;
      } else if (line == 50) {
        stl50 => outl;
        str50 => outr;
      } else if (line == 51) {
        stl51 => outl;
        str51 => outr;
      } else if (line == 52) {
        stl52 => outl;
        str52 => outr;
      } else if (line == 53) {
        stl53 => outl;
        str53 => outr;
      } else if (line == 54) {
        stl54 => outl;
        str54 => outr;
      } else if (line == 55) {
        stl55 => outl;
        str55 => outr;
      } else if (line == 56) {
        stl56 => outl;
        str56 => outr;
      } else if (line == 57) {
        stl57 => outl;
        str57 => outr;
      } else if (line == 58) {
        stl58 => outl;
        str58 => outr;
      } else if (line == 59) {
        stl59 => outl;
        str59 => outr;
      } else if (line == 60) {
        stl60 => outl;
        str60 => outr;
      } else if (line == 61) {
        stl61 => outl;
        str61 => outr;
      } else if (line == 62) {
        stl62 => outl;
        str62 => outr;
      } else if (line == 63) {
        stl63 => outl;
        str63 => outr;
      } else if (line == 64) {
        stl64 => outl;
        str64 => outr;
      } else if (line == 65) {
        stl65 => outl;
        str65 => outr;
      } else if (line == 66) {
        stl66 => outl;
        str66 => outr;
      } else if (line == 67) {
        stl67 => outl;
        str67 => outr;
      } else if (line == 68) {
        stl68 => outl;
        str68 => outr;
      } else if (line == 69) {
        stl69 => outl;
        str69 => outr;
      } else if (line == 70) {
        stl70 => outl;
        str70 => outr;
      } else if (line == 71) {
        stl71 => outl;
        str71 => outr;
      } else if (line == 72) {
        stl72 => outl;
        str72 => outr;
      } else if (line == 73) {
        stl73 => outl;
        str73 => outr;
      } else if (line == 74) {
        stl74 => outl;
        str74 => outr;
      } else if (line == 75) {
        stl75 => outl;
        str75 => outr;
      } else if (line == 76) {
        stl76 => outl;
        str76 => outr;
      } else if (line == 77) {
        stl77 => outl;
        str77 => outr;
      } else if (line == 78) {
        stl78 => outl;
        str78 => outr;
      } else if (line == 79) {
        stl79 => outl;
        str79 => outr;
      } else if (line == 80) {
        stl80 => outl;
        str80 => outr;
      } else if (line == 81) {
        stl81 => outl;
        str81 => outr;
      } else if (line == 82) {
        stl82 => outl;
        str82 => outr;
      } else if (line == 83) {
        stl83 => outl;
        str83 => outr;
      } else if (line == 84) {
        stl84 => outl;
        str84 => outr;
      } else if (line == 85) {
        stl85 => outl;
        str85 => outr;
      } else if (line == 86) {
        stl86 => outl;
        str86 => outr;
      } else if (line == 87) {
        stl87 => outl;
        str87 => outr;
      } else if (line == 88) {
        stl88 => outl;
        str88 => outr;
      }

    }
    else {
      <<<"ERROR: STMIX line too high">>>;
    }

  }

}

Gain l0 @=> STMIX.stl0;
Gain r0 @=> STMIX.str0;
Gain l1 @=> STMIX.stl1;
Gain r1 @=> STMIX.str1;
Gain l2 @=> STMIX.stl2;
Gain r2 @=> STMIX.str2;
Gain l3 @=> STMIX.stl3;
Gain r3 @=> STMIX.str3;
Gain l4 @=> STMIX.stl4;
Gain r4 @=> STMIX.str4;
Gain l5 @=> STMIX.stl5;
Gain r5 @=> STMIX.str5;
Gain l6 @=> STMIX.stl6;
Gain r6 @=> STMIX.str6;
Gain l7 @=> STMIX.stl7;
Gain r7 @=> STMIX.str7;
Gain l8 @=> STMIX.stl8;
Gain r8 @=> STMIX.str8;
Gain l9 @=> STMIX.stl9;
Gain r9 @=> STMIX.str9;
Gain l10 @=> STMIX.stl10;
Gain r10 @=> STMIX.str10;
Gain l11 @=> STMIX.stl11;
Gain r11 @=> STMIX.str11;
Gain l12 @=> STMIX.stl12;
Gain r12 @=> STMIX.str12;
Gain l13 @=> STMIX.stl13;
Gain r13 @=> STMIX.str13;
Gain l14 @=> STMIX.stl14;
Gain r14 @=> STMIX.str14;
Gain l15 @=> STMIX.stl15;
Gain r15 @=> STMIX.str15;
Gain l16 @=> STMIX.stl16;
Gain r16 @=> STMIX.str16;
Gain l17 @=> STMIX.stl17;
Gain r17 @=> STMIX.str17;
Gain l18 @=> STMIX.stl18;
Gain r18 @=> STMIX.str18;
Gain l19 @=> STMIX.stl19;
Gain r19 @=> STMIX.str19;
Gain l20 @=> STMIX.stl20;
Gain r20 @=> STMIX.str20;
Gain l21 @=> STMIX.stl21;
Gain r21 @=> STMIX.str21;
Gain l22 @=> STMIX.stl22;
Gain r22 @=> STMIX.str22;
Gain l23 @=> STMIX.stl23;
Gain r23 @=> STMIX.str23;
Gain l24 @=> STMIX.stl24;
Gain r24 @=> STMIX.str24;
Gain l25 @=> STMIX.stl25;
Gain r25 @=> STMIX.str25;
Gain l26 @=> STMIX.stl26;
Gain r26 @=> STMIX.str26;
Gain l27 @=> STMIX.stl27;
Gain r27 @=> STMIX.str27;
Gain l28 @=> STMIX.stl28;
Gain r28 @=> STMIX.str28;
Gain l29 @=> STMIX.stl29;
Gain r29 @=> STMIX.str29;
Gain l30 @=> STMIX.stl30;
Gain r30 @=> STMIX.str30;
Gain l31 @=> STMIX.stl31;
Gain r31 @=> STMIX.str31;
Gain l32 @=> STMIX.stl32;
Gain r32 @=> STMIX.str32;
Gain l33 @=> STMIX.stl33;
Gain r33 @=> STMIX.str33;
Gain l34 @=> STMIX.stl34;
Gain r34 @=> STMIX.str34;
Gain l35 @=> STMIX.stl35;
Gain r35 @=> STMIX.str35;
Gain l36 @=> STMIX.stl36;
Gain r36 @=> STMIX.str36;
Gain l37 @=> STMIX.stl37;
Gain r37 @=> STMIX.str37;
Gain l38 @=> STMIX.stl38;
Gain r38 @=> STMIX.str38;
Gain l39 @=> STMIX.stl39;
Gain r39 @=> STMIX.str39;
Gain l40 @=> STMIX.stl40;
Gain r40 @=> STMIX.str40;
Gain l41 @=> STMIX.stl41;
Gain r41 @=> STMIX.str41;
Gain l42 @=> STMIX.stl42;
Gain r42 @=> STMIX.str42;
Gain l43 @=> STMIX.stl43;
Gain r43 @=> STMIX.str43;
Gain l44 @=> STMIX.stl44;
Gain r44 @=> STMIX.str44;
Gain l45 @=> STMIX.stl45;
Gain r45 @=> STMIX.str45;
Gain l46 @=> STMIX.stl46;
Gain r46 @=> STMIX.str46;
Gain l47 @=> STMIX.stl47;
Gain r47 @=> STMIX.str47;
Gain l48 @=> STMIX.stl48;
Gain r48 @=> STMIX.str48;
Gain l49 @=> STMIX.stl49;
Gain r49 @=> STMIX.str49;
Gain l50 @=> STMIX.stl50;
Gain r50 @=> STMIX.str50;
Gain l51 @=> STMIX.stl51;
Gain r51 @=> STMIX.str51;
Gain l52 @=> STMIX.stl52;
Gain r52 @=> STMIX.str52;
Gain l53 @=> STMIX.stl53;
Gain r53 @=> STMIX.str53;
Gain l54 @=> STMIX.stl54;
Gain r54 @=> STMIX.str54;
Gain l55 @=> STMIX.stl55;
Gain r55 @=> STMIX.str55;
Gain l56 @=> STMIX.stl56;
Gain r56 @=> STMIX.str56;
Gain l57 @=> STMIX.stl57;
Gain r57 @=> STMIX.str57;
Gain l58 @=> STMIX.stl58;
Gain r58 @=> STMIX.str58;
Gain l59 @=> STMIX.stl59;
Gain r59 @=> STMIX.str59;
Gain l60 @=> STMIX.stl60;
Gain r60 @=> STMIX.str60;
Gain l61 @=> STMIX.stl61;
Gain r61 @=> STMIX.str61;
Gain l62 @=> STMIX.stl62;
Gain r62 @=> STMIX.str62;
Gain l63 @=> STMIX.stl63;
Gain r63 @=> STMIX.str63;
Gain l64 @=> STMIX.stl64;
Gain r64 @=> STMIX.str64;
Gain l65 @=> STMIX.stl65;
Gain r65 @=> STMIX.str65;
Gain l66 @=> STMIX.stl66;
Gain r66 @=> STMIX.str66;
Gain l67 @=> STMIX.stl67;
Gain r67 @=> STMIX.str67;
Gain l68 @=> STMIX.stl68;
Gain r68 @=> STMIX.str68;
Gain l69 @=> STMIX.stl69;
Gain r69 @=> STMIX.str69;
Gain l70 @=> STMIX.stl70;
Gain r70 @=> STMIX.str70;
Gain l71 @=> STMIX.stl71;
Gain r71 @=> STMIX.str71;
Gain l72 @=> STMIX.stl72;
Gain r72 @=> STMIX.str72;
Gain l73 @=> STMIX.stl73;
Gain r73 @=> STMIX.str73;
Gain l74 @=> STMIX.stl74;
Gain r74 @=> STMIX.str74;
Gain l75 @=> STMIX.stl75;
Gain r75 @=> STMIX.str75;
Gain l76 @=> STMIX.stl76;
Gain r76 @=> STMIX.str76;
Gain l77 @=> STMIX.stl77;
Gain r77 @=> STMIX.str77;
Gain l78 @=> STMIX.stl78;
Gain r78 @=> STMIX.str78;
Gain l79 @=> STMIX.stl79;
Gain r79 @=> STMIX.str79;
Gain l80 @=> STMIX.stl80;
Gain r80 @=> STMIX.str80;
Gain l81 @=> STMIX.stl81;
Gain r81 @=> STMIX.str81;
Gain l82 @=> STMIX.stl82;
Gain r82 @=> STMIX.str82;
Gain l83 @=> STMIX.stl83;
Gain r83 @=> STMIX.str83;
Gain l84 @=> STMIX.stl84;
Gain r84 @=> STMIX.str84;
Gain l85 @=> STMIX.stl85;
Gain r85 @=> STMIX.str85;
Gain l86 @=> STMIX.stl86;
Gain r86 @=> STMIX.str86;
Gain l87 @=> STMIX.stl87;
Gain r87 @=> STMIX.str87;
Gain l88 @=> STMIX.stl88;
Gain r88 @=> STMIX.str88;


//Gain l @=> STMIX.stl_test;
//Gain r @=> STMIX.str_test;

while(1) {
       100::ms => now;
}
 

