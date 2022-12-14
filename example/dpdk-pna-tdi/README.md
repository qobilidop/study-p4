# DPDK/PNA/TDI Example

This is a P4 pipeline built with the [DPDK software switch](https://doc.dpdk.org/guides/prog_guide/packet_framework.html#the-software-switch-swx-pipeline), [PNA architecture](https://p4.org/p4-spec/docs/pna-working-draft-html-version.html), and [TDI runtime API](https://github.com/p4lang/tdi).

## Compile the P4 code

```console
$ make build
p4c-dpdk pipeline.p4 \
        --arch pna \
        -o pipeline.spec \
        --bf-rt-schema pipeline_bfrt.json \
        --tdi pipeline_tdi.json \
        --context pipeline_ctx.json
```

Source file: `pipeline.p4`.

Compiler outputs:
- `pipeline.spec`: The "spec" file that represents the P4 program in a way understandable to the DPDK software switch.
- `pipeline_bfrt.json`: BF-RT JSON file.
- `pipeline_tdi.json`: TDI JSON file.
- `pipeline_ctx.json`: Context JSON file.

## Run the software switch

```console
$ ./run_switch.sh
...
bf_switchd: dev_id 0 initialized

bf_switchd: initialized 1 devices
bf_switchd_switchsai_lib_init
 starting SAI 
bf_switchd: spawning cli server thread
bf_switchd: spawning driver shell
bf_switchd: server started - listening on port 9999

        ********************************************
        *      WARNING: Authorised Access Only     *
        ********************************************
    

bfshell> 
```

Related files:
- `switch_conf.json`: This file configures the software switch.
- `switch_port.json`: This file is specified in `switch_conf.json` to configure software switch ports.

After exiting the `bfshell`, the host shell might end up in a weird state. You can do a `reset` command to bring it back to normal.
