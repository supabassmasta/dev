class MELANGEATOR {
	"" => string in;
	"" => string pattern;
	1 => int sub_seq_size;
	0 => int seq_offset;
	0 => int padding;

	"" => string out_s;

	fun string out(){
		int  j;
		for (0 => int i; i < pattern.length() ; i++) {
			if (pattern.charAt(i) == '0' ) {
				
				 i*sub_seq_size + seq_offset => j;
		  }
			else {
				(pattern.charAt(i)  - 48 - 1 ) * sub_seq_size + seq_offset => j;
			}
		  if (j < 0  ){
					<<<"Warning  MELANGEATOR  negative j ", j>>>;
			 	  -1 *=> j;
			}

			if (j + sub_seq_size > in.length()){
				<<<"Warning: MELANGEATOR overflow j:", j,"sub_seq_size: ", sub_seq_size, "input seq lenght: ", in.length() >>>; 
				j % in.length() => j;
				if (j + sub_seq_size > in.length()){
					<<<"ERROR: MELANGEATOR overflow and cannot modulo j:", j,"sub_seq_sze: ", sub_seq_size, "input seq lenght: ", in.length() >>>; 
					 0=>j;
					if (sub_seq_size > in.length()){
						return "";
					}
				}
			}

			out_s + in.substring (j, sub_seq_size) => out_s; 

		}
		return out_s;

	}
	
}


//"1234" => string s;
//<<<s.substring(0,4)>>>;
//<<<s.charAt(0) - 48>>>; 



	 MELANGEATOR melan[1]; 
   0 => int melan_index;	 

"*8k______s_s_k___sk______s_skk___k" => string in;
in => melan[melan_index].in; <<<"in : ", melan[melan_index].in>>>;
  "00070026"=> melan[melan_index].pattern;
	4 => melan[melan_index].sub_seq_size; 	2 => melan[melan_index].seq_offset; 	0 => melan[melan_index].padding;
  in + melan[melan_index].out() => string out_str;
  <<<out_str>>>; 



in => melan[melan_index].in; <<<"in : ", melan[melan_index].in>>>;
  "00000000"=> melan[melan_index].pattern;
	2 => melan[melan_index].sub_seq_size; 	2 + 16 => melan[melan_index].seq_offset; 	0 => melan[melan_index].padding;

  out_str + melan[melan_index].out() =>  out_str;
	
  <<<out_str>>>; 

in => melan[melan_index].in; <<<"in : ", melan[melan_index].in>>>;
  "45465456"=> melan[melan_index].pattern;
	2 => melan[melan_index].sub_seq_size; 	2 + 16 => melan[melan_index].seq_offset; 	0 => melan[melan_index].padding;

  out_str + melan[melan_index].out() =>  out_str;
	
  <<<out_str>>>; 

//	1 +=> melan_index;



SEQ s;  //data.tick * 8 => s.max;  // 
SET_WAV.TRIBAL(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
out_str => s.seq;
.9 => s.gain; //
s.gain("s", .3); // for single wav 
s.gain("t", .3); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
