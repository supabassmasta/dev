"
set mouse =a
set number
set autowrite


set backspace=indent,eol,start " allow backspace in insert mode
set autoindent    " text indenting
set smartindent   " as above
"set softtabstop=4 " as above

set history=100   " lines of command history
set showcmd       " show incomplete commands
set hlsearch      " highlight searched-for phrases
set incsearch     " highlight search as you type
set smarttab
set tabstop=2
set shiftwidth=2
set expandtab
"set list " affiche les caracteres louches
set guifont=Monospace\ 13

" highlight current position
set cursorline
highlight CursorLine guibg=#001000
colorscheme  evening " set up a color scheme in the gvim interface 
syntax on " active the syntaxic coloration
highlight Cursor guifg=black guibg=orange
highlight iCursor guifg=black guibg=orange

"let mywinfont="Monospace:h8:cANSI"
" Switch to alternate file
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>
map <C-s> :w<cr>b
map <C-d> <C-]>
map <C-Q> <Esc>0i//<Esc>
map <C-f> :tnext<cr>

" vim shell to use bash: DO NOT WORK
"set shell=/bin/bash\ -l

" Search CArrier return
" /\n
" Then replace it by litteral CR
" :%s//\<CR\>/g

" recursive grep of visual register then open result list
"map <C-f> <esc> :exe 'gr -r ' . @* . ' *' <cr> :cw<cr>

" Dirty uncomment
"map   <C-E>         0xx

" Comment line, go next line, uncomment
"map	 <C-C>         <C-Q>j<C-E>

" Copy buffer 'a' at begining of line, buffer 'z' at end
"map   <C-G>         0"aP$"zpj   

:command BW bp | sp | bn | bd
:command VIMRC e ~/.vimrc 
:command SRC  source ~/.vimrc
   
"ab C
ab whilec while( ){<CR>  <CR>}<Up><Up><Right><Right><Right><Right><Right> 

ab forc for (i=0; i< ; i++){<CR>  <CR>}<Up><Up><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right>

ab ifc if (  ){<CR>  <CR>}<Up><Up><Right><Right><Right>

ab elsec else {<CR>  <CR>}<Up>
ab elseifc else if (  ){<CR>  <CR>}<Up><Up><Right><Right><Right><Right><Right><Right><Right><Right> 

ab fopenc FILE *fp;
\<CR>fp=fopen("", "r");
\<CR>
\<CR>//while( fscanf(fp, "%s", buf) != -1) { };
\<CR>//fprintf(fp, "%s\n", buf);
\<CR>
\<CR>fclose(fp);

ab mainc int main(int argc, char *argv[]) {<CR>  <CR>}<Up>

	 



" revert selection in a line: type r quickly after ;
vnoremap ;r c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>

" Python ab
ab headerY #! /usr/bin/env python
\<CR># -*- coding: UTF-8 -*-

" ab ChucK
ab  forK          for (0 => int i; i <       ; i++) {
\<CR>}
\<CR>

ab  funK          fun void f1 (){ 
\<CR>
\<CR> } 
\<CR>spork ~ f1 ();
\<CR>

ab  whileK           while(1) {
\<CR>     100::ms => now;
\<CR>}
\<CR>

ab  syncK          => dur Tsync; Tsync - (now % Tsync ) => now; 
\<CR>

ab  seqK seqSndBuf s2 =>Gain g=> dac;
\<CR>.2=>g.gain;
\<CR>1=>s2.gain;
\<CR>"../../examples/data/snare-hop.wav"=> s2.read;
\<CR>s2.rel_dur  << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5        << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5  ;
\<CR>s2.g        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0     ;
\<CR>//s2.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
\<CR>data.bpm => s2.bpm;
\<CR>0 => s2.sync_on;
\<CR>s2.go();
\<CR>data.meas_size * data.tick => now;
\<CR>


ab seq4K seqSndBuf s2 =>Gain g=> dac;
\<CR>.2=>g.gain;
\<CR>1=>s2.gain;
\<CR>"../../examples/data/amen-hit.wav"=> s2.read;
\<CR>s2.rel_dur  << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5        << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5  ;
\<CR>s2.g        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0     ;
\<CR>//s2.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
\<CR>data.bpm => s2.bpm;
\<CR>0 => s2.sync_on;
\<CR>s2.go();
\<CR>
\<CR>seqSndBuf s3 =>g;
\<CR>.2=>g.gain;
\<CR>1=>s3.gain;
\<CR>"../../examples/data/amen-snare.wav"=> s3.read;
\<CR>s3.rel_dur  << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5        << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5  ;
\<CR>s3.g        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0     ;
\<CR>//s3.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
\<CR>data.bpm => s3.bpm;
\<CR>0 => s3.sync_on;
\<CR>s3.go();
\<CR>
\<CR>seqSndBuf s4 =>g;
\<CR>.2=>g.gain;
\<CR>1=>s4.gain;
\<CR>"../../examples/data/amen-kick.wav"=> s4.read;
\<CR>s4.rel_dur  << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5        << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5  ;
\<CR>s4.g        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0     ;
\<CR>//s4.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
\<CR>data.bpm => s4.bpm;
\<CR>0 => s4.sync_on;
\<CR>s4.go();
\<CR>
\<CR>seqSndBuf s5 =>g;
\<CR>.2=>g.gain;
\<CR>1=>s5.gain;
\<CR>"../../examples/data/amen-hat.wav"=> s5.read;
\<CR>s5.rel_dur  << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5        << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5  ;
\<CR>s5.g        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0        << .0 << .0 << .0 << .0      << .0 << .0 << .0 << .0     ;
\<CR>//s5.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
\<CR>data.bpm => s5.bpm;
\<CR>0 => s5.sync_on;
\<CR>s5.go();
\<CR>data.meas_size * data.tick => now;
\<CR> 
\<CR>
\<CR>
 


ab freqK class synt_def extends Chubgraph{
\<CR>
\<CR>// ****  SYNT *****
\<CR>inlet => SinOsc s => outlet;	
\<CR>
\<CR>    fun void on(/* float p1 */)  {   /*<<<"synt_def on">>>; */	         }
\<CR>fun void off() {	    /* <<<"synt_def off">>>;*/         }
\<CR>fun void new_note(/* float p1 */)  {   	/* <<<"synt_def new_note">>>;*/         }
\<CR>}
\<CR>
\<CR>// SEQ
\<CR>
\<CR>FREQ freq_seq;
\<CR>freq_seq.freq => synt_def  synt_u=> freq_seq.adsr => Gain g => dac;
\<CR>
\<CR>0=> freq_seq.sync_on;
\<CR>.03 => g.gain;
\<CR>freq_seq.rel_note  << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
\<CR>freq_seq.g         <<.9 <<.9 <<.9 <<.9      <<.9 <<.9 <<.9 <<.9      <<.9 <<.9 <<.9 <<.9     <<.9 <<.9 <<.9 <<.9     ;
\<CR>//freq_seq.g         <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
\<CR>//freq_seq.slide     << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
\<CR>//freq_seq.rel_dur   <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
\<CR>//freq_seq.note      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
\<CR>//freq_seq.param[0]    <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
\<CR>
\<CR>data.ref_note => freq_seq.base_note;
\<CR>data.scale.my_string => freq_seq.scale;
\<CR>data.bpm => freq_seq.bpm;
\<CR>
\<CR>// On off synt_def management
\<CR>fun void call_on() {  while (1){ freq_seq.start_ev => now;  spork ~ synt_u.on(/*freq_seq.get_param(0)*/);	}  } spork ~ call_on();
\<CR>fun void call_off(){  while (1){ freq_seq.stop_ev => now;   spork ~ synt_u.off();	}  } spork ~ call_off();
\<CR>fun void new_note(){  while (1){ freq_seq.new_ev => now;   spork ~ synt_u.new_note(/*freq_seq.get_param(0)*/);		}  } spork ~ new_note();
\<CR>
\<CR>freq_seq.go();
\<CR>
\<CR>data.meas_size * data.tick => now;

ab seqsK seq_script seq_s;
\<CR>"./script.ck" => seq_s.read;
\<CR>0=> seq_s.sync_on;
\<CR>seq_s.g         << 0. << 0. << 0. << 0.       << 0. << 0. << 0. << 0.       << 0. << 0. << 0. << 0.      << 0. << 0. << 0. << 0.; 
\<CR>//seq_s.rel_dur   << 0. << 0. << 0. << 0.       << 0. << 0. << 0. << 0.       << 0. << 0. << 0. << 0.      << 0. << 0. << 0. << 0.; 
\<CR>data.bpm => seq_s.bpm;
\<CR>
\<CR>seq_s.go();
\<CR>
\<CR>data.meas_size * data.tick => now;


ab seqcK class synt_chord extends Chubgraph{
\<CR>
\<CR>	// ****  SYNT *****
\<CR>	inlet => SinOsc s => outlet;	
\<CR>
\<CR>    fun void on(/* float p1 */)  {   /*<<<"synt_def on">>>; */	         }
\<CR>fun void off() {	    /* <<<"synt_def off">>>;*/         }
\<CR>fun void new_note(/* float p1 */)  {   	/* <<<"synt_def new_note">>>;*/         }
\<CR>}
\<CR>
\<CR>// SEQ
\<CR>
\<CR>chord chord_1;
\<CR>FREQ freq_chord;
\<CR>freq_chord.freq => chord_1.fondamental =>  synt_chord  s0 => Gain plus => freq_chord.adsr => Gain g => dac;
\<CR>chord_1.third() => synt_chord  s1 => plus; 
\<CR>chord_1.fifth() => synt_chord  s2 => plus; 
\<CR>chord_1.seventh() => synt_chord s3 => plus; 
\<CR>
\<CR>chord_1.set_chord(2);
\<CR>
\<CR>/* Chords number
\<CR>0  reset chord 
\<CR>
\<CR>1 Major triad
\<CR>2 Minor triad
\<CR>3 Augmented triad
\<CR>4 Diminished triad
\<CR>
\<CR>5  Diminished seventh
\<CR>6  Half-diminished seventh 
\<CR>7  Minor seventh
\<CR>8  Minor major seventh
\<CR>9  Dominant seventh
\<CR>10 Major seventh
\<CR>11 Augmented seventh
\<CR>12 Augmented major seventh
\<CR>*/
\<CR>
\<CR>0=> freq_chord.sync_on;
\<CR>.03 => g.gain;
\<CR>
\<CR>freq_chord.rel_note  << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
\<CR>freq_chord.g         <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
\<CR>//freq_chord.g         <<.9 <<.9 <<.9 <<.9      <<.9 <<.9 <<.9 <<.9      <<.9 <<.9 <<.9 <<.9     <<.9 <<.9 <<.9 <<.9     ;
\<CR>//freq_chord.slide     << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
\<CR>//freq_chord.rel_dur   <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
\<CR>//freq_chord.note      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0      << 0 << 0 << 0 << 0     << 0 << 0 << 0 << 0     ;
\<CR>//freq_chord.param[0]    <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0      <<.0 <<.0 <<.0 <<.0     <<.0 <<.0 <<.0 <<.0     ;
\<CR>
\<CR>data.ref_note => freq_chord.base_note;
\<CR>data.scale.my_string => freq_chord.scale;
\<CR>data.bpm  => freq_chord.bpm;
\<CR>
\<CR>// On off synt_chord management
\<CR>fun void call_on() {  while (1){ freq_chord.start_ev => now;   spork ~ s0.on(/*freq_chord.get_param(0)*/);  spork ~ s1.on(/*freq_chord.get_param(0)*/);  spork ~ s2.on(/*freq_chord.get_param(0)*/);	spork ~ s3.on(/*freq_chord.get_param(0)*/);		}  } spork ~ call_on();
\<CR>fun void call_off(){  while (1){ freq_chord.stop_ev => now;   spork ~ s0.off();	spork ~ s1.off();	spork ~ s2.off();	spork ~ s3.off();		}  } spork ~ call_off();
\<CR>fun void new_note(){  while (1){ freq_chord.new_ev => now;   spork ~ s0.new_note(/*freq_chord.get_param(0)*/);	spork ~ s1.new_note(/*freq_chord.get_param(0)*/);	spork ~ s2.new_note(/*freq_chord.get_param(0)*/);	spork ~ s3.new_note(/*freq_chord.get_param(0)*/);		}  } spork ~ new_note();
\<CR>
\<CR>freq_chord.go();
\<CR>
\<CR>data.meas_size * data.tick => now;  


ab lpd8K class lpd8_ext extends lpd8 {
\<CR>    // PADS
\<CR>fun void pad_ext (int group_no, int pad_nb, int val) {
\<CR>   if (group_no == 144) {
\<CR>36-=> pad_nb;
\<CR>
\<CR>if (pad_nb  == 0)      {}   
\<CR>else if (pad_nb  == 1) {}
\<CR>else if (pad_nb  == 2) {}
\<CR>else if (pad_nb  == 3) {}
\<CR>else if (pad_nb  == 4) {}
\<CR>else if (pad_nb  == 5) {}
\<CR>else if (pad_nb  == 6) {}
\<CR>else if (pad_nb  == 7) {}
\<CR>    }
\<CR>}
\<CR>
\<CR>    // POTARS
\<CR>fun void potar_ext (int group_no, int pad_nb, int val) {
\<CR>    if (group_no == 176) {
\<CR>
\<CR>if (pad_nb  == 0)      {}   
\<CR>else if (pad_nb  == 1) {}
\<CR>else if (pad_nb  == 2) {}
\<CR>else if (pad_nb  == 3) {}
\<CR>else if (pad_nb  == 4) {}
\<CR>else if (pad_nb  == 5) {}
\<CR>else if (pad_nb  == 6) {}
\<CR>else if (pad_nb  == 7) {}
\<CR>	}    
\<CR>}
\<CR>}
\<CR>
\<CR>lpd8_ext lpd;
\<CR>
\<CR>while (1) 1::second => now;
 

ab multiK 8 => int synt_nb; 0 => int i;
\<CR>Gain detune[synt_nb];
\<CR>SinOsc s[synt_nb];
\<CR>Gain final => outlet; .3 => final.gain;
\<CR>
\<CR>inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++; 


ab SYNTK class synt0 extends SYNT{
\<CR>
\<CR>	inlet => SinOsc s =>  outlet;	
\<CR>	.5 => s.gain;
\<CR>
\<CR>	fun void on()  { } 	fun void off() { } 	fun void new_note(int idx)  {	} 0 => own_adsr;
\<CR>}


ab FREQ_STRK class synt0 extends SYNT{
\<CR>
\<CR>	inlet => SinOsc s =>  outlet;	
\<CR>	.5 => s.gain;
\<CR>
\<CR>	fun void on()  { } 	fun void off() { } 	fun void new_note(int idx)  {	}
\<CR>}
\<CR>
\<CR>
\<CR>FREQ_STR f0; //8 => f0.max; 1=> f0.sync;
\<CR>"" =>     f0.seq;     
\<CR>f0.reg(synt0 s0);
\<CR>//f0.post()  => dac;
\<CR>
\<CR>while(1) {  100::ms => now; }
\<CR>//data.meas_size * data.tick => now;

ab ENDK class END extends end { fun void kill_me () {
\<CR>		<<<"THE END">>>; 	
\<CR>		1500::ms => now;	
\<CR>		<<<"THE real END">>>; 	
\<CR>}}; END the_end; me.id() => the_end.shred_id; killer.reg(the_end); 

ab <<< <<<"">>>;<CR><Up><Right><Right><Right><Right>

ab SEQ_STRK SEQ_STR s0; // 4 => s0.max; 0 => s0.sync;
\<CR>
\<CR>s0.reg(0, "../_SAMPLES/amen_kick.wav");
\<CR>s0.reg(1, "../_SAMPLES/amen_snare.wav");
\<CR>s0.reg(2, "../_SAMPLES/amen_snare2.wav");
\<CR>s0.reg(3, "../_SAMPLES/amen_hit.wav");
\<CR>//s0.reg("A", "../_SAMPLES/REGGAE_SET_1/Timbales1_Reaggae1.wav");
\<CR>
\<CR>"" => s0.seq; //s0.post() =>  dac;
\<CR>
\<CR>s0.go();
\<CR>while(1) { 100::ms => now; }
\<CR>//data.meas_size * data.tick => now;


ab gverbK GVerb gverb0  =>
\<CR>30 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
\<CR>1::second => gverb0.revtime;   // revtime: (dur), default 5::second
\<CR>0.8 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
\<CR>0.5 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
\<CR>0.3 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5      

ab TONEK TONE t;
\<CR>t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
\<CR>// _ = pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
\<CR>"1" => t.seq;
\<CR>.9 * data.master_gain => t.gain;
\<CR>//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
\<CR>// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
\<CR>//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
\<CR>//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>t.go();   t $ ST @=> ST @ last;

ab SEQK SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
\<CR>// _ = pause , ~ = special pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
\<CR>"" => s.seq;
\<CR>.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
\<CR>//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
\<CR>// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
\<CR>s.go();     s $ ST @=> ST @ last;
 

ab MODK class synt0 extends SYNT{
\<CR>    inlet => Gain in;
\<CR>Gain out =>  outlet;   
\<CR>
\<CR>0 => int i;
\<CR>Gain opin[8];
\<CR>Gain opout[8];
\<CR>ADSR adsrop[8];
\<CR>SinOsc osc[8];
\<CR>
\<CR>// build and config operators
\<CR>//---------------------
\<CR>opin[i] => osc[i] => adsrop[i] => opout[i];
\<CR>1. => opin[i].gain;
\<CR>adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
\<CR>1 => adsrop[i].gain;
\<CR>i++;
\<CR>
\<CR>//---------------------
\<CR>opin[i] => osc[i] => adsrop[i] => opout[i];
\<CR>1./2. + 0.00 => opin[i].gain;
\<CR>adsrop[i].set(10::ms, 100::ms, .1 , 200::ms);
\<CR>100 * 3 => adsrop[i].gain;
\<CR>i++;
\<CR>
\<CR>//---------------------
\<CR>opin[i] => osc[i] => adsrop[i] => opout[i];
\<CR>1./8. +0.0 => opin[i].gain;
\<CR>adsrop[i].set(100::ms, 186::ms, .5 , 1800::ms);
\<CR>8 => adsrop[i].gain;
\<CR>i++;
\<CR>
\<CR>//---------------------
\<CR>opin[i] => osc[i] => adsrop[i] => opout[i];
\<CR>1./2. +0.000 => opin[i].gain;
\<CR>adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
\<CR>30 => adsrop[i].gain;
\<CR>i++;
\<CR>
\<CR>// connect operators
\<CR>// main osc
\<CR>in => opin[0]; opout[0]=> out; 
\<CR>
\<CR>// modulators
\<CR>in => opin[1];
\<CR>opout[1] => opin[0];
\<CR>
\<CR>in => opin[2];
\<CR>// opout[2] => opin[0];
\<CR>
\<CR>in => opin[3];
\<CR>// opout[3] => opin[0];
\<CR>
\<CR>
\<CR>.5 => out.gain;
\<CR>
\<CR>fun void on()  
\<CR>{
\<CR>  for (0 => int i; i < 8      ; i++)
\<CR>{
\<CR>  adsrop[i].keyOn();
\<CR>// 0=> osc[i].phase;
\<CR>}
\<CR>      
\<CR>} 
\<CR>    
\<CR>fun void off() 
\<CR>{
\<CR>  for (0 => int i; i < 8      ; i++) 
\<CR>{
\<CR>  adsrop[i].keyOff();
\<CR>}
\<CR>            
\<CR>      
\<CR>} 
\<CR>    
\<CR>fun void new_note(int idx)  
\<CR>{ 
\<CR>         
\<CR>}
\<CR> 0 => own_adsr;
\<CR>} 


ab STECHOK STECHO ech;
\<CR>ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last;

ab STREV1K STREV1 rev;
\<CR>rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last;

ab STREV2K STREV2 rev; // DUCKED
\<CR>rev.connect(last $ ST, .3 /* mix */);      rev $ ST @=>  last;


ab STAUTOPANK STAUTOPAN autopan;
\<CR>autopan.connect(last $ ST, .9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last;

ab POLYK lpk25 l;
\<CR>POLY synta; 
\<CR>l.reg(synta);
\<CR>synta.reg(synt0 s0);  synta.a[0].set(3::ms, 30::ms, .7, 100::ms);
\<CR>synta.reg(synt0 s1);  synta.a[1].set(3::ms, 30::ms, .7, 100::ms);
\<CR>synta.reg(synt0 s2);  synta.a[2].set(3::ms, 30::ms, .7, 100::ms);
\<CR>synta.reg(synt0 s3);  synta.a[3].set(3::ms, 30::ms, .7, 100::ms);

ab GLIDEK lpk25 l;
\<CR>GLIDE synta; 20::ms => synta.duration;	300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
\<CR>l.reg(synta);
\<CR>synta.reg(synt0 s0);


ab STDUCKMASTERK STDUCKMASTER duckm;
\<CR>duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last;

ab STDUCKK STDUCK duck;
\<CR>duck.connect(last $ ST);      duck $ ST @=>  last;

ab STDIGITK STDIGIT dig;
\<CR>dig.connect(last $ ST , 1::samp /* sub sample period */ , .01 /* quantization */);      dig $ ST @=>  last;

ab STECHOCK STECHOC ech;
\<CR>ech.connect(last $ ST , HW.lpd8.potar[1][1] /* Period */ , HW.lpd8.potar[1][2] /* Gain */ );      ech $ ST @=>  last; 

ab STECHOC0K STECHOC0 ech;
\<CR>ech.connect(last $ ST , data.tick * 3 / 4  /* period */ , HW.lpd8.potar[1][4] /* Gain */ );      ech $ ST @=>  last;  

ab STLPFCK STLPFC lpfc;
\<CR>lpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lpfc $ ST @=>  last;

ab STLHPFCK STLHPFC lhpfc;
\<CR>lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last;

ab STECHOLHPFCK STECHOLHPFC echolpfc;
\<CR>echolpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */ , data.tick * 3. / 4. , HW.lpd8.potar[1][3] /* Delay Gain */ );       echo  lpfc $ ST @=>  last; 


ab STLPFK STLPF lpf;
\<CR>lpf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last;

ab STDLK STWPDiodeLadder stdl;
\<CR>stdl.connect(last $ ST , 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last;

ab STKORGK STWPKorg35 stkorg;
\<CR>stkorg.connect(last $ ST , 1000 /* cutoff */  , 1.2 /* /!\ < 1.7 !!!!!! resonance */ , true /* nonlinear */ );       stkorg $ ST @=>  last;


ab STBPFCK STBPFC bpfc;
\<CR>bpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       bpfc $ ST @=>  last;

ab STBPFK STBPF bpf;
\<CR>bpf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       bpf $ ST @=>  last;


ab STHPFCK STHPFC hpfc;
\<CR>hpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       hpfc $ ST @=>  last;

ab STHPFK STHPF hpf;
\<CR>hpf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last;

ab STBRFCK STBRFC brfc;
\<CR>brfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       brfc $ ST @=>  last;

ab STBRFK STBRF brf;
\<CR>brf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       brf $ ST @=>  last;

ab STRESCK STRESC resc;
\<CR>resc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );     resc  $ ST @=>  last; 

ab STRESK STRES res;
\<CR>res.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );     res  $ ST @=>  last; 

ab STGAINCK STGAINC gainc;
\<CR>gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last;

ab STGAINK STGAIN stgain;
\<CR>stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last;

ab RECK REC rec;
\<CR>rec.rec(8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */);
\<CR>//rec.rec_no_sync(8*data.tick, "test.wav");

ab STDIGITCK STDIGITC dig;
\<CR>dig.connect(last $ ST , HW.lpd8.potar[1][1] /* sub sample period */ , HW.lpd8.potar[1][2] /* quantization */);      dig $ ST @=>  last;

ab STADSRCK STADSRC stadsrc;
\<CR>stadsrc.connect(last, HW.launchpad.keys[16*0 + 0] /* pad 1:1 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last;


ab FILTERMODK // filter to add in graph:
\<CR>// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
\<CR>Step base => Gain filter_freq => blackhole;
\<CR>Gain mod_out => Gain variable => filter_freq;
\<CR>SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;
\<CR>
\<CR>// params
\<CR>4 => filter.Q;
\<CR>161 => base.next;
\<CR>551 => variable.gain;
\<CR>1::second / (data.tick * 4 ) => mod.freq;
\<CR>// If mod need to be synced
\<CR>// 1 => int sync_mod;
\<CR>// if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }
\<CR>
\<CR>fun void filter_freq_control (){ 
\<CR>    while(1) {
\<CR>      filter_freq.last() => filter.freq;
\<CR>      1::ms => now;
\<CR>    }
\<CR>}
\<CR>spork ~ filter_freq_control ();

ab FILTERADSRK // Filter to add in graph
\<CR>// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
\<CR>Step base => Gain filter_freq => blackhole;
\<CR>Step variable => PowerADSR padsr => filter_freq;
\<CR>
\<CR>// Params
\<CR>padsr.set(data.tick / 4 , data.tick / 4 , .0000001, data.tick / 4);
\<CR>padsr.setCurves(2.0, 2.0, .5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>1 => filter.Q;
\<CR>48 => base.next;
\<CR>3300 => variable.next;
\<CR>
\<CR>// ADSR Trigger
\<CR>//padsr.keyOn(); padsr.keyOff();
\<CR>
\<CR>// fun void auto_off(){
\<CR>//     data.tick / 4 => now;
\<CR>//     padsr.keyOff();
\<CR>// }
\<CR>// spork ~ auto_off();
\<CR>
\<CR>fun void filter_freq_control (){ 
\<CR>    while(1) {
\<CR>      filter_freq.last() => filter.freq;
\<CR>      1::ms => now;
\<CR>    }
\<CR>} 
\<CR>spork ~ filter_freq_control ();


ab ACTIONK class ACT extends ACTION {
\<CR>  fun int on_time() {
\<CR>    <<<"test">>>; 
\<CR>  }
\<CR>}
\<CR>
\<CR>ACT act;

ab CONTROLLERK // CONTROLLERS:
\<CR>// HW.lpd8.potar[1][1]   HW.lpd8.pad[1][1]  
\<CR>// HW.kb.updown          HW.kb.leftright
\<CR>// HW.nano.potar[1][1]   HW.nano.fader[1][1]      HW.nano.button_up[1][1]   HW.nano.button_down[1][1]
\<CR>// HW.nano.button_back   HW.nano.button_play   HW.nano.button_forward   HW.nano.button_loop    HW.nano.button_stop   HW.nano.button_rec
\<CR>// HW.launchpad.keys[16*0 + 0] /* pad 1:1 */  HW.launchpad.controls[1] /* ? */ 
\<CR>// HW.launchpad.red[16*0 + 0]   HW.launchpad.green[16*0 + 0]   HW.launchpad.amber[16*0 + 0]   HW.launchpad.clear[16*0 + 0]
\<CR>// HW.launchpad.redc[?]  HW.launchpad.greenc[?]  HW.launchpad.amberc[?]  HW.launchpad.clearc[?]   


ab ACTIONSNDBUFK ST st;
\<CR>SndBuf buf => st.mono_in;
\<CR>"../_SAMPLES/HIHAT_02.WAV" => buf.read;
\<CR>.2 => buf.gain;
\<CR>buf.samples() => buf.pos;
\<CR>//100./110. => buf.rate;
\<CR>
\<CR>class ACT extends ACTION {
\<CR>    SndBuf @ sb;
\<CR>    fun int on_time() {
\<CR>        0=> sb.pos;
\<CR>        <<<"test">>>; 
\<CR>    }
\<CR>}
\<CR>
\<CR>ACT act; 
\<CR>buf @=> act.sb;

ab PMODK class synt0 extends SYNT{
\<CR>  inlet => Gain in;
\<CR>Gain out =>  outlet;   
\<CR>
\<CR>0 => int i;
\<CR>Gain opin[8];
\<CR>Gain opout[8];
\<CR>PowerADSR adsrop[8];
\<CR>SinOsc osc[8];
\<CR>
\<CR>// build and config operators
\<CR>//---------------------
\<CR>opin[i] => osc[i] => adsrop[i] => opout[i];
\<CR>1. => opin[i].gain;
\<CR>adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
\<CR>adsrop[i].setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>1 => adsrop[i].gain;
\<CR>i++;
\<CR>
\<CR>//---------------------
\<CR>opin[i] => osc[i] => adsrop[i] => opout[i];
\<CR>1./2. + 0.03 => opin[i].gain;
\<CR>adsrop[i].set(1.5*data.tick, 1.5*data.tick, .00001 , 200::ms);
\<CR>adsrop[i].setCurves(.2, .2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>100 * 3 => adsrop[i].gain;
\<CR>i++;
\<CR>
\<CR>//---------------------
\<CR>opin[i] => osc[i] => adsrop[i] => opout[i];
\<CR>1./8. +0.0 => opin[i].gain;
\<CR>adsrop[i].set(100::ms, 186::ms, .5 , 1800::ms);
\<CR>adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>8 => adsrop[i].gain;
\<CR>i++;
\<CR>
\<CR>//---------------------
\<CR>opin[i] => osc[i] => adsrop[i] => opout[i];
\<CR>1./2. +0.000 => opin[i].gain;
\<CR>adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
\<CR>adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>30 => adsrop[i].gain;
\<CR>i++;
\<CR>
\<CR>// connect operators
\<CR>// main osc
\<CR>in => opin[0]; opout[0]=> out; 
\<CR>
\<CR>// modulators
\<CR>in => opin[1];
\<CR>opout[1] => opin[0];
\<CR>
\<CR>in => opin[2];
\<CR>// opout[2] => opin[0];
\<CR>
\<CR>in => opin[3];
\<CR>// opout[3] => opin[0];
\<CR>
\<CR>
\<CR>.5 => out.gain;
\<CR>
\<CR>fun void on()  
\<CR>{
\<CR>for (0 => int i; i < 8      ; i++)
\<CR>{
\<CR>    adsrop[i].keyOn();
\<CR>    // 0=> osc[i].phase;
\<CR>}
\<CR>      
\<CR>} 
\<CR>    
\<CR>fun void off() 
\<CR>{
\<CR>for (0 => int i; i < 8      ; i++) 
\<CR>{
\<CR>    adsrop[i].keyOff();
\<CR>}
\<CR>            
\<CR>                  
\<CR>} 
\<CR>    
\<CR>fun void new_note(int idx)  
\<CR>{ 
\<CR>           
\<CR>}
\<CR> 0 => own_adsr;
\<CR>} 

ab STFADEINK STFADEIN fadein;
\<CR>fadein.connect(last, 4*data.tick);     fadein  $ ST @=>  last;

ab STFILTERMODK STFILTERMOD fmod;
\<CR>fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 400  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last;

ab SATK ABSaturator sat   =>   
\<CR>2.0 => sat.drive;
\<CR>0.0 => sat.dcOffset;

ab STABSATURATORK STABSATURATOR stabsat;
\<CR>stabsat.connect(last, 5.0 /* drive */, 0.00 /* dc offset */); stabsat $ ST @=>  last;

ab CONTROLK class cont extends CONTROL {
\<CR>   // 0 =>  update_on_reg ;
\<CR>   fun void set(float in) {
\<CR>
\<CR>   }
\<CR>}

ab PowerADSRK PowerADSR padsr
\<CR>padsr.set(1::ms, 20::ms, .7 , 200::ms);
\<CR>padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

ab STBREAKK STBREAK stbreak;
\<CR>stbreak.connect(last $ ST, 0 /* break_number, max 3 */);   stbreak $ ST @=>last; 
\<CR>// To add in break script
\<CR>//Break.stbreak_set(0) @=> s.action["a"];  "" => s.wav["a"]; 
\<CR>//Break.stbreak_release(0) @=> s.action["b"]; "" => s.wav["b"];
\<CR>// Release a break : Break.release(0);

ab LONG_WAVK LONG_WAV l;
\<CR>"../_SAMPLES/" => l.read;
\<CR>1.0 * data.master_gain => l.buf.gain;
\<CR>0 => l.update_ref_time;
\<CR>l.AttackRelease(0::ms, 0::ms);
\<CR>l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last; 

ab SYNCK	SYNC sy;
\<CR>sy.sync(4 * data.tick);
\<CR>//sy.sync(4 * data.tick , 0::ms /* offset */);

ab STMIXK STMIX stmix;
\<CR>//stmix.send(last, 11);
\<CR>//stmix.receive(11); stmix $ ST @=> ST @ last;

ab STMULT_BASE_ONEK STMULT_BASE_ONE stmult;
\<CR>stmult.connect(last $ ST, stmix $ ST); stmult $ ST @=>  last;

ab STMULT_BASE_ZEROK STMULT_BASE_ZERO stmult;
\<CR>stmult.connect(last $ ST, stmix $ ST); stmult $ ST @=>  last;

ab STADSRK STADSR stadsr;
\<CR>stadsr.set(0::ms /* Attack */, 6::ms /* Decay */, .6 /* Sustain */, 100::ms /* Sustain dur */,  10::ms /* release */);
\<CR>stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;

ab STPADSRK STPADSR stpadsr;
\<CR>stpadsr.set(0::ms /* Attack */, 24::ms /* Decay */, .6 /* Sustain */, 10::ms /* Sustain dur */,  10::ms /* release */);
\<CR>stpadsr.setCurves(2, .7, .5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stpadsr.connect(last $ ST, s.note_info_tx_o); stpadsr $ ST @=>  last;

ab STSYNCLPFK STSYNCLPF stsynclpf;
\<CR>stsynclpf.freq(100 /* Base */, 3 * 100 /* Variable */, 4. /* Q */);
\<CR>stsynclpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last;

ab STSYNCBPFK STSYNCBPF stsyncbpf;
\<CR>stsyncbpf.freq(100 /* Base */, 9 * 100 /* Variable */, 4. /* Q */);
\<CR>stsyncbpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsyncbpf.connect(t $ ST, t.note_info_tx_o); stsyncbpf $ ST @=>  last; 

ab STSYNCHPFK STSYNCHPF stsynchpf;
\<CR>stsynchpf.freq(1000 /* Base */, 20 * 100 /* Variable */, 4. /* Q */);
\<CR>stsynchpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsynchpf.connect(t $ ST, t.note_info_tx_o); stsynchpf $ ST @=>  last; 

ab STSYNCBRFK STSYNCBRF stsyncbrf;
\<CR>stsyncbrf.freq(100 /* Base */, 31 * 100 /* Variable */, 1. /* Q */);
\<CR>stsyncbrf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsyncbrf.connect(t $ ST, t.note_info_tx_o); stsyncbrf $ ST @=>  last; 

ab STSYNCRESK STSYNCRES stsyncres;
\<CR>stsyncres.freq(100 /* Base */, 3 * 100 /* Variable */, 4. /* Q */);
\<CR>stsyncres.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsyncres.connect(t $ ST, t.note_info_tx_o); stsyncres $ ST @=>  last;

ab STSYNCLPF2K STSYNCLPF2 stsynclpf2;
\<CR>stsynclpf2.freq(100 /* Base */, 11 * 100 /* Variable */, 1.0 /* Q */);
\<CR>stsynclpf2.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsynclpf2.connect(t $ ST, t.note_info_tx_o); stsynclpf2 $ ST @=>  last;

ab STSYNCDLK STSYNCWPDiodeLadder stsyncdl;
\<CR>stsyncdl.freq(3*100 /* Base */, 5 * 100 /* Variable */, 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
\<CR>stsyncdl.adsr_set(.1 /* Relative Attack */, .7/* Relative Decay */, 0.00001 /* Sustain */, .0 /* Relative Sustain dur */, 0.0 /* Relative release */);
\<CR>stsyncdl.connect(t $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last; 

ab STSYNCKORGK STSYNCWPKorg35 stsynckorg;
\<CR>stsynckorg.freq(3*100 /* Base */, 2 * 100 /* Variable */, 1.1 /*   /!\ < 1.7 !!!!   resonance */ , true /* nonlinear */ );
\<CR>stsynckorg.adsr_set(.1 /* Relative Attack */, .7/* Relative Decay */, 0.00001 /* Sustain */, .0 /* Relative Sustain dur */, 0.0 /* Relative release */);
\<CR>stsynckorg.connect(t $ ST, t.note_info_tx_o); stsynckorg $ ST @=>  last; 

ab STRECCONVK STRECCONV strecconv;
\<CR>10 * 1000 => strecconv.inputl.gain => strecconv.inputr.gain; // input signal into reverb only
\<CR>.2 => strecconv.dry;
\<CR>0::ms => strecconv.predelay;
\<CR>
\<CR>//"../_SAMPLES/ConvolutionImpulseResponse/in_the_silo_revised.wav" => strecconv.ir.read; 
\<CR>//"../_SAMPLES/ConvolutionImpulseResponse/on_a_star_jsn_fade_out.wav" => strecconv.ir.read;
\<CR>//"../_SAMPLES/ConvolutionImpulseResponse/chateau_de_logne_outside.wav" => strecconv.ir.read;
\<CR>"../_SAMPLES/ConvolutionImpulseResponse/st_nicolaes_church.wav" => strecconv.ir.read;
\<CR>strecconv.loadir();
\<CR>
\<CR>/////   /!\ make seq start after loading IR /!\   ///////////////////
\<CR>t.no_sync(); // Config it no_sync
\<CR>t.go();
\<CR>////////////////////////////////////////////////////////////////
\<CR>
\<CR>strecconv.connect(last $ ST /* ST */);
\<CR>strecconv.process();
\<CR>strecconv.rec(32 * data.tick /* length */, "test4.wav" /* file name */ );


ab STTREMOLOK STTREMOLO sttrem;
\<CR>.5 => sttrem.mod.gain;  5 => sttrem.mod.freq;
\<CR>sttrem.pa.set(data.tick *6 , 0::ms , 1., 1700::ms);
\<CR>sttrem.connect(last $ ST, t.note_info_tx_o);  sttrem  $ ST @=>  last; 

ab LOOP_WAVK LOOP_WAV l;
\<CR>"../_SAMPLES/" => l.read;
\<CR>1.0 * data.master_gain => l.buf.gain;
\<CR>l.AttackRelease(1::ms, 100::ms);
\<CR>l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

ab LOOP_DOUBLE_WAVK LOOP_DOUBLE_WAV l;
\<CR>"../_SAMPLES/" => l.read;
\<CR>1.0 * data.master_gain => l.buf.gain => l.buf2.gain;
\<CR>l.AttackRelease(1::ms, 15 * 100::ms);
\<CR>l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */ ,  16 * data.tick /* loop */); l $ ST @=> ST @ last;  

ab SEQMULTIK SEQ s[5];
\<CR>0 => int idx;
\<CR>ST @ last;
\<CR> 
\<CR>//data.tick * 8 => s[idx].max;  // SET_WAV.DUBSTEP(s[idx]);// SET_WAV.VOLCA(s[idx]); // SET_WAV.ACOUSTIC(s[idx]); // SET_WAV.TABLA(s[idx]);// SET_WAV.CYMBALS(s[idx]); // SET_WAV.DUB(s[idx]); // SET_WAV.TRANCE(s[idx]); // SET_WAV.TRANCE_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS2(s[idx]);// SET_WAV2.__SAMPLES_KICKS(s[idx]); // SET_WAV2.__SAMPLES_KICKS_1(s[idx]); // SET_WAV.BLIPS(s[idx]); // "test.wav" => s[idx].wav["a"];  // act @=> s[idx].action["a"]; 
\<CR>// _ = pause , ~ = special pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
\<CR>"" => s[idx].seq;
\<CR>1. * data.master_gain => s[idx].gain; // s[idx].gain("s", .2); // for single wav 
\<CR>//s[idx].sync(4*data.tick);// s[idx].element_sync(); //s[idx].no_sync(); //s[idx].full_sync(); // 1 * data.tick => s[idx].the_end.fixed_end_dur; // 16 * data.tick => s[idx].extra_end;   //s[idx].print();
\<CR>// s[idx].mono() => dac; //s[idx].left() => dac.left; //s[idx].right() => dac.right;
\<CR>s[idx].go();     s[idx] $ ST @=>  last; 
\<CR> 
\<CR>1 +=> idx;

ab STCOMPRESSORK STCOMPRESSOR stcomp;
\<CR>7. => float in_gain;
\<CR>stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;  

ab STLIMITERK STLIMITER stlimiter;
\<CR>1. => float in_gainl;
\<CR>stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;  

ab FILTER_TONEK class filter0 extends SYNT{
\<CR>    1::samp => dur refresh;
\<CR>
\<CR>    inlet => blackhole;
\<CR>    
\<CR>    STLPF lpf;
\<CR>//    STWPDiodeLadder lpf;
\<CR>    
\<CR>    fun void f1 (){ 
\<CR>      while(1) {
\<CR>        inlet.last() => lpf.lpfl.freq =>  lpf.lpfr.freq;
\<CR>//        inlet.last() => lpf.lpfl.cutoff =>  lpf.lpfr.cutoff;
\<CR>        refresh => now;
\<CR>      }
\<CR>       
\<CR>      
\<CR>    } 
\<CR>    spork ~ f1 ();
\<CR>
\<CR>    fun void  connect (ST @ in, float q){
\<CR>      lpf.connect(in , 1000 /* freq */  , 1.0 /* Q */  );   
\<CR>      q => lpf.lpfl.Q =>  lpf.lpfr.Q;
\<CR>//      lpf.connect(in , 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );   
\<CR>//      q => lpf.lpfl.resonance=>  lpf.lpfr.resonance;
\<CR>
\<CR>    }
\<CR>
\<CR>
\<CR>        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
\<CR>} 
\<CR>
\<CR>TONE tone_filter;
\<CR>tone_filter.reg(filter0 filt0);  //data.tick * 8 => tone_filter.max; //60::ms => tone_filter.glide;  // tone_filter.lyd(); // tone_filter.ion(); // tone_filter.mix();// 
\<CR>tone_filter.dor();// tone_filter.aeo(); // tone_filter.phr();// tone_filter.loc();
\<CR>// _ = pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
\<CR>"" => tone_filter.seq;
\<CR>.9 * data.master_gain => tone_filter.gain;
\<CR>//tone_filter.sync(4*data.tick);// tone_filter.element_sync();//  tone_filter.no_sync();//  tone_filter.full_sync();  // 16 * data.tick => tone_filter.extra_end;   //tone_filter.print(); //tone_filter.force_off_action();
\<CR>// tone_filter.mono() => dac;//  tone_filter.left() => dac.left; // tone_filter.right() => dac.right; // tone_filter.raw => dac;
\<CR>tone_filter.adsr[0].set(20::ms, 0::ms, 1., 400::ms);
\<CR>tone_filter.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>tone_filter.go();   tone_filter $ ST @=> ST @ last; 
\<CR>
\<CR>//////////////////////////////////////////////
\<CR>//            PUT YOUR SYNT/SEQ HERE :       //
\<CR>//            Beware of "last" declaration  //
\<CR>
\<CR>
\<CR>
\<CR>
\<CR>//////////////////////////////////////////////
\<CR>
\<CR>filt0.connect(last, 6.0); filt0.lpf @=> last;

ab STGVERBK STGVERB stgverb;
\<CR>stgverb.connect(last $ ST, .5 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last;

