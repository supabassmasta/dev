public class LPD8 extends lpd8 {

		static int pot[][];

    fun void potar_ext (int group_no, int pad_nb, int val) {
			if (group_no < 176 || group_no > 179 || pad_nb < 1 || pad_nb > 8)
					<<<"ERROR LPD8 mode not managed in lpd8_master class">>>; 
				else
						val => pot[group_no - 176][pad_nb-1];
			}
    fun void pad_ext (int group_no, int pad_nb, int val) {}
		
		 fun static int k(int group , int no){
				if (no > 8 || no < 1 || group < 1 || group > 4) 
					<<<"Error lpd8 potar ", group, " , " , no , " does not exist">>>; 
				else 
						return pot[group - 1][no - 1];

				return 0;
		}

}
[[256, 256, 256, 256, 256, 256, 256, 256],[256, 256, 256, 256, 256, 256, 256, 256],[256, 256, 256, 256, 256, 256, 256, 256], [256, 256, 256, 256, 256, 256, 256, 256]]   @=>  LPD8.pot;
// init
//for (0 => int i; i <  4     ; i++) {
//for (0 => int j; j <  8     ; j++) {
//		256 => pot[i][j];
//}
// }
 
 LPD8 instance;

while (1) 1::second => now; 
