
struct eth_h {
	bit<48> dst_addr
	bit<48> src_addr
	bit<16> ether_type
}

struct custom_h {
	bit<128> a_b_c_d
}

struct process_and_send_arg_t {
	bit<32> a
	bit<8> b
	bit<32> c
	bit<64> d
	bit<32> port
}

header eth instanceof eth_h
header custom instanceof custom_h

struct metadata_t {
	bit<32> pna_main_input_metadata_input_port
	bit<32> pna_main_output_metadata_output_port
	bit<128> MainControlT_tmp
	bit<128> MainControlT_tmp_1
	bit<128> MainControlT_tmp_2
	bit<128> MainControlT_tmp_4
	bit<128> MainControlT_tmp_5
	bit<128> MainControlT_tmp_6
	bit<128> MainControlT_tmp_8
	bit<128> MainControlT_tmp_9
	bit<128> MainControlT_tmp_10
	bit<128> MainControlT_tmp_12
	bit<128> MainControlT_tmp_13
}
metadata instanceof metadata_t

regarray direction size 0x100 initval 0

action drop args none {
	drop
	return
}

action process_and_send args instanceof process_and_send_arg_t {
	mov m.MainControlT_tmp h.custom.a_b_c_d
	and m.MainControlT_tmp 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
	mov m.MainControlT_tmp_1 t.a
	and m.MainControlT_tmp_1 0x1
	mov h.custom.a_b_c_d m.MainControlT_tmp
	or h.custom.a_b_c_d m.MainControlT_tmp_1
	mov m.MainControlT_tmp_2 h.custom.a_b_c_d
	and m.MainControlT_tmp_2 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE01
	mov m.MainControlT_tmp_4 t.b
	shl m.MainControlT_tmp_4 0x1
	mov m.MainControlT_tmp_5 m.MainControlT_tmp_4
	and m.MainControlT_tmp_5 0x1FE
	mov h.custom.a_b_c_d m.MainControlT_tmp_2
	or h.custom.a_b_c_d m.MainControlT_tmp_5
	mov m.MainControlT_tmp_6 h.custom.a_b_c_d
	and m.MainControlT_tmp_6 0xFFFFFFFFFFFFFFFFFFFFFFFFC00001FF
	mov m.MainControlT_tmp_8 t.c
	shl m.MainControlT_tmp_8 0x9
	mov m.MainControlT_tmp_9 m.MainControlT_tmp_8
	and m.MainControlT_tmp_9 0x3FFFFE00
	mov h.custom.a_b_c_d m.MainControlT_tmp_6
	or h.custom.a_b_c_d m.MainControlT_tmp_9
	mov m.MainControlT_tmp_10 h.custom.a_b_c_d
	and m.MainControlT_tmp_10 0x3FFFFFFF
	mov m.MainControlT_tmp_12 t.d
	shl m.MainControlT_tmp_12 0x1E
	mov m.MainControlT_tmp_13 m.MainControlT_tmp_12
	and m.MainControlT_tmp_13 0xFFFFFFFFFFFFFFFFFFFFFFFFC0000000
	mov h.custom.a_b_c_d m.MainControlT_tmp_10
	or h.custom.a_b_c_d m.MainControlT_tmp_13
	mov m.pna_main_output_metadata_output_port t.port
	return
}

table forward {
	key {
		h.eth.dst_addr exact
	}
	actions {
		process_and_send
		drop
	}
	default_action drop args none const
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


