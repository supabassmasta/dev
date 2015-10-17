public class TONE {

    SYNT synt[0];
    Envelope env[0];
    ADSR adsr[0];
    int on[0];

    float scale[0];

    // input for all env
    Step one;
    1. => one.next;

    // Output for all synt and adsr
    Gain out  => Pan2 pan => dac;
    Gain raw_out;
    .2 => raw_out.gain;

    data.tick =>  dur base_dur;
    0.05 => float groove_ratio;
    0.3 => float init_gain;
    0.03 => float gain_step;
    -1. => float gain_to_apply;

    0. => float init_pan;
    0.1 => float pan_step;
    -2. => float pan_to_apply;

    1. => float init_rate;
    0.1 => float rate_step;
    -10. => float rate_to_apply;

    1. => float proba_to_apply;
    // PRIVATE
    0::ms => dur max_v;//private
    0::ms => dur remaining;//private
    0::ms => dur groove;

    SEQ3 s;
    data.wait_before_start => s.sync_offset;
    fun void no_sync()      {s.no_sync() ;}
    fun void element_sync() {s.element_sync();}
    fun void full_sync()    {s.full_sync();}


    fun void max(dur in){
        in => max_v => remaining;
    }

    fun dur set_dur(dur in_dur){// private
        dur res;
        if (max_v == 0::ms)
            return in_dur;
        else {
            if (in_dur >= remaining){
                remaining => res;
                0::ms => remaining;
            }
            else {
                in_dur => res;
                remaining - in_dur => remaining;
            }

            return res;
        }
    }



    fun void reg(SYNT @ in) {
        Envelope @ e;
        ADSR @ a;

        synt << in;

        new Envelope @=> e;
        env << e;

        new ADSR @=> a;
        adsr << a;
        a.set(3::ms, 0::ms, 1., 3::ms);
        init_gain => a.gain;

        one => e => in => a => out;
        in => raw_out;

        on << 0;
    }

    // function to get audio out of object
    // only one of this to use at a time
    Gain mono_out;
    fun UGen mono() {
        out =< pan;
        out => mono_out;

        return mono_out;
    }

    Gain left_out;
    fun UGen left() {
        pan =< dac;
        pan.left => left_out;
        return left_out;
    }
    Gain right_out;
    fun UGen right() {
        pan =< dac;
        pan.right => right_out;
        return right_out;
    }

    // raw signal, no adsr
    fun UGen raw() {
        out =< pan;
        raw_out=> mono_out;

        return mono_out;
    }

    /////////// ACTIONS ////////////////

    class freq_synt extends ACTION {
        Envelope @ e;
        float f;

        fun int on_time() {
            f => e.value;
        }
    }

    fun ACTION set_freq_synt (Envelope @ e, float f) {
        new freq_synt @=> freq_synt @ act;
        f => act.f;
        e @=> act.e;

        return act;
    }

    class off_adsr extends ACTION {
        ADSR @ a;

        fun int on_time() {
            a.keyOff();
        }
    }
    fun ACTION set_off_adsr (ADSR @ a) {
        new off_adsr @=> off_adsr @ act;
        a @=> act.a;

        return act;
    }

    class on_adsr extends ACTION {
        ADSR @ a;

        fun int on_time() {
            a.keyOn();
        }
    }

    fun ACTION set_on_adsr (ADSR @ a) {
        new on_adsr @=> on_adsr @ act;
        a @=> act.a;

        return act;
    }

    class gain_adsr extends ACTION {
        ADSR @ a;
        float g;

        fun int on_time() {
            g => a.gain;
        }
    }

    fun ACTION set_gain_adsr (ADSR @ a, float g) {
        new gain_adsr @=> gain_adsr @ act;
        a @=> act.a;
        g => act.g;

        return act;
    }

    //////// NOTE MANAGEMENT ///////////////

    fun int is_note(int c) {
        if (((c >= '0') && (c <= '9')) || 
                ((c >= 'a') && (c <= 'z')) ||
                ((c >= 'A') && (c <= 'Z')))
            return 1;
        else
            return 0;

    }

    fun int convert_note(int c) {
        if ((c >= '0') && (c <= '9')) 
            return  c - '0';
        else if	 ((c >= 'a') && (c <= 'z')) 
            return  c - 'a' + 10;
        else if	((c >= 'A') && (c <= 'Z'))
            return -1 - (c - 'A');
        else
            return 1;

    }

    fun float conv_to_freq (int rel_note, float sc[], int ref_note) {
        int j, k;
        float distance_i;
        float result_i;

        if (sc.size() != 0) {
            if (rel_note == 0)
            {
                0 => distance_i;
            }
            else if (rel_note > 0)
            {
                0 => distance_i;
                for (0 => j; j<rel_note; j++)
                {
                    sc[ j % sc.size()] +=> distance_i;
                }
            }
            else /* rel_note < 0 */
            {
                0 => distance_i;
                for (0 => j; j< -rel_note; j++)
                {
                    sc.size() - 1 - (j % sc.size()) => k;
                    sc[ k ] -=> distance_i;
                }
            }

            /* Convert Note */
            ref_note + distance_i => result_i;
        }
        else {
            ref_note + rel_note => result_i;
        }

        return Std.mtof(result_i);  
    }

    /////////////// INDEX ///////////////
    class index {
        // interal
        0=> int state;
        0=> int value_i;

        // public
        fun void up(){
            2 => state;
            value_i + 1 => value_i;
        }

        fun int value () {
            state - 1 => state;
            if (state <=0) {
                0=> value_i;
                0=> state;
            }

            return value_i;
        }


        fun void reset (){
            0=> state;
            0=> value_i;
        }
    }



    ///////// seq ///////////////
    fun void seq(string in) {
        0=> int i;
        int c;
        "0" => string note_id;
        ELEMENT @ e;

        dur dur_temp;
        index idx;

        // reset remaining
        max_v => remaining;

        // Create next element of SEQ

        while(i< in.length() ) {
            in.charAt(i)=> c;
            //            		<<<"c", c>>>;	
            if (c == ' ' ){
                // do nothing
            }
            else if ( is_note(c)  ) {
                // Get index
                idx.value() => int id;
                <<<"index:", id, "note", c>>>; 
                if (id >= synt.size()){
                    <<<"Not enough synt registered, default synt 0 used">>>;
                    0 => id;
                }
                // BRAND NEW event
                if (id == 0) {
                    new ELEMENT @=> e;
                    // Search synt that are not on anymore
                    for (0 => int i; i < on.size()      ; i++) {
                        if (on[i] !=0) {
                            on[i] - 1 => on[i];
                            if (on[i] <= 0 ){
                                0 => on[i];
                                s.elements[s.elements.size() - 1].actions << set_off_adsr(adsr[i]);
                            }
                        }
                    }
                }

                ///// PARAMS //////////////////
                // set new GAIN if needed
                if (gain_to_apply != -1) {
                    e.actions << set_gain_adsr (adsr[id], gain_to_apply);
                    -1. => gain_to_apply;
                }


                /////////// NOTE ////////////
                convert_note(c) => int rel_note;

                // SET NOTE
                e.actions << set_freq_synt(env[id], conv_to_freq(rel_note, scale, data.ref_note)); 

                e.actions << set_on_adsr(adsr[id]); 
                // Store that synt is on
                2 => on[id];



                if ( id == 0 ) {
                    if (groove == 0::ms){
                        set_dur(base_dur) => dur_temp;
                    }
                    else if( s.elements.size() == 0) {
                        set_dur(base_dur) => dur_temp;
                        <<<"Not supported:  groove on first note">>>; 
                    }
                    else {
                        //                        <<<"groove:", groove/1::ms>>>; 
                        // add groove to last event
                        //                        <<<"s.elements[s.elements.size() - 1].duration:", s.elements[s.elements.size() - 1].duration/1::ms>>>; 
                        groove +=> s.elements[s.elements.size() - 1].duration;
                        groove -=> remaining; // correct remaining
                        //                        <<<"s.elements[s.elements.size() - 1].duration:", s.elements[s.elements.size() - 1].duration/1::ms>>>; 
                        // substract it to next one
                        set_dur(base_dur - groove) => dur_temp;
                        //                        <<<"dur_temp:", dur_temp/1::ms>>>;
                        // reset it
                        0::ms => groove;
                    }
                    if (dur_temp != 0::ms ) {

                        dur_temp => e.duration;
                        // Add element to SEQ
                        s.elements << e;

                    }
                }

            }
            else if (c == '_') {

                if (groove == 0::ms){
                    set_dur(base_dur) => dur_temp;
                }
                else if( s.elements.size() == 0) {
                    set_dur(base_dur) => dur_temp;
                    <<<"Not supported:  groove on first note">>>; 
                }
                else {
                    //                        <<<"groove:", groove/1::ms>>>; 
                    // add groove to last event
                    //                        <<<"s.elements[s.elements.size() - 1].duration:", s.elements[s.elements.size() - 1].duration/1::ms>>>; 
                    groove +=> s.elements[s.elements.size() - 1].duration;
                    groove -=> remaining; // correct remaining
                    //                        <<<"s.elements[s.elements.size() - 1].duration:", s.elements[s.elements.size() - 1].duration/1::ms>>>; 
                    // substract it to next one
                    set_dur(base_dur - groove) => dur_temp;
                    //                        <<<"dur_temp:", dur_temp/1::ms>>>;
                    // reset it
                    0::ms => groove;
                }


                if (dur_temp != 0::ms) {
                    new ELEMENT @=> e;
                    dur_temp => e.duration;

                    // KeyOff all adsr
                    for (0 => int j; j < adsr.size() ; j++) {
                        e.actions << set_off_adsr(adsr[j]);                
                        0 => on[j];
                    }

                    // Restart on first synt for next action
                    idx.reset();
                    // Add element to SEQ
                    s.elements << e;
                }
            }
            else if (c == '|') {
                // Next instruction is for synt+1
                idx.up();

            }
            else if (in.charAt(i) == '*') {
                i++;
                in.charAt(i)=> c;
                if ('0' <= c && c <= '9') {
                    base_dur / ( (c - '0') $ float) => base_dur;
                }
            }
            else if (in.charAt(i) == ':') {
                i++;
                in.charAt(i)=> c;
                if ('0' <= c && c <= '9') {
                    base_dur * ( (c - '0') $ float) => base_dur;
                }
            }
            else if (in.charAt(i) == '+') {
                i++;
                in.charAt(i)=> c;
                if ('0' <= c && c <= '9') {
                    if (gain_to_apply == -1.)
                        init_gain + gain_step * (c -'0') $ float =>  gain_to_apply;
                    else
                        gain_step * (c -'0') $ float +=>  gain_to_apply;
                }
                else {
                    if (gain_to_apply == -1.)
                        init_gain + gain_step  =>  gain_to_apply;
                    else
                        gain_step  +=>  gain_to_apply;
                    i--;
                }
            }
            else if (in.charAt(i) == '-') {
                i++;
                in.charAt(i)=> c;
                if ('0' <= c && c <= '9') {
                    if (gain_to_apply == -1.)
                        init_gain - gain_step * (c -'0') $ float =>  gain_to_apply;
                    else
                        gain_step * (c -'0') $ float -=>  gain_to_apply;
                }
                else {
                    if (gain_to_apply == -1.)
                        init_gain - gain_step  =>  gain_to_apply;
                    else
                        gain_step  -=>  gain_to_apply;
                    i--;
                }
            }
            else if (in.charAt(i) == '<') {
                i++;
                in.charAt(i)=> c;
                if ('0' <= c && c <= '9') {
                    base_dur * groove_ratio * (c -'0') $ float -=> groove;
                }
                else {
                    base_dur * groove_ratio   -=> groove;
                    i--;
                }
            }
            else if (in.charAt(i) == '>') {
                i++;
                in.charAt(i)=> c;
                if ('0' <= c && c <= '9') {
                    base_dur * groove_ratio * (c -'0') $ float +=> groove;
                }
                else {
                    base_dur * groove_ratio  +=> groove;
                    i--;
                }
            }



            i++;
        }

    }
    fun void go(){
        s.go();
    }

}
///*
// TEST

class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt0 s1);
t.reg(synt0 s2);
t.reg(synt0 s3);
//t.scale << 2<< 1<<2<<2<<1<<2<<2;
//data.tick * 4 => t.max;
//t.seq("0|+0a0|-6a");
t.seq("*2  0_0_<95<9_5_");
t.go();

//t.mono() => NRev r => dac;
//.3 => r.mix;
//  1 => t.pan.pan;
//  t.right() => dac;
		// TODO : TO REMOVE
//		220 => t.env[0].value;
//		t.adsr[0].keyOn();
//t.raw() => dac;
while(1) {
	     100::ms => now;
}

//*/
