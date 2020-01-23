class string_dummy
{
    string my_string;
}

public class ROOTPATH {
  static  string_dummy @ str;
}

new string_dummy @=> ROOTPATH.str;


// CHANGE PATH HERE
"../../" =>  ROOTPATH.str.my_string;


while(1) 1000::ms => now;

