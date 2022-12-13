#include <core.p4>
#include <v1model.p4>

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

parser MyParser(
    packet_in pkt,
    out header_t hdr,
    inout metadata_t meta, inout standard_metadata_t std_meta
) {
    state start {
        pkt.extract(hdr.eth);
        pkt.extract(hdr.custom);
        transition accept;
    }
}

control MyVerifyChecksum(
    inout header_t hdr,
    inout metadata_t meta
) { apply {} }

control MyIngress(
    inout header_t hdr,
    inout metadata_t meta,
    inout standard_metadata_t std_meta
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

control MyEgress(
    inout header_t hdr,
    inout metadata_t meta,
    inout standard_metadata_t std_meta
) { apply {} }

control MyComputeChecksum(
    inout header_t hdr,
    inout metadata_t meta
) { apply {} }

control MyDeparser(
    packet_out pkt,
    in header_t hdr
) {
    apply {
        pkt.emit(hdr.eth);
        pkt.emit(hdr.custom);
    }
}

V1Switch(
    MyParser(),
    MyVerifyChecksum(),
    MyIngress(),
    MyEgress(),
    MyComputeChecksum(),
    MyDeparser()
) main;
