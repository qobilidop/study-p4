# DPDK/PNA/TDI Example

This is a P4 pipeline built with the [DPDK software switch (SWX)](https://doc.dpdk.org/guides/prog_guide/packet_framework.html#the-software-switch-swx-pipeline), [PNA architecture](https://p4.org/p4-spec/docs/pna-working-draft-html-version.html), and [TDI runtime API](https://github.com/p4lang/tdi).

## Compile the P4 code

```console
$ make build
p4c-dpdk pipeline.p4 \
        --arch pna \
        -o pipeline.spec \
        --bf-rt-schema pipeline.bfrt.json \
        --tdi pipeline.tdi.json \
        --context pipeline.ctx.json
```

Source file: `pipeline.p4`.

Compiler outputs:
- `pipeline.spec`: The "spec" file that represents the P4 program in a way understandable to the DPDK SWX.
- `pipeline.bfrt.json`: BF-RT JSON file.
- `pipeline.tdi.json`: TDI JSON file.
- `pipeline.ctx.json`: Context JSON file.
