
struct eth_h {
	bit<48> dst_addr
	bit<48> src_addr
	bit<16> ether_type
}

struct custom_h {
	bit<8> a
	bit<32> b
	bit<128> c
}

struct process_packet_arg_t {
	bit<8> a
	bit<32> b
	bit<128> c
}

header eth instanceof eth_h
header custom instanceof custom_h

struct metadata_t {
	bit<32> pna_main_input_metadata_input_port
	bit<32> pna_main_output_metadata_output_port
}
metadata instanceof metadata_t

regarray direction size 0x100 initval 0

action NoAction args none {
	return
}

action process_packet args instanceof process_packet_arg_t {
	mov h.custom.a t.a
	mov h.custom.b t.b
	mov h.custom.c t.c
	return
}

table forward {
	key {
		h.eth.dst_addr exact
	}
	actions {
		process_packet
		NoAction
	}
	default_action NoAction args none 
	size 0x10000
}


apply {
	rx m.pna_main_input_metadata_input_port
	extract h.eth
	extract h.custom
	table forward
	emit h.eth
	emit h.custom
	tx m.pna_main_output_metadata_output_port
}


