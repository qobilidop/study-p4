
struct eth_h {
	bit<48> dst_addr
	bit<48> src_addr
	bit<16> ether_type
}

struct custom_h {
	bit<8> a
	bit<32> b_c
	bit<128> d
}

struct process_packet_arg_t {
	bit<8> a
	bit<32> b
	bit<32> c
	bit<128> d
}

header eth instanceof eth_h
header custom instanceof custom_h

struct metadata_t {
	bit<32> pna_main_input_metadata_input_port
	bit<32> pna_main_output_metadata_output_port
	bit<32> MainControlT_tmp
	bit<32> MainControlT_tmp_1
	bit<32> MainControlT_tmp_2
	bit<32> MainControlT_tmp_4
	bit<32> MainControlT_tmp_5
}
metadata instanceof metadata_t

regarray direction size 0x100 initval 0

action NoAction args none {
	return
}

action process_packet args instanceof process_packet_arg_t {
	mov h.custom.a t.a
	mov m.MainControlT_tmp h.custom.b_c
	and m.MainControlT_tmp 0xFFFFF000
	mov m.MainControlT_tmp_1 t.b
	and m.MainControlT_tmp_1 0xFFF
	mov h.custom.b_c m.MainControlT_tmp
	or h.custom.b_c m.MainControlT_tmp_1
	mov m.MainControlT_tmp_2 h.custom.b_c
	and m.MainControlT_tmp_2 0xFFF
	mov m.MainControlT_tmp_4 t.c
	shl m.MainControlT_tmp_4 0xC
	mov m.MainControlT_tmp_5 m.MainControlT_tmp_4
	and m.MainControlT_tmp_5 0xFFFFF000
	mov h.custom.b_c m.MainControlT_tmp_2
	or h.custom.b_c m.MainControlT_tmp_5
	mov h.custom.d t.d
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


