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
nmap <C-s> :w<cr>
map <C-d> <C-]>
map <C-Q> <Esc>0i//<Esc>
map <C-f> :tnext<cr>
imap <C-s> <esc>:w<cr>  

" Leader mapping
let mapleader = ","

" Copy current line and increment first number
:nnoremap <leader>a Yp0<C-a>


" For command example:
":for i in range(1, 255) | put=i.' text  '.i*i | endfor 


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

:command! BW bp | sp | bn | bd
:command! VIMRC e ~/.vimrc 
:command! SRC  source ~/.vimrc
   
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

" C++ ab
ab maincpp #include <iostream>
\<CR>
\<CR>using namespace std;
\<CR>
\<CR>int main(int argc, char* argv[]) {
\<CR>
\<CR>cout << "hello";
\<CR>
\<CR>}

" ab ChucK
ab  forK          for (0 => int i; i <       ; i++) {
\<CR>}
\<CR>

ab  sporkfunK fun void f1 (){ 
\<CR>while(1) {
\<CR>
\<CR>  10::ms => now;
\<CR>}
\<CR>} 
\<CR>spork ~ f1 ();
\<CR><Up><Up><Up><Up><Up><End>

ab funK  fun void   (){ 
\<CR> 
\<CR>} 
\<CR><Up><Up><Up><End><esc>hhhhhi

ab sporK spork ~   (); 
\<CR><Up><End><esc>hhhhi

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

ab multi2K 8 => int synt_nb; 0 => int i;
\<CR>Gain detune[synt_nb];
\<CR>Step det_amount[synt_nb];
\<CR>SinOsc s[synt_nb];
\<CR>Gain final => outlet; .3 => final.gain;
\<CR>
\<CR>inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
\<CR>inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
\<CR>inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  

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
\<CR><<<"THE END">>>; 	
\<CR>1500::ms => now;	
\<CR><<<"THE real END">>>; 	
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
\<CR>t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
\<CR>t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
\<CR>// _ = pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
\<CR>"1" => t.seq;
\<CR>.9 * data.master_gain => t.gain;
\<CR>//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
\<CR>// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
\<CR>//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
\<CR>//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>1 => t.set_disconnect_mode;
\<CR>t.go();   t $ ST @=> ST @ last;

ab POLYTONEK POLYTONE pt;
\<CR>
\<CR>3 => pt.size;
\<CR>
\<CR>// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;// 1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  
\<CR>
\<CR>// /!\ Not managed for all TONE in POLY TONE
\<CR>//pt.t[0].force_off_action();
\<CR>// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;
\<CR>
\<CR>pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
\<CR>//pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();
\<CR>
\<CR>.6 * data.master_gain =>  pt.gain_common;
\<CR>// .6 * data.master_gain => pt.t[0].gain; // For individual gain
\<CR>
\<CR>pt.t[0].reg(synt0 s0); 
\<CR>pt.t[1].reg(synt0 s1); 
\<CR>pt.t[2].reg(synt0 s2); 
\<CR>
\<CR>pt.adsr0_set(1500::ms, 1000::ms, .8, 3000::ms); // Only works for ADSR 0
\<CR>pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>
\<CR>// _ = pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
\<CR>"" +=> pt.tseq[0];
\<CR>"" +=> pt.tseq[1];
\<CR>"" +=> pt.tseq[2];
\<CR>
\<CR>pt.go();
\<CR>
\<CR>// CONNECTIONS
\<CR>pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
\<CR>// pt.t[0] $ ST @=> ST @ last;


ab SEQK SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
\<CR>// _ = pause , ~ = special pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
\<CR>"" => s.seq;
\<CR>.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
\<CR>//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate; // s.out("k") /* return ST */
\<CR>// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
\<CR>//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
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
\<CR>autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last;

ab POLYK lpk25 l;
\<CR>POLY synta; 
\<CR>l.reg(synta);
\<CR>synta.reg(synt0 s0);  synta.a[0].set(3::ms, 30::ms, .7, 100::ms);
\<CR>synta.reg(synt0 s1);  synta.a[1].set(3::ms, 30::ms, .7, 100::ms);
\<CR>synta.reg(synt0 s2);  synta.a[2].set(3::ms, 30::ms, .7, 100::ms);
\<CR>synta.reg(synt0 s3);  synta.a[3].set(3::ms, 30::ms, .7, 100::ms);
\<CR>
\<CR>// Note info duration
\<CR>10 * 100::ms => synta.ni.d;
\<CR>
\<CR>synta $ ST @=> ST @ last;

ab GLIDEK lpk25 l;
\<CR>GLIDE synta; 20::ms => synta.duration;	300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
\<CR>l.reg(synta);
\<CR>synta.reg(synt0 s0);
\<CR>
\<CR>// Note info duration
\<CR>10 * 100::ms => synta.ni.d;
\<CR>
\<CR>synta $ ST @=> ST @ last;


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

ab STLPFC2K STLPFC2 lpfc2;
\<CR>lpfc2.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lpfc2 $ ST @=>  last;

ab STLHPFCK STLHPFC lhpfc;
\<CR>lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last;

ab STLHPFC2K STLHPFC2 lhpfc2;
\<CR>lhpfc2.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc2 $ ST @=>  last;

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

ab STHPFC2K STHPFC2 hpfc2;
\<CR>hpfc2.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       hpfc2 $ ST @=>  last;

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

ab STFADEOUTK STFADEOUT fadeout;
\<CR>fadeout.connect(last, 20*data.tick);     fadeout  $ ST @=>  last; 

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
\<CR>stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
\<CR>stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
\<CR>//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
\<CR>// stadsr.keyOn(); stadsr.keyOff();

ab STPADSRK STPADSR stpadsr;
\<CR>stpadsr.set(3::ms /* Attack */, 30::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur of Relative release pos (float)*/,  10::ms /* release */);
\<CR>stpadsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stpadsr.connect(last $ ST, s.note_info_tx_o); stpadsr $ ST @=>  last;
\<CR>//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
\<CR>// stpadsr.keyOn(); stpadsr.keyOff();

ab STSYNCLPFK STSYNCLPF stsynclpf;
\<CR>stsynclpf.freq(100 /* Base */, 3 * 100 /* Variable */, 4. /* Q */);
\<CR>stsynclpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsynclpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last;

ab STSYNCBPFK STSYNCBPF stsyncbpf;
\<CR>stsyncbpf.freq(100 /* Base */, 9 * 100 /* Variable */, 4. /* Q */);
\<CR>stsyncbpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsyncbpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsyncbpf.connect(last $ ST, t.note_info_tx_o); stsyncbpf $ ST @=>  last; 

ab STSYNCHPFK STSYNCHPF stsynchpf;
\<CR>stsynchpf.freq(1000 /* Base */, 20 * 100 /* Variable */, 4. /* Q */);
\<CR>stsynchpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsynchpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsynchpf.connect(last $ ST, t.note_info_tx_o); stsynchpf $ ST @=>  last; 

ab STSYNCBRFK STSYNCBRF stsyncbrf;
\<CR>stsyncbrf.freq(100 /* Base */, 31 * 100 /* Variable */, 1. /* Q */);
\<CR>stsyncbrf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsyncbrf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsyncbrf.connect(last $ ST, t.note_info_tx_o); stsyncbrf $ ST @=>  last; 

ab STSYNCRESK STSYNCRES stsyncres;
\<CR>stsyncres.freq(100 /* Base */, 3 * 100 /* Variable */, 4. /* Q */);
\<CR>stsyncres.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsyncres.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsyncres.connect(last $ ST, t.note_info_tx_o); stsyncres $ ST @=>  last;

ab STSYNCLPF2K STSYNCLPF2 stsynclpf2;
\<CR>stsynclpf2.freq(100 /* Base */, 11 * 100 /* Variable */, 1.0 /* Q */);
\<CR>stsynclpf2.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
\<CR>stsynclpf2.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsynclpf2.connect(last $ ST, t.note_info_tx_o); stsynclpf2 $ ST @=>  last;

ab STSYNCDLK STSYNCWPDiodeLadder stsyncdl;
\<CR>stsyncdl.freq(3*100 /* Base */, 5 * 100 /* Variable */, 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
\<CR>stsyncdl.adsr_set(.1 /* Relative Attack */, .7/* Relative Decay */, 0.00001 /* Sustain */, .0 /* Relative Sustain dur */, 0.0 /* Relative release */);
\<CR>stsyncdl.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsyncdl.connect(last $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last; 

ab STSYNCKORGK STSYNCWPKorg35 stsynckorg;
\<CR>stsynckorg.freq(3*100 /* Base */, 2 * 100 /* Variable */, 1.1 /*   /!\ < 1.7 !!!!   resonance */ , true /* nonlinear */ );
\<CR>stsynckorg.adsr_set(.1 /* Relative Attack */, .7/* Relative Decay */, 0.00001 /* Sustain */, .0 /* Relative Sustain dur */, 0.0 /* Relative release */);
\<CR>stsynckorg.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsynckorg.connect(last $ ST, t.note_info_tx_o); stsynckorg $ ST @=>  last; 

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
\<CR>stgverb.connect(last $ ST, .05 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last;

ab STFLANGERK STFLANGER flang;
\<CR>flang.connect(last $ ST); flang $ ST @=>  last; 
\<CR>flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */);

ab STEPCK STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 100 /* min */, 3000 /* max */, 50::ms /* transition_dur */);
\<CR>stepc.out => 

ab ARPK ARP arp;
\<CR>arp.t.dor();
\<CR>50::ms => arp.t.glide;
\<CR>"*4 1538  " => arp.t.seq;
\<CR>arp.t.go();   
\<CR>
\<CR>// CONNECT SYNT HERE
\<CR>3 => s0.inlet.op;
\<CR>arp.t.raw() => s0.inlet;

ab STCUTTERK STCUTTER stcutter;
\<CR>"*8 1_1_" => stcutter.t.seq;
\<CR>stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last;

ab DETUNEK DETUNE detune;
\<CR>detune.base_synt(s0 /* base synt, controlling others */);
\<CR>detune.reg_aux(synt0 aux1); /* declare and register aux here */
\<CR>detune.config_aux(1.02 /* detune percentage */, .6 /* aux gain output */ ); 

ab STRECK STREC strec;
\<CR>strec.connect(last $ ST, 8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); strec $ ST @=>  last; 

ab STSAMPLERK STSAMPLER stsampler;
\<CR>stsampler.connect(last $ ST, 8*data.tick, "./" /* path for wav */,  "sample" /* wav name, /!\ NO EXTENSION */, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); stsampler $ ST @=>  last; 

ab STDELAYK STDELAY stdelay;
 \<CR>stdelay.connect(last $ ST , data.tick * 2. / 4. /* static delay */ );       stdelay $ ST @=>  last; 

ab STEQK STEQ steq;
\<CR>steq.connect(last $ ST, HW.lpd8.potar[1][1] /* HPF freq */, HW.lpd8.potar[1][2] /* HPF Q */, HW.lpd8.potar[1][3] /* LPF freq */, HW.lpd8.potar[1][4] /* LPF Q */
\<CR> , HW.lpd8.potar[1][5] /* BRF1 freq */, HW.lpd8.potar[1][6] /* BRF1 Q */, HW.lpd8.potar[1][7] /* BRF2 freq */, HW.lpd8.potar[1][8] /* BRF2 Q */
\<CR> , HW.lpd8.potar[2][1] /* BPF1 freq */, HW.lpd8.potar[2][2] /* BPF1 Q */, HW.lpd8.potar[2][3] /* BPF1 Gain */
\<CR> , HW.lpd8.potar[2][5] /* BPF2 freq */, HW.lpd8.potar[2][6] /* BPF2 Q */, HW.lpd8.potar[2][7] /* BPF2 Gain */
\<CR> , HW.lpd8.potar[2][8] /* Output Gain */  ); steq $ ST @=>  last;


ab TONEMULTIK TONE t[3];
\<CR>0 => int id;
\<CR>ST @ last;
\<CR>
\<CR>t[id].reg(synt0 s0);  //data.tick * 8 => t[id].max; //60::ms => t[id].glide;  // t[id].lyd(); // t[id].ion(); // t[id].mix();//
\<CR>t[id].dor();// t[id].aeo(); // t[id].phr();// t[id].loc();
\<CR>// _ = pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
\<CR>"1" => t[id].seq;
\<CR>.9 * data.master_gain => t[id].gain;
\<CR>//t[id].sync(4*data.tick);// t[id].element_sync();//  t[id].no_sync();//  t[id].full_sync(); // 1 * data.tick => t[id].the_end.fixed_end_dur;  // 16 * data.tick => t[id].extra_end;   //t[id].print(); //t[id].force_off_action();
\<CR>// t[id].mono() => dac;//  t[id].left() => dac.left; // t[id].right() => dac.right; // t[id].raw => dac;
\<CR>//t[id].adsr[0].set(2::ms, 10::ms, .2, 400::ms);
\<CR>//t[id].adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>t[id].go();   t[id] $ ST @=>  last; 
\<CR>
\<CR>1 +=> id; 

ab STDUCKMASTER2K STDUCKMASTER2 duckm2;
\<CR>duckm2.connect(last $ ST );      duckm2 $ ST @=>  last; 

ab STDUCK2K STDUCK2 duck2;
\<CR>duck2.connect(last $ ST, 9. /* Side Chain Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duck2 $ ST @=>  last; 

ab ADSRMODK ADSRMOD adsrmod; // Direct ADSR freq input modulation
\<CR>adsrmod.adsr_set(0.01 /* relative attack dur */, 0.01 /* relative decay dur */ , 1.0 /* sustain */, - 0.5 /* relative release pos */, .3 /* relative release dur */);
\<CR>adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
\<CR>adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */);


ab ADSRMOD2K ADSRMOD2 adsrmod; // Freq input modulation with external input and ADSR
\<CR>adsrmod.adsr_set(0.2 /* relative attack dur */, 0.5 /* relative decay dur */ , 0.001 /* sustain */, - 0.5 /* relative release pos */, .3 /* relative release dur */);
\<CR>adsrmod.padsr.setCurves(1., 2., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
\<CR>adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 
\<CR> => adsrmod.in; // CONNECT this /!\ WARNING Modulator Gain to set as ratio of main frequeny example 0.1


ab POLYSEQK POLYSEQ ps;
\<CR>
\<CR>3 => ps.size;
\<CR>
\<CR>//data.tick * 8 => ps.max;
\<CR>// SET_WAV.DUBSTEP(ps.s[0]);// SET_WAV.VOLCA(ps.s[0]); // SET_WAV.ACOUSTIC(ps.s[0]); // SET_WAV.TABLA(ps.s[0]);// SET_WAV.CYMBALS(ps.s[0]); // SET_WAV.DUB(ps.s[0]); // SET_WAV.TRANCE(ps.s[0]); // SET_WAV.TRANCE_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS2(ps.s[0]);// SET_WAV2.__SAMPLES_KICKS(ps.s[0]); // SET_WAV2.__SAMPLES_KICKS_1(ps.s[0]); // SET_WAV.BLIPS(ps.s[0]);  // SET_WAV.TRIBAL(ps.s[0]);// "test.wav" => ps.s[0].wav["a"];  // act @=> ps.s[0].action["a"];
\<CR>SET_WAV.TRANCE(ps.s[0]);
\<CR>SET_WAV.ACOUSTIC(ps.s[1]);
\<CR>SET_WAV.TRIBAL(ps.s[2]);
\<CR>
\<CR>//ps.sync(4*data.tick);// ps.element_sync(); //ps.no_sync(); //ps.full_sync(); // 1 * data.tick => ps.s[0].the_end.fixed_end_dur;  // 16 * data.tick => ps.extra_end;   //ps.s[0].print();
\<CR>
\<CR>// _ = pause , ~ = special pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
\<CR>"_" +=> ps.sseq[0];
\<CR>"_" +=> ps.sseq[1];
\<CR>"_" +=> ps.sseq[2];
\<CR>
\<CR>ps.go();
\<CR>
\<CR>//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); ps.s[0].add_subwav("K", s2.wav["s"]); // ps.s[0].gain_subwav("K", 0, .3);
\<CR>
\<CR>// GAIN
\<CR>.6 * data.master_gain =>  ps.gain_common;
\<CR>// .6 * data.master_gain => ps.s[0].gain; // For individual gain
\<CR>// ps.s[0].gain("s", .4); // for single wav 
\<CR>
\<CR>// CONNECTIONS
\<CR>ps.stout_connect(); ps.stout $ ST  @=> ST @ last; // comment to connect each SEQ separately
\<CR>// ps.s[0] $ ST @=> ST @ last;


ab STLPFNK STLPFN lpfn;
\<CR>lpfn.connect(last $ ST , 4 * 100 /* freq */  , 1.0 /* Q */ , 3 /* order */ );       lpfn $ ST @=>  last; 

ab SinK SinOsc sin0 => 
\<CR>10.0 => sin0.freq;
\<CR>1.0 => sin0.gain;
\<CR><Up><Up><Up><End>

ab SawK SawOsc saw0 => 
\<CR>10.0 => saw0.freq;
\<CR>1.0 => saw0.gain;
\<CR><Up><Up><Up><End>

ab SqrK SqrOsc sqr0 => 
\<CR>10.0 => sqr0.freq;
\<CR>1.0 => sqr0.gain;
\<CR>0.5 => sqr0.width;
\<CR><Up><Up><Up><Up><End>

ab TriK TriOsc tri0 => 
\<CR>10.0 => tri0.freq;
\<CR>1.0 => tri0.gain;
\<CR>0.5 => tri0.width;
\<CR><Up><Up><Up><Up><End>

ab OFFSETK OFFSET ofs0 =>
\<CR>1. => ofs0.offset;
\<CR>1. => ofs0.gain;
\<CR><Up><Up><Up><End>

ab EnvK Envelope e0 => 
\<CR>0.0 => e0.value;
\<CR>1.0 => e0.target;
\<CR>4.0 * data.tick => e0.duration ;// => now;
\<CR><Up><Up><Up><Up><End>

ab StepK Step stp0 => 
\<CR>1.0 => stp0.next;
\<CR><Up><Up><End>


ab AUTOMATIONK ///////////////// AUTOMATION ///////////////////////
\<CR>
\<CR>Step stpauto =>  Envelope eauto =>  blackhole;
\<CR>10 => eauto.value; // INITIAL VALUE
\<CR>
\<CR>1.0 => stpauto.next;
\<CR>
\<CR>fun void f1 (){ 
\<CR>while(1) {
\<CR>eauto.last() =>     TODO       ;
\<CR>10::ms => now; // REFRESH RATE
\<CR>}
\<CR>}
\<CR>spork ~ f1 ();
\<CR>
\<CR>SYNC sy;
\<CR>sy.sync(4 * data.tick);
\<CR>//sy.sync(4 * data.tick , 0::ms /* offset */);
\<CR>
\<CR>while(1) {
\<CR>15 * 100.0 => eauto.target;
\<CR>16.0 * data.tick => eauto.duration  => now;
\<CR>
\<CR>20.0 => eauto.target;
\<CR>16.0 * data.tick => eauto.duration  => now;
\<CR>}
\<CR>///////////////// AUTOMATION ///////////////////////
 
ab STODK STOVERDRIVE stod;
\<CR>stod.connect(last $ ST, 1.1 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last;


ab MGAINCK mgainc0 => 
\<esc>OMGAINC mgainc0; mgainc0.config( HW.lpd8.potar[1][1] /* gain */, 1.0 /* Static gain */ ); <Down><End> 

ab MGAINC2K mgain2c0 => 
\<esc>OMGAINC2 mgain2c0; mgain2c0.config( HW.lpd8.potar[1][1] /* gain */, 1.0 /* Static gain */ , 50::ms /* ramp dur */ ); <Down><End> 


"""""""""""""""""""
"""" FILTERX """"""
"""""""""""""""""""

""" LPF

ab STLPFXK STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
\<CR>stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last; 

ab STFREELPFXK STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
\<CR>stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
\<CR>AUTO.freq("") => stfreelpfx0.freq; // CONNECT THIS

ab STSYNCLPFXK STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
\<CR>stsynclpfx0.freq(100 /* Base */, 5 * 100 /* Variable */, 2. /* Q */);
\<CR>stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
\<CR>stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
\<CR>// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr;

ab STAUTOLPFXK STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
\<CR>stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last; 

ab STLPFXCK STFILTERXC stlpfxc_0; LPF_XFACTORY stlpfxc_0fact;
\<CR>stlpfxc_0.connect(last $ ST ,  stlpfxc_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 3 /* order */, 1 /* channels */);       stlpfxc_0 $ ST @=>  last; 

ab STLPFXC2K STFILTERXC2 stlpfxc2_0; LPF_XFACTORY stlpfxc2_0fact;
\<CR>stlpfxc2_0.connect(last $ ST ,  stlpfxc2_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 1 /* order */, 1 /* channels */, 10::ms /* ramp dur */, 1::ms /* update period */ );       stlpfxc2_0 $ ST @=>  last; 

ab STQSYNCLPFXK STQSYNCFILTERX stqsynclpfx0; LPF_XFACTORY stqsynclpfx0_fact;
\<CR>stqsynclpfx0.freq(25 * 10 /* Base */, 15 * 100 /* Variable */);
\<CR>stqsynclpfx0.q(1 /* Base */, 8 /* Variable */);
\<CR>stqsynclpfx0.adsr_set(.02 /* Relative Attack */, .3/* Relative Decay */, 0.8 /* Sustain */, .4 /* Relative Sustain dur */, 0.2 /* Relative release */);
\<CR>stqsynclpfx0.q_adsr_set(.1 /* Relative Attack */, 0.8/* Relative Decay */, 0.0 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
\<CR>stqsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stqsynclpfx0.connect(last $ ST ,  stqsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::samp /* period */ );       stqsynclpfx0 $ ST @=>  last; 
\<CR>// CONNECT THIS to play on targets //     => stqsynclpfx0.nio.padsr; // =>  stqsynclpfx0.nio.filter_freq //  =>  stqsynclpfx0.nio.q_padsr;



""" BPF
ab STBPFXK STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
\<CR>stbpfx0.connect(last $ ST ,  stbpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last; 

ab STFREEBPFXK STFREEFILTERX stfreebpfx0; BPF_XFACTORY stfreebpfx0_fact;
\<CR>stfreebpfx0.connect(last $ ST , stfreebpfx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreebpfx0 $ ST @=>  last; 
\<CR>AUTO.freq("") => stfreebpfx0.freq; // CONNECT THIS

ab STSYNCBPFXK STSYNCFILTERX stsyncbpfx0; BPF_XFACTORY stsyncbpfx0_fact;
\<CR>stsyncbpfx0.freq(100 /* Base */, 5 * 100 /* Variable */, 2. /* Q */);
\<CR>stsyncbpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
\<CR>stsyncbpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsyncbpfx0.connect(last $ ST ,  stsyncbpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsyncbpfx0 $ ST @=>  last; 
\<CR>// CONNECT THIS to play on freq target //     => stsyncbpfx0.nio.padsr;

ab STAUTOBPFXK STAUTOFILTERX stautobpfx0; BPF_XFACTORY stautobpfx0_fact;
\<CR>stautobpfx0.connect(last $ ST ,  stautobpfx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautobpfx0 $ ST @=>  last; 

ab STBPFXCK STFILTERXC stbpfxc_0; BPF_XFACTORY stbpfxc_0fact;
\<CR>stbpfxc_0.connect(last $ ST ,  stbpfxc_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 3 /* order */, 1 /* channels */);       stbpfxc_0 $ ST @=>  last; 

ab STBPFXC2K STFILTERXC2 stbpfxc2_0; BPF_XFACTORY stbpfxc2_0fact;
\<CR>stbpfxc2_0.connect(last $ ST ,  stbpfxc2_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 1 /* order */, 1 /* channels */, 10::ms /* ramp dur */, 1::ms /* update period */ );       stbpfxc2_0 $ ST @=>  last; 

""" BRF
ab STBRFXK STFILTERX stbrfx0; BRF_XFACTORY stbrfx0_fact;
\<CR>stbrfx0.connect(last $ ST ,  stbrfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbrfx0 $ ST @=>  last; 

ab STFREEBRFXK STFREEFILTERX stfreebrfx0; BRF_XFACTORY stfreebrfx0_fact;
\<CR>stfreebrfx0.connect(last $ ST , stfreebrfx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreebrfx0 $ ST @=>  last; 
\<CR>AUTO.freq("") => stfreebrfx0.freq; // CONNECT THIS

ab STSYNCBRFXK STSYNCFILTERX stsyncbrfx0; BRF_XFACTORY stsyncbrfx0_fact;
\<CR>stsyncbrfx0.freq(100 /* Base */, 5 * 100 /* Variable */, 2. /* Q */);
\<CR>stsyncbrfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
\<CR>stsyncbrfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsyncbrfx0.connect(last $ ST ,  stsyncbrfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsyncbrfx0 $ ST @=>  last; 
\<CR>// CONNECT THIS to play on freq target //     => stsyncbrfx0.nio.padsr;

ab STAUTOBRFXK STAUTOFILTERX stautobrfx0; BRF_XFACTORY stautobrfx0_fact;
\<CR>stautobrfx0.connect(last $ ST ,  stautobrfx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautobrfx0 $ ST @=>  last; 

ab STBRFXCK STFILTERXC stbrfxc_0; BRF_XFACTORY stbrfxc_0fact;
\<CR>stbrfxc_0.connect(last $ ST ,  stbrfxc_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 3 /* order */, 1 /* channels */);       stbrfxc_0 $ ST @=>  last; 

ab STBRFXC2K STFILTERXC2 stbrfxc2_0; BRF_XFACTORY stbrfxc2_0fact;
\<CR>stbrfxc2_0.connect(last $ ST ,  stbrfxc2_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 1 /* order */, 1 /* channels */, 10::ms /* ramp dur */, 1::ms /* update period */ );       stbrfxc2_0 $ ST @=>  last; 

""" HPF
ab STHPFXK STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
\<CR>sthpfx0.connect(last $ ST ,  sthpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last; 

ab STFREEHPFXK STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
\<CR>stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
\<CR>AUTO.freq("") => stfreehpfx0.freq; // CONNECT THIS

ab STSYNCHPFXK STSYNCFILTERX stsynchpfx0; HPF_XFACTORY stsynchpfx0_fact;
\<CR>stsynchpfx0.freq(100 /* Base */, 5 * 100 /* Variable */, 2. /* Q */);
\<CR>stsynchpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
\<CR>stsynchpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsynchpfx0.connect(last $ ST ,  stsynchpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynchpfx0 $ ST @=>  last; 
\<CR>// CONNECT THIS to play on freq target //     => stsynchpfx0.nio.padsr;

ab STAUTOHPFXK STAUTOFILTERX stautohpfx0; HPF_XFACTORY stautohpfx0_fact;
\<CR>stautohpfx0.connect(last $ ST ,  stautohpfx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautohpfx0 $ ST @=>  last; 

ab STHPFXCK STFILTERXC sthpfxc_0; HPF_XFACTORY sthpfxc_0fact;
\<CR>sthpfxc_0.connect(last $ ST ,  sthpfxc_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 3 /* order */, 1 /* channels */);       sthpfxc_0 $ ST @=>  last; 

ab STHPFXC2K STFILTERXC2 sthpfxc2_0; HPF_XFACTORY sthpfxc2_0fact;
\<CR>sthpfxc2_0.connect(last $ ST ,  sthpfxc2_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 1 /* order */, 1 /* channels */, 10::ms /* ramp dur */, 1::ms /* update period */ );       sthpfxc2_0 $ ST @=>  last; 

""" RES
ab STRESXK STFILTERX stresx0; RES_XFACTORY stresx0_fact;
\<CR>stresx0.connect(last $ ST ,  stresx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stresx0 $ ST @=>  last; 

ab STFREERESXK STFREEFILTERX stfreeresx0; RES_XFACTORY stfreeresx0_fact;
\<CR>stfreeresx0.connect(last $ ST , stfreeresx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreeresx0 $ ST @=>  last; 
\<CR>AUTO.freq("") => stfreeresx0.freq; // CONNECT THIS

ab STSYNCRESXK STSYNCFILTERX stsyncresx0; RES_XFACTORY stsyncresx0_fact;
\<CR>stsyncresx0.freq(100 /* Base */, 5 * 100 /* Variable */, 2. /* Q */);
\<CR>stsyncresx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
\<CR>stsyncresx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsyncresx0.connect(last $ ST ,  stsyncresx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsyncresx0 $ ST @=>  last; 
\<CR>// CONNECT THIS to play on freq target //     => stsyncresx0.nio.padsr;

ab STAUTORESXK STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
\<CR>stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last; 

ab STRESXCK STFILTERXC stresxc_0; RES_XFACTORY stresxc_0fact;
\<CR>stresxc_0.connect(last $ ST ,  stresxc_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 3 /* order */, 1 /* channels */);       stresxc_0 $ ST @=>  last; 

ab STRESXC2K STFILTERXC2 stresxc2_0; RES_XFACTORY stresxc2_0fact;
\<CR>stresxc2_0.connect(last $ ST ,  stresxc2_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 1 /* order */, 1 /* channels */, 10::ms /* ramp dur */, 1::ms /* update period */ );       stresxc2_0 $ ST @=>  last; 

""" DL
ab STDLXK STFILTERX stdlx0; DL_XFACTORY stdlx0_fact;
\<CR>stdlx0.connect(last $ ST ,  stdlx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stdlx0 $ ST @=>  last; 

ab STFREEDLXK STFREEFILTERX stfreedlx0; DL_XFACTORY stfreedlx0_fact;
\<CR>stfreedlx0.connect(last $ ST , stfreedlx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreedlx0 $ ST @=>  last; 
\<CR>AUTO.freq("") => stfreedlx0.freq; // CONNECT THIS

ab STSYNCDLXK STSYNCFILTERX stsyncdlx0; DL_XFACTORY stsyncdlx0_fact;
\<CR>stsyncdlx0.freq(100 /* Base */, 5 * 100 /* Variable */, 2. /* Q */);
\<CR>stsyncdlx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
\<CR>stsyncdlx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsyncdlx0.connect(last $ ST ,  stsyncdlx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsyncdlx0 $ ST @=>  last; 
\<CR>// CONNECT THIS to play on freq target //     => stsyncdlx0.nio.padsr;

ab STAUTODLXK STAUTOFILTERX stautodlx0; DL_XFACTORY stautodlx0_fact;
\<CR>stautodlx0.connect(last $ ST ,  stautodlx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautodlx0 $ ST @=>  last; 

ab STDLXCK STFILTERXC stdlxc_0; DL_XFACTORY stdlxc_0fact;
\<CR>stdlxc_0.connect(last $ ST ,  stdlxc_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 3 /* order */, 1 /* channels */);       stdlxc_0 $ ST @=>  last; 

ab STDLXC2K STFILTERXC2 stdlxc2_0; DL_XFACTORY stdlxc2_0fact;
\<CR>stdlxc2_0.connect(last $ ST ,  stdlxc2_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 1 /* order */, 1 /* channels */, 10::ms /* ramp dur */, 1::ms /* update period */ );       stdlxc2_0 $ ST @=>  last; 

""" KG
ab STKGXK STFILTERX stkgx0; KG_XFACTORY stkgx0_fact;
\<CR>stkgx0.connect(last $ ST ,  stkgx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stkgx0 $ ST @=>  last; 

ab STFREEKGXK STFREEFILTERX stfreekgx0; KG_XFACTORY stfreekgx0_fact;
\<CR>stfreekgx0.connect(last $ ST , stfreekgx0_fact, 1 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreekgx0 $ ST @=>  last; 
\<CR>AUTO.freq("") => stfreekgx0.freq; // CONNECT THIS

ab STSYNCKGXK STSYNCFILTERX stsynckgx0; KG_XFACTORY stsynckgx0_fact;
\<CR>stsynckgx0.freq(100 /* Base */, 5 * 100 /* Variable */, 2. /* Q */);
\<CR>stsynckgx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
\<CR>stsynckgx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>stsynckgx0.connect(last $ ST ,  stsynckgx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynckgx0 $ ST @=>  last; 
\<CR>// CONNECT THIS to play on freq target //     => stsynckgx0.nio.padsr;

ab STAUTOKGXK STAUTOFILTERX stautokgx0; KG_XFACTORY stautokgx0_fact;
\<CR>stautokgx0.connect(last $ ST ,  stautokgx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautokgx0 $ ST @=>  last; 

ab STKGXCK STFILTERXC stkgxc_0; KG_XFACTORY stkgxc_0fact;
\<CR>stkgxc_0.connect(last $ ST ,  stkgxc_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 3 /* order */, 1 /* channels */);       stkgxc_0 $ ST @=>  last; 

ab STKGXC2K STFILTERXC2 stkgxc2_0; KG_XFACTORY stkgxc2_0fact;
\<CR>stkgxc2_0.connect(last $ ST ,  stkgxc2_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 1 /* order */, 1 /* channels */, 10::ms /* ramp dur */, 1::ms /* update period */ );       stkgxc2_0 $ ST @=>  last; 

ab polyserumK class synt0 extends SYNT{
\<CR>8 => int synt_nb; 0 => int i;
\<CR>Gain detune[synt_nb];
\<CR>SERUM0 s[synt_nb]; 
\<CR>Gain final => outlet; .3 => final.gain;
\<CR>
\<CR>0 => int n;
\<CR>0 => int k;
\<CR>
\<CR>inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
\<CR>
\<CR>fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
\<CR>
\<CR>} 

ab WAITK WAIT w;
\<CR>8 *data.tick => w.fixed_end_dur;
\<CR>//4*data.tick => w.sync_end_dur;
\<CR>
\<CR>//2 * data.tick =>  w.wait;


ab STROTATEK STROTATE strot;
\<CR>strot.connect(last $ ST , 0.6 /* freq */  , 0.8 /* depth */, 1.0 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
\<CR>// => strot.sin0;  => strot.sin1; // connect to make freq change

ab STECHOVK STECHOV echv;
\<CR>echv.connect(last $ ST , data.tick * 2 /* delay max */, 1::samp /* update rate */);  echv $ ST @=>  last; 
\<CR>// spork ~ echv.control (data.tick * 3 /4 /* delay sart */ , data.tick * 1 /8/* delay stop */, data.tick * 4 /* delay transition dur */, .8 /* gainstart */, 0.6 /* gainstop */, data.tick * 4 /* gain_trans_dur */ );  // Use control for classical ramping delay and gain control, or connect below 
\<CR>// =>  echv.del; /* Delay in samp */
\<CR>// => echv.g;   /* Gain */

ab STCROSSOUTK STCROSSOUT stcrossout;
\<CR>stcrossout.connect(last $ ST );   stcrossout$ ST @=>  last; 
\<CR>// stcrossout.AUX // Aux output  
\<CR>// stcrossout.to_aux( 4 * data.tick /* crossorver duration */);  // SWITCH TO AUX OUT
\<CR>// stcrossout.to_main( 4 * data.tick /* crossorver duration */); // SWITCH BACK TO MAIN

ab STCROSSINK STCROSSIN stcrossin;
\<CR>stcrossin.connect(last $ ST /* main */, t $ ST);
\<CR>// stcrossin.to_aux(4 * data.tick /* crossorver duration */); // SWITCH TO AUX IN
\<CR>// stcrossin.to_main(4 * data.tick /* crossorver duration */);// SWITCH BACK TO MAIN IN

ab SERUM1K SERUM1
\<esc>os0.add(0 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
\<CR>// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );

ab SERUM01K SERUM01
\<esc>os0.add(0 /* synt nb */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
\<CR>// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );

ab SERUM0K SERUM0
\<esc>os0.config(0 /* synt nb */ , 0 /* rank */ );

ab SERUM00K SERUM00
\<esc>os0.config(0 /* synt nb */ );

ab SERUM2K SERUM2
\<esc>os0.config(0 /* synt nb */ );
\<CR>// s0.set_chunk(0);

ab SERUM3K SERUM3
\<esc>os0.config(0 /* synt nb */ );
\<CR>// => s0.in; s0.control_update(10::ms);


ab SYNTLABK class syntL extends SYNT{
\<CR>inlet => SqrOsc s =>  outlet; 
\<CR>.5 => s.gain;
\<CR>
\<CR>fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
\<CR>} 
\<CR>class syntR extends SYNT{
\<CR>inlet => TriOsc s =>  outlet; 
\<CR>.5 => s.gain;
\<CR>
\<CR>fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
\<CR>} 
\<CR>
\<CR>syntL sl; syntR sr;
\<CR>
\<CR>SYNTLAB syntlab;
\<CR>syntlab.go( sl, sr, 48 /* start_note */, 49 /* last_note */, 3000::ms /* note_dur */,  1000::ms /* attack */, 1000::ms /* release */, "../_SAMPLES/ambient_universe/SYNTTEST" /* base_name */ );


ab SYNTWAVK SYNTWAV
\<esc>os0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, "../_SAMPLES/ambient_universe/SYNTTEST" /* FILE */, 100::ms /* UPDATE */);
\<CR>// s0.pos s0.rate s0.lastbuf

ab MAGICK /********************************************************/
\<CR>if (    0     ){
\<CR>}/***********************   MAGIC CURSOR *********************/
\<CR>while(1) { /********************************************************/
\<CR>
\<CR>}

ab SYNTADDK SYNTADD syntadd
\<esc>osyntadd.add(s0 /* SYNT, to declare outside */, .5 /* Gain */, 1. /* freq gain */);

ab NOTESK //" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
\<CR>//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
\<CR>

ab STLOSHELFK STLOSHELF stloshelf0; 
\<CR>stloshelf0.connect(last $ ST , 10 * 100 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 1.0 /* Gain */ );       stloshelf0 $ ST @=>  last;  

ab STHISHELFK STHISHELF sthishelf0; 
\<CR>sthishelf0.connect(last $ ST , 20 * 100 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 1.0 /* Gain */ );       sthishelf0 $ ST @=>  last;  

ab STBELLK STBELL stbell0; 
\<CR>stbell0.connect(last $ ST , 20 * 10 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 1.0 /* Gain */ );       stbell0 $ ST @=>  last;  

ab STCROSSOVERK STCROSSOVER stcrossover0;
\<CR>stcrossover0.connect(last $ ST , 57 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 1.0 /* LPF Gain */ );       stcrossover0 $ ST @=>  last;  

ab STDELAY2K STDELAY2 stdelay2; // Stereo simple delay + passthrough
\<CR>stdelay2.connect(last $ ST , 12::ms /* delay right */, 15::ms /* delay left */, 0.3 /* delay gain */ );       stdelay2 $ ST @=>  last;  


ab KIKK KIK kik
\<esc>okik.config(0.1 /* init Sin Phase */, 76 * 100 /* init freq env */, 0.4 /* init gain env */);
\<CR>kik.addFreqPoint (233.0, 2::ms);
\<CR>kik.addFreqPoint (100.0, 20::ms);
\<CR>kik.addFreqPoint (35.0, 17 * 10::ms);
\<CR>
\<CR>kik.addGainPoint (0.6, 2::ms);
\<CR>kik.addGainPoint (0.3, 10::ms);
\<CR>kik.addGainPoint (1.0, 10::ms);
\<CR>kik.addGainPoint (1.0, 171::ms);
\<CR>kik.addGainPoint (0.0, 15::ms);


ab STTOAUXK STTOAUX sttoaux0; 
\<CR> // WARNING use it with option :   --out4 or more, else make the script crash
\<CR>sttoaux0.connect(last $ ST ,  1.0 /* gain to main */, 0.1  /* gain  to aux */, 1 /* st pair number */ ); sttoaux0 $ ST @=>  last;

ab STREVAUXK STREVAUX strevaux;
\<CR>strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last; 

ab STFREEPANK STFREEPAN stfreepan0;
\<CR>stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
\<CR>AUTO.pan("") => stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0

" AUTO freq: dorian scale based on ref note , gain 1 : 0.0, 8 : 1.0 and pan 1 : -1.0, 5 ~ 0.0, 8 : 1.0
ab AUTOK AUTO.freq("") => 

ab STFREEGAINK STFREEGAIN stfreegain;
\<CR>stfreegain.connect(last $ ST);       stfreegain $ ST @=>  last; 
\<CR>AUTO.gain("") => stfreegain.g; // connect this


ab LOOPLABK fun void  LOOPLAB  (){ 
\<CR>while(1) {
\<CR>
\<CR>
\<CR>16 * data.tick => w.wait;
\<CR>//-------------------------------------------
\<CR>}
\<CR>} 
\<CR>spork ~ LOOPLAB();
\<CR>//LOOPLAB();


ab SSYNTK /////////////////////////////////////////////////////////////////////////////////////////
\<CR>
\<CR>fun void SSYNT0 (string seq) {
\<CR>
\<CR>TONE t;
\<CR>t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
\<CR>t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
\<CR>// _ = pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
\<CR>seq => t.seq;
\<CR>.3 * data.master_gain => t.gain;
\<CR>t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
\<CR>// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
\<CR>t.set_adsrs(6::ms, 10::ms, .6, 400::ms);
\<CR>//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>1 => t.set_disconnect_mode;
\<CR>t.go();   t $ ST @=> ST @ last; 
\<CR>
\<CR>STMIX stmix;
\<CR>stmix.send(last, mixer + 0);
\<CR>
\<CR>1::samp => now; // let seq() be sporked to compute length
\<CR>t.s.duration  => now;
\<CR>} 
\<CR>// spork ~ SSYNT0 ("1"); 
\<CR>
\<CR>////////////////////////////////////////////////////////////////////////////////////////

ab SONGK 1 => int mixer;
\<CR>
\<CR>///////////////////////////////////////////////////////////////////////////////////////////////
\<CR>KIK kik;
\<CR>kik.config(0.1 /* init Sin Phase */, 18 * 100 /* init freq env */, 0.5 /* init gain env */);
\<CR>kik.addFreqPoint (233.0, 2::ms);
\<CR>kik.addFreqPoint (90.0, 50::ms);
\<CR>kik.addFreqPoint (31.0, 13 * 10::ms);
\<CR>
\<CR>kik.addGainPoint (0.6, 13::ms);
\<CR>kik.addGainPoint (0.4, 25::ms);
\<CR>kik.addGainPoint (1.0, 10::ms);
\<CR>kik.addGainPoint (1.0, 13 * 10::ms);
\<CR>kik.addGainPoint (0.0, 15::ms); 
\<CR>
\<CR>fun void KICK(string seq) {
\<CR>TONE t;
\<CR>t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
\<CR>t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
\<CR>// _ = pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
\<CR>seq => t.seq;
\<CR>.31 * data.master_gain => t.gain;
\<CR>//t.sync(4*data.tick);// t.element_sync();// 
\<CR>t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
\<CR>// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
\<CR>//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
\<CR>//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>1 => t.set_disconnect_mode;
\<CR>t.go();   t $ ST @=> ST @ last; 
\<CR>
\<CR>1::samp => now; // let seq() be sporked to compute length
\<CR>t.s.duration - 1::samp => now;
\<CR>}
\<CR>//spork ~ KICK("*4 k___ k___ k___ k___");
\<CR>
\<CR>///////////////////////////////////////////////////////////////////////////////////////////////
\<CR>fun void SEQ0(string seq) {
\<CR>SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
\<CR>SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
\<CR>// _ = pause , ~ = special pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
\<CR>seq => s.seq;
\<CR>.5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
\<CR>s.no_sync();// s.element_sync(); //s.no_sync()
\<CR>//s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
\<CR>// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
\<CR>//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
\<CR>s.go();     s $ ST @=> ST @ last; 
\<CR>
\<CR>//  STMIX stmix;
\<CR>//  stmix.send(last, mixer);
\<CR>
\<CR>1::samp => now; // let seq() be sporked to compute length
\<CR>s.s.duration => now;
\<CR>}
\<CR>
\<CR>//spork ~ SEQ0("*4 sss___");
\<CR>
\<CR>//////////////////////////////////////////////////////////////////////////////////////////////
\<CR>class synt0 extends SYNT{
\<CR>inlet => SinOsc s =>  outlet; 
\<CR>.5 => s.gain;
\<CR>fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
\<CR>} 
\<CR>
\<CR>
\<CR>fun void SYNT0 (string seq) {
\<CR>TONE t;
\<CR>t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
\<CR>t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
\<CR>// _ = pause , \| = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
\<CR>seq => t.seq;
\<CR>.3 * data.master_gain => t.gain;
\<CR>t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
\<CR>// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
\<CR>//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
\<CR>//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
\<CR>t.go();   t $ ST @=> ST @ last; 
\<CR>
\<CR>//  STMIX stmix;
\<CR>//  stmix.send(last, mixer);
\<CR>
\<CR>1::samp => now; // let seq() be sporked to compute length
\<CR>t.s.duration => now;
\<CR>}
\<CR>
\<CR>//spork ~ SYNT0("}c *8 4103124801234 :8 ____ ____");
\<CR>////////////////////////////////////////////////////////////////////////////////////////////
\<CR>////////////////////////////////////////////////////////////////////////////////////////////
\<CR>
\<CR>148 => data.bpm;   (60.0/data.bpm)::second => data.tick;
\<CR>55 => data.ref_note;
\<CR>
\<CR>SYNC sy;
\<CR>sy.sync(4 * data.tick);
\<CR>//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 
\<CR>
\<CR>WAIT w;
\<CR>//8 *data.tick => w.fixed_end_dur;
\<CR>8*data.tick => w.sync_end_dur;
\<CR>//2 * data.tick =>  w.wait; 
\<CR>
\<CR>// OUTPUT
\<CR>
\<CR>STMIX stmix;
\<CR>stmix.receive(mixer); stmix $ ST @=> ST @ last; 
\<CR>
\<CR>fun void EFFECT1   (){ 
\<CR>STMIX stmix;
\<CR>stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 
\<CR>} 
\<CR>EFFECT1();
\<CR>
\<CR>// LOOP
\<CR>/********************************************************/
\<CR>if (    0     ){
\<CR>}/***********************   MAGIC CURSOR *********************/
\<CR>while(1) { /********************************************************/
\<CR>//spork ~ KICK("*4 k___ k___ k___ k___");
\<CR>//spork ~ SEQ0("____ *4s__s _ab_ ");
\<CR>//spork ~ SYNT0("}c *8 4103124801234 :8 ____ ____");
\<CR>
\<CR>8 * data.tick =>  w.wait; 
\<CR>// 7 * data.tick =>  w.wait; sy.sync(4 * data.tick);
\<CR>} 

ab MULTIRECK "song_mrec_" => string mrpath;
\<CR>MULTIREC mrec;  30::second => mrec.rec_dur; // 1 => mrec.disable;
\<CR>mrec.add_track(mrpath + "drum");
\<CR>mrec.add_track(mrpath + "voix");
\<CR>mrec.add_track(mrpath + "dohl");
\<CR>
\<CR>mrec.rec();
\<CR>// PROBE to insert in ST paths
\<CR>//mrec.rec_on_track( last, mrpath + "kick") @=> last;

ab STCONVREVK STCONVREV stconvrev;
\<CR>stconvrev.connect(last $ ST , 14/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last; 

ab STADC1K STADC1 stadc1; stadc1 $ ST @=>  ST @ last; 

ab RangeK  Range range0 => 
\<CR>range0.range(-1, 1, -0.5, 0.5);
\<CR>//1 => range0.clip; 
\<CR><Up><Up><Up><End>

ab GainK Gain g0 =>
\<CR>1.0 => g0.gain;
\<CR>// 3 => g0.op; //1+ 2- 3* 4/ 0 off -1 passthrough
\<CR><Up><Up><Up><End>

ab STSAMPLERCK STSAMPLERC stsamplerc;
\<CR>stsamplerc.connect(last $ ST,  "./" /* path for wav */,  "sample" /* wav name, /!\ NO EXTENSION */, 4 * data.tick /* sync_dur, 0 == sync on full dur */, 0*data.tick /*if 0, end with rec button*/, 1 /*loop playback*/ 0 /* no sync */ ); stsamplerc $ ST @=>  last;  


