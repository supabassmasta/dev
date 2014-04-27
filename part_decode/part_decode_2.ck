class part_decode {

    float freq_a[0];
    dur   freq_dur_a[0];
    int   slide_a[0];
    
    dur   note_dur_a[0];
    int   note_on_a[0];
    
    // RYTHM
    rythm rythm_o;

    // UGen
    Step step => Envelope freq_guide_u => blackhole;
    step.next(1);
    ADSR env_u;
    env_u.set( 10::ms, 8::ms, .8, 100::ms );
    
    fun int conv_to_note(int rel_notes_i, int gamme_a[], int ref_note)
    {
        int j, k;
        int distance_i;
        int result_i;

        /* Compute distance to note */
        if (rel_notes_i == 0)
        {
            0 => distance_i;
        }
        else if (rel_notes_i > 0)
        {
            0 => distance_i;
            for (0 => j; j<rel_notes_i; j++)
            {
                gamme_a[ j % gamme_a.cap()] +=> distance_i;
            }
        }
        else /* rel_notes_i < 0 */
        {
            0 => distance_i;
            for (0 => j; j< -rel_notes_i; j++)
            {
                gamme_a.cap() - 1 - (j % gamme_a.cap()) => k;
                gamme_a[ k ] -=> distance_i;
            }
        }
        
        /* Convert Note */
        ref_note + distance_i => result_i;
        
        return result_i;  
    }

    
    fun void convert_part(string file_path){
        // instantiate
        FileIO fio;
        StringTokenizer tok;
        string new_line;
        string id_cmd;
        float val;
        int val_i;
        string val_s;
        0=>int line_nb;
        1=>int no_error;
        
        0=>int common_tok;
        0=>int dur_tok;
        0=>int slide_tok;
        0=>int blank_line;
        0=>float prev_freq;
        0=>int comment;
        
        0=>int scale_nb;
        30=>int ref_note;
        // Gamme Majeur: 1 , 1 , 1/2 , 1 , 1 , 1 , 1/2 
        // Gamme Mineure: 1 , 1/2 , 1 , 1 , 1/2 , 1 et 1/2 , 1/2
        // Gamme Pentatonique Majeure: 1 ton - 1 ton - 1 ton et demi - 1 ton - 1 ton et demi
        // Gamme Pëntatonique Mineure: 1 ton et demi - 1 ton - 1 ton - 1 ton et demi - 1 ton.
        // Blues 1 ton et demi - 1 ton - 1 demi ton - 1 demi ton - 1 ton - 1 ton et demi - 1 ton.
        [[2,2,3,2,3],     //Pentatonique Majeure
         [2,2,1,2,2,2,1], //Gamme Majeur
         [2,1,2,2,1,3,1], // Gamme Mineur
         [3,2,2,3,2],     // Gamme Pentatonique Mineure
         [3,2,1,1,2,3,2], // Blues
         [1,1]            // All notes
         ]@=> int scales_a[][];
        
        // open a file
        fio.open( file_path, FileIO.READ );

        if( !fio.good() ){
            cherr <= "can't open file: " <= file_path <= " for reading..."
                  <= IO.newline();
            me.exit();
        }

        // init rythm
        rythm_o.constructor();
        
        // init arrays
        0=>freq_a.size;
        0=>freq_dur_a.size;
        0=>slide_a.size;
        0=>note_dur_a.size;
        0=>note_on_a.size;
        
        while( fio.more() && no_error  )
        {
            //chout <= fio.readLine() <= IO.newline();
              fio.readLine() => new_line;
              <<<"line number:",++line_nb>>>;
             //<<<"new_line", new_line>>>;
             tok.set(new_line);

            0=>dur_tok;
            0=>slide_tok;
            0=>comment;
            0=>common_tok;
            1=>blank_line;
             
             while( tok.more() && no_error && !comment )
            {
                0=>blank_line;
            
                 tok.next() => id_cmd;
                 //<<<"tok",id_cmd>>>;
                 if      (id_cmd == "NOTE") {
                        // freq
                        Std.atof(tok.next())=>val;
                        freq_a<<Std.mtof(val);
                        freq_a[freq_a.size()-1] => prev_freq; 
                        slide_a<<0;
                        
                        // env
                        note_on_a<<1;
                    }
                 else if (id_cmd == "DUR") {
                        Std.atof(tok.next())=>val; 
                        freq_dur_a<<(val * rythm_o.tick_delay);
                        1 => dur_tok;

                        // env
                        if (slide_tok) 
                            val * rythm_o.tick_delay +=> note_dur_a[note_dur_a.size()-1];
                        else
                            note_dur_a<<(val * rythm_o.tick_delay);
                            
                        }
                 else if (id_cmd == "REST") {
                        freq_a<<prev_freq;
                        slide_a<<0;
                        
                        // env
                        note_on_a<<0;
                        }
                 else if (id_cmd == "NOTE_REL") {
                        Std.atoi(tok.next())=>val_i; 
                        freq_a<<Std.mtof( conv_to_note(val_i, scales_a[scale_nb], ref_note));
                        freq_a[freq_a.size()-1] => prev_freq; 
                        slide_a<<0;

                        // env
                        note_on_a<<1;
                        }
                 else if (id_cmd == "SLIDE") {
                        // freq
                        Std.atof(tok.next())=>val;
                        freq_a<<Std.mtof(val);
                        freq_a[freq_a.size()-1] => prev_freq; 
                        slide_a<<1;
                        1=>slide_tok;
                        }
                 else if (id_cmd == "SLIDE_REL") {
                        // freq
                        Std.atoi(tok.next())=>val_i; 
                        freq_a<<Std.mtof( conv_to_note(val_i, scales_a[scale_nb], ref_note));
                        freq_a[freq_a.size()-1] => prev_freq; 
                        slide_a<<1;
                        1=>slide_tok;
                        }
                 else if (id_cmd == "REF_NOTE") {
                        Std.atoi(tok.next())=>ref_note; 
                        <<<"ref_note",ref_note>>>;
                        
                        1 => common_tok;
                        }
                 else if (id_cmd == "SCALE") {
                        tok.next()=>val_s;
                        //Pentatonique Majeure
                        if (val_s == "PENTA_MAJ") 0 => scale_nb;
                        //Gamme Majeur
                        else if (val_s == "MAJ") 1 => scale_nb;
                        // Gamme Mineur
                        else if (val_s == "MIN") 2 => scale_nb;
                        // Gamme Pentatonique Mineure
                        else if (val_s == "PENTA_MIN") 3 => scale_nb;
                        // Blues
                        else if (val_s == "BLUES") 4 => scale_nb;
                        // All notes
                        else if (val_s == "ALL") 5 => scale_nb;
                        else <<<"\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n!!ERROR: ", val_s," scale is undefined!!\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!">>>;
                        <<<"scale_nb",scale_nb>>>;

                        1 => common_tok;
                        }
                 else if (id_cmd == "#") {
                        1 => comment;

                        1 => common_tok;
                        }
                 else {<<<"\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n!!ERROR: line",line_nb,",  ", id_cmd,"comand is undefined!!\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!">>>; 0=>no_error;
                        1 => common_tok;
                    }   
                 
                 
            }       
    
            if (!common_tok && !blank_line)
                if (!dur_tok){
                    freq_dur_a << rythm_o.tick_delay;
                    if (slide_tok)
                        rythm_o.tick_delay +=> note_dur_a[note_dur_a.size()-1];
                    else
                        note_dur_a << rythm_o.tick_delay;
                    }

        }
        
        // verify first freq
        if (freq_a[0] == 0) freq_a[freq_a.size() - 1]=>freq_a[0];
        
        if (freq_a.size() != freq_dur_a.size()) <<<"\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\nERROR: freq_a.size()",freq_a.size()," != freq_dur_a.size()",freq_dur_a.size(),"\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n">>>;
        if (note_on_a.size() != note_dur_a.size()) <<<"\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\nERROR: note_on_a.size()",note_on_a.size()," != note_dur_a.size()",note_dur_a.size(),"\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n">>>;
        fio.close( );   
    }

    fun void play_freq(int nb_loop) {
        0=>int infinite_loop;
        0=> int i;
        
        if (nb_loop == 0) {1=>infinite_loop; 1=>nb_loop;}
       
        while (nb_loop > 0 || infinite_loop) {
            if (!slide_a[i]){
                freq_a[i] => freq_guide_u.value;
            }
            else {
                freq_a[i] => freq_guide_u.target;
                freq_dur_a[i] => freq_guide_u.duration;
            }
            
            freq_dur_a[i] => now;
            (i+1)%freq_a.size() => i;
            if (i == 0 && !infinite_loop) nb_loop--;
        }
    }

    // Functions to extend
    fun void note_on_ext(int note_idx){}
    fun void note_off_ext(int note_idx){}

    
    fun void play_env(int nb_loop) {
        0=>int infinite_loop;
        0=> int i;    
        if (nb_loop == 0) {1=>infinite_loop; 1=>nb_loop;}
       
        while (nb_loop > 0 || infinite_loop) {
            if(note_on_a[i]){
                env_u.keyOn();
                note_on_ext(i);
            }
            else {
                env_u.keyOff();
                note_off_ext(i);
            }            
            note_dur_a[i] => now;
            (i+1)%note_on_a.size() => i;
            if (i == 0 && !infinite_loop) nb_loop--;
        }
        
        // off
        <<<"OFF">>>;
        env_u.keyOff();
        note_off_ext(666);

    }
    
    
    fun UGen freq(){
        return freq_guide_u;
        }
    
    fun UGen env(UGen @ in) {
        Gain out;
        in => env_u => out;
        return out;
        }
    
    fun void run(int nb_loop){
        spork ~ play_freq(nb_loop);
        spork ~ play_env(nb_loop);
        

    }
}

part_decode part;

part.convert_part("test.pt");
for (0 => int i; i<part.freq_a.size(); i++) <<<"part.freq_a[",i,"]",part.freq_a[i]>>>;
for (0 => int i; i<part.freq_dur_a.size(); i++) <<<"part.freq_dur_a[",i,"]",part.freq_dur_a[i]>>>;
for (0 => int i; i<part.slide_a.size(); i++) <<<"part.slide_a[",i,"]",part.slide_a[i]>>>;
for (0 => int i; i<part.note_on_a.size(); i++) <<<"part.note_on_a[",i,"]",part.note_on_a[i]>>>;
for (0 => int i; i<part.note_dur_a.size(); i++) <<<"part.note_dur_a[",i,"]",part.note_dur_a[i]>>>;

part.freq() => SqrOsc s => part.env => dac;
s.gain(0.3);
part.run(1);



while (1){ 1::ms => now; }























