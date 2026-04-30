// Wait to allow all includes to launch
data.wait_before_start => now;

while (1) {

	Machine.add("super_seq.ck");

	data.super_seq_reset_ev => now;

}
