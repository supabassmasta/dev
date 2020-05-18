while(1) {

  Machine.add("grain3.ck") => int id;


  Std.rand2f(0.1, .5) * 1::ms =>now;
  Machine.remove(id);

  Std.rand2f(0.1, .5) * 1::ms =>now;

}
 
