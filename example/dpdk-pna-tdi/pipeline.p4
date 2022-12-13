#include <core.p4>
#include <pna.p4>

header eth_h {
    bit<48> dst_addr;
    bit<48> src_addr;
    bit<16> ether_type;
}

header custom_h {
    bit<8> a;
    bit<32> b;
    bit<128> c;
}

struct header_t {
    eth_h eth;
    custom_h custom;
}

struct metadata_t {}

parser MyMainParser(
    packet_in pkt,
    out header_t hdr,
    inout metadata_t meta,
    in pna_main_parser_input_metadata_t istd
) {
    state start {
        pkt.extract(hdr.eth);
        pkt.extract(hdr.custom);
        transition accept;
    }
}

control MyPreControl(
    in header_t hdr,
    inout metadata_t meta,
    in pna_pre_input_metadata_t istd,
    inout pna_pre_output_metadata_t ostd
) { apply {} }

control MyMainControl(
    inout header_t hdr,
    inout metadata_t meta,
    in pna_main_input_metadata_t istd,
    inout pna_main_output_metadata_t ostd
) {
    action process_packet(bit<8> a, bit<32> b, bit<128> c) {
        hdr.custom.a = a;
        hdr.custom.b = b;
        hdr.custom.c = c;
    }

    table forward {
        key = {
            hdr.eth.dst_addr: exact;
        }
        actions = {
            process_packet;
        }
    }

    apply {
        forward.apply();
    }
}

control MyMainDeparser(
    packet_out pkt,
    in header_t hdr,
    in metadata_t meta,
    in pna_main_output_metadata_t ostd
) {
    apply {
        pkt.emit(hdr.eth);
        pkt.emit(hdr.custom);
    }
}

PNA_NIC(
    MyMainParser(),
    MyPreControl(),
    MyMainControl(),
    MyMainDeparser()
) main;
