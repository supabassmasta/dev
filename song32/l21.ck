class RAND {

  fun static string char(string s, int n) {
    string out;
    s.length() => int sl;
    " " => string tmp;

    for (0 => int i; i <  n; i++) {
      tmp.setCharAt(0,  s.charAt(Std.rand2(0, sl - 1)));
      tmp +=> out;
    }
     
    return out;
  }

  fun static string seq(string s, int n) {
    string out;
    string tok[0];
    
    // Parse s and tokkenize
    0 => int last_idx;
    s.length() => int sl;
    while (last_idx != -1 && last_idx < sl) {
      last_idx => int old;
      s.find(",", last_idx ) => last_idx;
      if ( last_idx == -1  ) {
        tok << s.substring(old, sl - old);
      }
      else {
        tok << s.substring(old, last_idx - old);
        1 +=> last_idx;
      }
    }

    // Print tokkens
//    for (0 => int i; i < tok.size()      ; i++) {
//      <<< tok[i] >>>;
//    }

    for (0 => int i; i <  n ; i++) {
      tok[ Std.rand2(0, tok.size()-1) ] +=> out;
    }

    return out;
  }

  // char_sync : create seq until reaching sync time
  // seq sync  
}



"ab_" => string s; 10 => int n;
<<<"RAND.char(" + s + ", "+ n + ") ", RAND.char(s,n)>>>;

"/\\+-{ab_" =>  s; 10 => n;
<<<"RAND.char(" + s + ", "+ n + ") ", RAND.char(s,n)>>>;

"aa,bbb,c" =>  s; 10 => n;
<<<"RAND.seq(" + s + ", "+ n + ") ", RAND.seq(s,n)>>>;

//"abc,a"=> string test;
//<<<test.find(",", 0)>>>;
//<<<test.find(",", 5)>>>;


1::ms => now;


