public class SYNT extends Chugraph{

	// ****  SYNT *****
//	inlet => SinOsc s => outlet;	
      0 => int own_adsr;

      0 => int stereo;
      ST stout;

	    fun void on(/* float p1 */)  {   /*<<<"synt_def on">>>; */		         }
			fun void off() {	    /* <<<"synt_def off">>>;*/         }
			fun void new_note(int idx)  {			/* <<<"synt_def new_note">>>;*/         }
}
