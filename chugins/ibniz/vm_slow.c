#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Ju: Added to got the vm defined
//#define IBNIZ_MAIN

#include "ibniz.h"

// Ju: move to vm context
//#define MAXCODESIZE 4096
//#define MAXDATASIZE 4096

#define OP_LOADIMM '0'

#define ROL(a,s) ((((uint32_t)(a))<<(s))|(((uint32_t)(a))>>(32-(s))))
#define ROR(a,s) ((((uint32_t)(a))>>(s))|(((uint32_t)(a))<<(32-(s))))

#define MOVESP(steps) vm_p->sp=(vm_p->sp+(steps))&vm_p->stackmask
#define MOVERSP(steps) vm_p->rsp=(vm_p->rsp+(steps))&vm_p->rstackmask

// Ju: moved to vm context
//char compiled_code[MAXCODESIZE];
//uint32_t compiled_data[MAXDATASIZE];
//uint32_t compiled_hints[MAXCODESIZE];

// Ju: added, kind of stub like in vm_test.c
void waitfortimechange()
{
}

uint32_t gettimevalue()
{
  return 0;
}
// -


void pushmediavariables(vm_t * vm_p);

uint32_t getdatabits(int n, vm_t * vm_p)
{
  int s=(32-n-(vm_p->dataptr&31));
  uint32_t mask;
  uint32_t a;
  if(n<=0 || vm_p->datalgt<=0) return 0;
  mask=(1<<n)-1;
  if(s>=0) a=(vm_p->compiled_data[vm_p->dataptr>>5]>>s)&mask;
      else a=((vm_p->compiled_data[vm_p->dataptr>>5]<<(0-s))|
              (vm_p->compiled_data[(vm_p->dataptr>>5)+1]>>(32+s)))&mask;
  vm_p->dataptr=(vm_p->dataptr+n)%vm_p->datalgt;
  return a;
}

void vm_compile(char*src, vm_t * vm_p)
{
  char*d=vm_p->compiled_code;
  uint32_t*hd=vm_p->compiled_hints;
  uint32_t num;
  char*s,nummode=0,shift=0;
  int i,j;
  s=src;

  /* parse immediates, skip comments & whitespaces */

  for(;;)
  {
    char a=*s++;
    if((!a) || (a>='!' && a<='~'))
    {
      if(a=='.' || (a>='0' && a<='9') || (a>='A' && a<='F'))
      {
        if(nummode==0)
        {
          num=0;
          shift=16;
          nummode=1;
        }
        if(a=='.')
        {
          if(nummode==2)
          {
            *d++=OP_LOADIMM;
            *hd++=num;
            num=0;
          }
          nummode=2;
          shift=12;
        } else
        {
          char digit=(a>='A'?a-'A'+10:a-'0');
          if(nummode==1) num=ROL(num,4);
          num|=digit<<shift;
          if(nummode==2) shift=(shift-4)&31;
        }
      } else
      {
        if(nummode)
        {
          *d++=OP_LOADIMM;
          *hd++=num;
          nummode=0;
        }
        if(a=='\\')
        {
          while(*s && *s!='\n') s++;
          if(!s) break;
          s++;
        }
        else
        {
          if(a!=',')
          {
            if(a=='$') a='\0';
            *d++=a;
            *hd++=0;
            if(a=='\0') break;
          }
        }
      }
    }
  }

  /* parse data */

  vm_p->datalgt=0;
  if(s[-1]=='$')
  {
    int digitsz=4;
    vm_p->compiled_data[0]=0;
    for(;;)
    {
      int a=*s++;
      if(!a) break;
      if(a=='\\')
      {
        while(*s && *s!='\n') s++;
        if(!s) break;
        s++;
      }
      else
      switch(a)
      {
        case('b'):
          digitsz=1;
          break;
        case('q'):
          digitsz=2;
          break;
        case('o'):
          digitsz=3;
          break;
        case('h'):
          digitsz=4;
          break;
        case('A'):case('B'):case('C'):case('D'):case('E'):case('F'):
          a=a-'A'+10+'0';
        case('0'):case('1'):case('2'):case('3'):case('4'):
        case('5'):case('6'):case('7'):case('8'):case('9'):
          a-='0';
          a&=((1<<digitsz)-1);
          {int s=(32-digitsz-(vm_p->datalgt&31));
           if(s>=0)
           {
             vm_p->compiled_data[vm_p->datalgt>>5]|=a<<s;
             vm_p->compiled_data[(vm_p->datalgt>>5)+1]=0;
           }
           else
           {
             vm_p->compiled_data[vm_p->datalgt>>5]|=a>>(0-s);
             vm_p->compiled_data[(vm_p->datalgt>>5)+1]=a<<(32+s);
           }
           vm_p->datalgt+=digitsz;
          }
          break;
      }
    }
    /* fill last 2 words to ease fetch */
    {int pad=vm_p->datalgt&31;
    if(pad)
    {
      int i=pad;
      while(i<32)
      {
        vm_p->compiled_data[vm_p->datalgt>>5]|=vm_p->compiled_data[0]>>i;
        i*=2;
      }
    }
    if(!pad) vm_p->compiled_data[(vm_p->datalgt>>5)+1]=vm_p->compiled_data[0];
    else
    {
      vm_p->compiled_data[(vm_p->datalgt>>5)+1]=
        (vm_p->compiled_data[0]<<(32-pad)) |
        (vm_p->compiled_data[1]>>pad);
    }
    }
  }

  /* precalculate skip points */
  vm_p->codelgt=d-vm_p->compiled_code;
  for(i=0;;i++)
  {
    int j=i+1,seek0=0,seek1=0,seek2=0;
    char a=vm_p->compiled_code[i];
    if(a=='\0') { seek0='M'; j=0; }
    if(a=='M') seek0='M';
    else if(a=='?') { seek0=';'; seek1=':'; }
    else if(a==':') seek0=';';
    else if(a=='{') { seek0='}'; }
    if(seek0)
    {
      for(;;j++)
      {
        int a=vm_p->compiled_code[j];
        if(a=='\0' || a==seek0 || a==seek1)
        {
          if(i==j || a==0) vm_p->compiled_hints[i]=0;
              else vm_p->compiled_hints[i]=j+1;
          break;
        }
      }
    }
    if(a=='\0') break;
  }

  /* DEBUG: dump code */
  /*
  for(i=0;i<vm_p->codelgt;i++)
  {
    printf("slot %x: opcode %c, hints %x\n",
      i,vm_p->compiled_code[i],vm_p->compiled_hints[i]);
  }
  for(i=0;i<vm_p->datalgt;i+=32)
  {
    printf("datapoint %d/%d: %x\n",i,vm_p->datalgt,vm_p->compiled_data[i>>5]);
  }
  */
}

void vm_init(vm_t * vm_p)
{
  /* video context */

  vm_p->stack=vm_p->mem+0xE0000;
  vm_p->stackmask=0x1ffff;
  vm_p->sp=0;
  
  vm_p->rstack=vm_p->mem+0xCC000;
  vm_p->rstackmask=0x3FFF;
  vm_p->rsp=0;

  /* audio context */

  vm_p->costack=vm_p->mem+0xD0000;
  vm_p->costackmask=0xffff;
  vm_p->cosp=1; // to avoid audio skipping bug at start
  
  vm_p->corstack=vm_p->mem+0xC8000;
  vm_p->corstackmask=0x3FFF;
  vm_p->corsp=0;

  /* state */

  vm_p->ip=vm_p->compiled_code;
  vm_p->mediacontext=0;
  vm_p->videomode=0;
  vm_p->audiomode=0;
  vm_p->visiblepage=1;
  vm_p->dataptr=0;
  vm_p->userinput=0;
  vm_p->stopped=0;
  vm_p->audiotime=vm_p->videotime=gettimevalue();

  vm_p->spchange[0]=vm_p->spchange[1]=0;
  vm_p->wcount[0]=vm_p->wcount[1]=0;
  vm_p->currentwcount[0]=vm_p->currentwcount[1]=0;
  vm_p->prevsp[0]=vm_p->prevsp[1]=0;

  /* zero out memory */
  if(!vm_p->datalgt) memset(vm_p->mem,0,MEMSIZE*sizeof(uint32_t));
  else
  {
    int i;
    vm_p->dataptr=0;
    for(i=0;i<MEMSIZE;i++) vm_p->mem[i]=getdatabits(32, vm_p);
    vm_p->dataptr=0;
  }

  pushmediavariables(vm_p);
}

#define SWAP(t,a,b) { t tmp=(a);(a)=(b);(b)=tmp; }

void switchmediacontext(vm_t * vm_p)
{
  SWAP(int32_t*,vm_p->stack,vm_p->costack);
  SWAP(uint32_t,vm_p->sp,vm_p->cosp);
  SWAP(uint32_t,vm_p->stackmask,vm_p->costackmask);
  SWAP(uint32_t*,vm_p->rstack,vm_p->corstack);
  SWAP(uint32_t,vm_p->rsp,vm_p->corsp);
  SWAP(uint32_t,vm_p->rstackmask,vm_p->corstackmask);
  vm_p->mediacontext=vm_p->preferredmediacontext;
}

void stepmediacontext(int skippoint,int at_eoc, vm_t * vm_p)
{
  vm_p->spchange[vm_p->mediacontext]=vm_p->sp-vm_p->prevsp[vm_p->mediacontext];
  vm_p->wcount[vm_p->mediacontext]=vm_p->currentwcount[vm_p->mediacontext];
  vm_p->currentwcount[vm_p->mediacontext]=0;
  vm_p->prevsp[vm_p->mediacontext]=vm_p->sp;
  vm_p->prevstackval[vm_p->mediacontext]=vm_p->stack[vm_p->sp];
  if(vm_p->mediacontext==vm_p->preferredmediacontext)
  {
    //if(vm_p->rsp==0)
    vm_p->ip=vm_p->compiled_code+skippoint;
    //         else 
    //         vm_p->ip=vm_p->compiled_code+(vm_p->rstack[vm_p->rsp-1]%vm_p->codelgt);
  } else
  {
    switchmediacontext(vm_p);
    //if(vm_p->rsp!=0) vm_p->ip=vm_p->compiled_code+(vm_p->rstack[vm_p->rsp-1]%vm_p->codelgt);
    //  else
    if(at_eoc) vm_p->ip=vm_p->compiled_code;
  }
}

void flipvideopage(vm_t * vm_p)
{
  vm_p->visiblepage=((vm_p->sp>>16)&1)^1;
  //vm_p->visiblepage^=1;
  for(;;)
  {
    uint32_t newt=gettimevalue();
    if(newt!=vm_p->videotime) break;
    waitfortimechange();
  }
  vm_p->videotime=gettimevalue();
}

void pushmediavariables(vm_t * vm_p)
{
  vm_p->currentwcount[vm_p->mediacontext]++;
// Ju to have only audio
  if(/*vm_p->mediacontext==*/0)
  {
    int p=vm_p->sp&65535;
    
    if(vm_p->videomode==0)
    {
      if(vm_p->visiblepage==(vm_p->sp>>16))
      {
        flipvideopage(vm_p);
      }
      MOVESP(1);
      vm_p->stack[vm_p->sp]=vm_p->videotime<<16;
      MOVESP(1);
      vm_p->stack[vm_p->sp]=(p<<1)-0x10000;
      MOVESP(1);
      vm_p->stack[vm_p->sp]=((p&255)<<9)-0x10000;
    } else {
      if(!p)
      {
        flipvideopage(vm_p);
      }
      MOVESP(1);
      vm_p->stack[vm_p->sp]=(vm_p->videotime<<16)|p;
    }
  } else
  {
    if(!vm_p->sp) // todo we need something better
    {
      vm_p->audiotime+=64;
    }
    MOVESP(1);
    vm_p->stack[vm_p->sp]=vm_p->audiotime*65536+vm_p->sp*64;
//    fprintf(stderr,"%x\n",vm_p->stack[vm_p->sp]);
  }
}

#define CYCLESPERRUN 10223
// Ju: Hack the output to get computed sample
//     And the input too
//int vm_run()
int32_t vm_run(int32_t in, vm_t * vm_p)
{
  int32_t ib_out;

  int cycles;
  if(vm_p->stopped) return 0;
  for(cycles=CYCLESPERRUN;cycles;cycles--)
  {
    char op=*vm_p->ip++;
    int32_t*a=&vm_p->stack[vm_p->sp],*b;

    switch(op)
    {
      /*** NUMBERS ***/

      case(OP_LOADIMM):
        MOVESP(1);
        vm_p->stack[vm_p->sp]=vm_p->compiled_hints[vm_p->ip-1-vm_p->compiled_code];
        break;
 
      /*** ARITHMETIC ***/
      
      case('+'):	// (b a -- a+b)
        MOVESP(-1);
        vm_p->stack[vm_p->sp]+=*a;
        break;

      case('-'):	// (b a -- a-b)
        MOVESP(-1);
        vm_p->stack[vm_p->sp]-=*a;
        break;

      case('*'):	// (b a -- a*b)
        MOVESP(-1);
        b=&vm_p->stack[vm_p->sp];
        {int64_t m=*a;
         m*=((int32_t)*b);
         *b=m>>16;
         }
        break;

      case('/'):	// (b a -- a/b)
        MOVESP(-1);
        b=&vm_p->stack[vm_p->sp];
        if(!*a)*b=0;
        else
        {int64_t m=*b;
         m<<=16;
         m/=((int32_t)*a);
         *b=m;}
        break;

      case('%'):	// (b a -- a%b)
        MOVESP(-1);
        b=&vm_p->stack[vm_p->sp];
        if(!*a)*b=0;
        else
        *b=(*b%*a);
        break;
    
      case('q'):	// (a -- sqrt(a), 0 if a<0)
        if(*a<0) *a=0;
        else *a=sqrt(*a/65536.0)*65536.0;
        break;

      case('&'):	// (b a -- a&b)
        MOVESP(-1);
        vm_p->stack[vm_p->sp]&=*a;
        break;

      case('|'):	// (b a -- a|b)
        MOVESP(-1);
        vm_p->stack[vm_p->sp]|=*a;
          break;

      case('^'):	// (b a -- a^b)
        MOVESP(-1);
        vm_p->stack[vm_p->sp]^=*a;
        break;

      case('r'):	// (b a -- b ror a)
        MOVESP(-1);
        b=&vm_p->stack[vm_p->sp];
        {int steps=(*a>>16)&31;
         *b=ROR(*b,steps);
        }
        break;

      case('l'):	// (b a -- b >> a)
        MOVESP(-1);
        b=&vm_p->stack[vm_p->sp];
        {int steps=(*a>>16)&63;
         uint32_t w=*b;
         if(steps<32)
         *b=(w<<steps); else *b=(w>>(steps-32));
         }
        break;

      case('~'):	// (a -- NOT a)
        *a=~*a;
        break;

      case('s'):	// (a -- sin(a))
        *a=sin(*a*(2*M_PI/65536.0))*65536.0;
        break;
      case('a'):	// (b a -- atan2(a,b))
        MOVESP(-1);
        b=&vm_p->stack[vm_p->sp];
        *b=atan2(*a,*b)*(65536.0/(2*M_PI));
        break;

      case('<'):	// (a -- a<0?a:0)
        if(*a>=0)*a=0;
        break;
      case('>'):	// (a -- a>0?a:0)
        if(*a&0x80000000)*a=0;
        break;
      case('='):	// (a -- a==0?1:0)
        if(*a)*a=0x10000;else *a=0;
        break;

      /*** STACK MANIPULATION ***/

      case('d'):	// (a -- a a)
        MOVESP(1);
        vm_p->stack[vm_p->sp]=*a;
        break;

      case('p'):	// (a --)
        MOVESP(-1);
        break;

      case('x'):	// (b a -- a b) // forth: SWAP
        {int32_t tmp=*a;
         b=&vm_p->stack[(vm_p->sp-1)&vm_p->stackmask];
         *a=*b;
         *b=tmp;}
        break;

      case('v'):	// (c b a -- b a c) // forth: ROT
        {int32_t a_v=*a,*c;
         b=&vm_p->stack[(vm_p->sp-1)&vm_p->stackmask];
         c=&vm_p->stack[(vm_p->sp-2)&vm_p->stackmask];
         *a=*c;
         *c=*b;
         *b=a_v;}
        break;

      case(')'):	// pick from STACK[top-1-i]
        *a=vm_p->stack[(vm_p->sp-1-ROL(*a,16))&vm_p->stackmask];
        break;
      
      case('('):	// store to STACK[top-2-i]
        MOVESP(-1);
        b=&vm_p->stack[vm_p->sp];
        MOVESP(-1);
        vm_p->stack[(vm_p->sp-ROL(*a,16))&vm_p->stackmask]=*b;
        break;

      case('z'):
        MOVESP(1);
        vm_p->stack[vm_p->sp]=ROL(((vm_p->stack+vm_p->sp)-vm_p->mem),16);
        break;

      /*** EXTERIOR LOOP ***/

      case('M'):	// media switch
        stepmediacontext(vm_p->compiled_hints[vm_p->ip-vm_p->compiled_code-1],0, vm_p);
        pushmediavariables(vm_p);
        break;

      case('\0'):	// end of code
        //vm_p->ip=vm_p->compiled_code; // or top of rstack (don't pop it)

// Ju: save computed sample
	ib_out = vm_p->stack[vm_p->sp];

        stepmediacontext(vm_p->compiled_hints[vm_p->ip-vm_p->compiled_code-1],1, vm_p);
        
	pushmediavariables(vm_p);
	// step into stack
	//MOVESP(1);
	// add input as stack next entry
    	//vm_p->stack[vm_p->sp] = in;
// Ju: Added to get out the function and return the IBNIZ sample computed
	return ib_out;

        break;
        
      case('w'):	// whereami
        pushmediavariables(vm_p);
        break;
      
      case('T'):	// terminate program
        vm_p->ip--;
        vm_p->stopped=1;
        return CYCLESPERRUN-cycles;

      /*** MEMORY MANIPULATION ***/

      case('@'):	// (addr -- val)
        *a=vm_p->mem[ROL(*a,16)&(MEMSIZE-1)];
        break;
      
      case('!'):	// (val addr --)
        MOVESP(-1);
        b=&vm_p->stack[vm_p->sp];
        MOVESP(-1);
        vm_p->mem[ROL(*a,16)&(MEMSIZE-1)]=*b;
        break;

      /*** PROGRAM CONTROL: Conditional execution ***/

      case('?'):	// if
        MOVESP(-1);
        if(*a!=0) break;
      case(':'):	// then
        vm_p->ip=vm_p->compiled_code+vm_p->compiled_hints[vm_p->ip-vm_p->compiled_code-1];
      case(';'):	// endif/nop
        break;

      /*** PROGRAM CONTROL: Loops ***/

      case('i'):	// i counter
        MOVESP(1);
        vm_p->stack[vm_p->sp]=ROL(vm_p->rstack[(vm_p->rsp-1)&vm_p->rstackmask],16);
        break;

      case('j'):	// j counter
        MOVESP(1);
        vm_p->stack[vm_p->sp]=ROL(vm_p->rstack[(vm_p->rsp-3)&vm_p->rstackmask],16);
        break;
      
      case('X'):	// times
        MOVERSP(1);
        MOVESP(-1);
        vm_p->rstack[vm_p->rsp]=ROL(*a,16);
      case('['):	// do
        MOVERSP(1);
        vm_p->rstack[vm_p->rsp]=vm_p->ip-vm_p->compiled_code;
        break;

      case('L'):	// loop
        {uint32_t*i=&vm_p->rstack[(vm_p->rsp-1)&vm_p->rstackmask];
        (*i)--;
        if(*i==0) MOVERSP(-2); else
          vm_p->ip=(vm_p->rstack[vm_p->rsp]%vm_p->codelgt)+vm_p->compiled_code;
        }
        break;

      case(']'):	// while
        MOVESP(-1);
        if(*a) vm_p->ip=(vm_p->rstack[vm_p->rsp]%vm_p->codelgt)+vm_p->compiled_code;
          else MOVERSP(-1);
        break;

      case('J'):	// jump
        {int point=*a%vm_p->codelgt; // !!! addressing will change
        MOVESP(-1);
        vm_p->ip=vm_p->compiled_code+point;}
        break;
        
      /*** PROGRAM CONTROL: Subroutines ***/

      case('{'):	// defsub
        MOVESP(-1);
        vm_p->mem[ROL(*a,16)&(MEMSIZE-1)]=vm_p->ip-vm_p->compiled_code;
        vm_p->ip=vm_p->compiled_code+vm_p->compiled_hints[vm_p->ip-1-vm_p->compiled_code];
        break;
      case('}'):	// ret
        vm_p->ip=vm_p->compiled_code+(vm_p->rstack[vm_p->rsp]%vm_p->codelgt);
        MOVERSP(-1);
        break;
      case('V'):	// visit
        MOVESP(-1);
        MOVERSP(1);
        vm_p->rstack[vm_p->rsp]=vm_p->ip-vm_p->compiled_code;
        vm_p->ip=((vm_p->mem[ROL(*a,16)&(MEMSIZE-1)])%vm_p->codelgt)+vm_p->compiled_code;
        break;

      /*** PROGRAM CONTROL: Rstack manipulation ***/
      
      case('R'):	// pull from rstack to mainstack
        MOVESP(1);
        vm_p->stack[vm_p->sp]=ROL(vm_p->rstack[vm_p->rsp],16);
        MOVERSP(-1);
        break;
      case('P'):	// push from stack to rstack
        MOVERSP(1);
        vm_p->rstack[vm_p->rsp]=ROL(*a,16);
        MOVESP(-1);
        break;

      /*** INPUT ***/

      case('U'):	// userinput
        MOVESP(1);
        vm_p->stack[vm_p->sp]=vm_p->userinput;
        vm_p->userinput&=0xff00ffff;
        break;

      /*** DATA SEGMENT ***/
      
      case('G'):	// getbits
        *a=ROL(getdatabits((*a>>16)&31, vm_p),16);
        break;
    }
  }
  return CYCLESPERRUN;
}
