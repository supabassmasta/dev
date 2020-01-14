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


"1234" => string s;
<<<s.substring(0,4)>>>;
<<<s.charAt(0) - 48>>>; 



	 MELANGEATOR melan[1]; 
   0 => int melan_index;	 

	"12345678" => melan[melan_index].in; <<<"in : ", melan[melan_index].in>>>;
"i)&)àfv405801451°9miajefbafvbj" => melan[melan_index].pattern;
	2 => melan[melan_index].sub_seq_size; 	0 => melan[melan_index].seq_offset; 	0 => melan[melan_index].padding;

  melan[melan_index].out() => string out_str;
	
  <<<out_str>>>; 

	1 +=> melan_index;



	1::ms =>now;
