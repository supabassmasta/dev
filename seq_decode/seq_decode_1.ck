public class seq_decode {
    string file_path;

    dur note_dur_a[0];
    float part_a[12][0];
    
    0=> int wav_nb;
    // UGen
    SndBuf wav_a[0];
    ADSR out_env[0];
    Gain gain_out;
    gain_out.gain(0.3);
    
    dur full_dur;
    
    // RYTHM
    rythm rythm_o;
    
    // Update var
    0=> int stop_update_i;
    
    Shred @ seq_shred;
   
    fun void convert_seq(string file_path_l){
        // instantiate
        FileIO fio;
        StringTokenizer tok;
        string new_line;
        string id_cmd;
        float val;
        int i;
        string val_s;
        0=>int line_nb;
        1=>int no_error;
        
        0=>int common_tok;
        0=>int dur_tok;
        0=>int blank_line;
        0=>int comment;
        
        0=>int note_nb;
        
        1=>int get_files_path_mode;
    
        // Save file path
        file_path_l => file_path;
        // open a file
        fio.open( file_path_l, FileIO.READ );

        if( !fio.good() ){
            cherr <= "can't open file: " <= file_path_l <= " for reading..."
                  <= IO.newline();
            me.exit();
        }
    
        // init rythm
        rythm_o.constructor();

        // init arrays
        0=> wav_nb;

        0=>note_dur_a.size;
        for (0=>i; i<12; i++) 0 => part_a[i].size;
        0=>wav_a.size;
        0=>out_env.size;
        
        while( fio.more() && no_error  )
        {
            //chout <= fio.readLine() <= IO.newline();
              fio.readLine() => new_line;
            //  <<<"line number:",++line_nb>>>;
             // <<<"new_line", new_line>>>;
             tok.set(new_line);
             
            0=>dur_tok;
            0=>comment;
            0=>common_tok;
            1=>blank_line;
            
            0=> note_nb;
            
            while( tok.more() && no_error && !comment ) {
                0=>blank_line;

                 tok.next() => id_cmd;
                 //<<<"tok",id_cmd>>>;
                
                if (get_files_path_mode) {
                    if      (id_cmd == "SEQ") {
                        0=>get_files_path_mode;

                        1 => common_tok;
                    }
                    else if (id_cmd == "#") {
                        1 => comment;

                        1 => common_tok;
                    }
                    else {
                        wav_nb++;
                        wav_nb => wav_a.size;
                        new SndBuf @=> wav_a[wav_nb-1];
                        id_cmd=> wav_a[wav_nb-1].read;
                        wav_a[wav_nb-1].samples() => wav_a[wav_nb-1].pos; // Set to the end to avoid unwanted play
                    
                        wav_nb => out_env.size;
                        new ADSR @=> out_env[wav_nb-1];
                        out_env[wav_nb-1].set( 5::ms, 0::ms, 1, 5::ms );
                        
                        wav_a[wav_nb-1] => out_env[wav_nb-1] => gain_out;

                        1 => common_tok;
                    }
                
                }
                else {
                    if (id_cmd == "#") {
                        1 => comment;

                        1 => common_tok;
                    }
                    else if (id_cmd == "._") {
                        part_a[note_nb] << 0;
                    
                        note_nb++;
                    }
                    else if (id_cmd == "DUR") {
                        Std.atof(tok.next())=>val; 
                        note_dur_a<<(val * rythm_o.tick_delay);
                        1 => dur_tok;
                    }
                    else {
                        Std.atof(id_cmd)=>val;
                        part_a[note_nb] <<val; 
                        
                        note_nb++;
                    }

                }
            }
            
            if (!common_tok && !blank_line && !dur_tok)
                    note_dur_a << rythm_o.tick_delay;
                
        }
        // compute full duration
        0::ms => full_dur;
    
        for (0=>int i; i<note_dur_a.size(); i++)  note_dur_a[i] +=> full_dur;
    
        if (note_dur_a.size()!= part_a[0].size()) <<<"\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\nERROR: note_dur_a.size()",note_dur_a.size()," != part_a[0].size()",part_a[0].size(),"\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n">>>;

    
        <<<"Part duration compared to rythm_inf length :", full_dur/(rythm_o.tick_nb*rythm_o.tick_delay)>>>;
    
        fio.close( );   
    }

    fun int sync_seq() {
        0=>int index_start;
        0::ms=>dur t_part;
                
        // Get now;
        now%full_dur => dur t_elapsed;
        
        while (t_elapsed > t_part) {
           note_dur_a[index_start] +=> t_part;
           (index_start+1)%note_dur_a.size() => index_start; 
        }
        
        // Wait synchro time
        t_part - t_elapsed => now;
    
        return index_start;
    }

    // Functions to extend
    fun void wav_on_ext(int wav_no, int part_index){}
    fun void seq_index_ext( int part_index){}
    
    fun void play_wav(int wav_no, int part_index) {
        part_a[wav_no][part_index] => wav_a[wav_no].gain;
        0 => wav_a[wav_no].pos;
        wav_on_ext(wav_no, part_index);
        wav_a[wav_no].samples()::samp => now;
    }
    
    
    
    fun void play_seq(int nb_loop) {
        0=>int infinite_loop;
        sync_seq() => int note_idx;
        int wav_no;
    
        if (nb_loop == 0) {1=>infinite_loop; 1=>nb_loop;}
    
        while (nb_loop > 0 || infinite_loop) {

            for (0=>wav_no ; wav_no < wav_nb; wav_no++) {
                if (part_a[wav_no][note_idx] != 0) {
                    spork ~ play_wav(wav_no, note_idx);
                }
            }
            
            seq_index_ext(note_idx);
        
            note_dur_a[note_idx] => now;
            (note_idx+1)%note_dur_a.size() => note_idx;
            if (note_idx == 0 && !infinite_loop) nb_loop--;
        
        }
    }
    
    fun UGen connect(){
        return gain_out;
    }

    fun UGen re_connect(int wav_no){
        out_env[wav_no] =< gain_out;
        
        return out_env[wav_no];
    }
    
    fun void run(int nb_loop){
        spork ~ play_seq(nb_loop) @=> seq_shred;
    }

//--------------------------------------------//
//               KB management                //
//--------------------------------------------//

    fun void kb_management (Hid hi)
    {
        HidMsg msg; 
        // infinite event loop
        while( !stop_update_i )
        {
            // wait on event
            hi => now;
        
            // get one or more messages
            while( hi.recv( msg ) )
            {
                // check for action type
                if( msg.isButtonDown() )
                {
                    //<<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                    if (msg.which == 31)
                    {
                        for (0=>int i; i<out_env.size(); i++) out_env[i].keyOff();
                        
                        out_env[0].releaseTime() => now;
                        
                        Machine.remove( seq_shred.id() );
                        // Wait time to save file
                        0.5::second => now;
                        
                        convert_seq(file_path);
                        for (0=>int i; i<out_env.size(); i++) out_env[i].keyOn();
                        spork ~ play_seq(0) @=> seq_shred;
                        
                    }
                    
                }
            }
        }
    }

    //--------------------------------------------//
    //               kb Init                      //
    //--------------------------------------------//
    fun void allow_update()
    {
        Hid hi;
        
        0=> stop_update_i;
        // open keyboard 0
        if( !hi.openKeyboard( 0 ) ) me.exit();
        <<< "keyboard '" + hi.name() + "' ready", "" >>>;
        
        spork ~ kb_management(hi);
    }

    fun void stop_update()
    {
        1 => stop_update_i;
    }


    
}

/*    
seq_decode seq;
int i;
int j;

seq.convert_seq("test.pt");
seq.allow_update();

for (0=> i; i<seq.wav_nb; i++)
{
    for (0=> j; j<seq.part_a[i].size(); j++)
     {   <<<seq.part_a[i][j]>>>;}

    <<<"###">>>;
    <<<"seq.part_a[",i,"].size()",seq.part_a[i].size()>>>;
 }
    
 for (0=> i; i<seq.note_dur_a.size(); i++) <<<seq.note_dur_a[i]>>>;   
    
    
 <<<"seq.note_dur_a.size()",seq.note_dur_a.size()>>>;   
    
seq.connect() => dac;

seq.re_connect(0) => Gain out_kick => dac;
out_kick.gain(0.4);

seq.run(0);

while (1) 1::ms => now;    
    
*/    
    
    
    
    
    
