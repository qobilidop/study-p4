# Study P4

A personal study of [P4](https://p4.org).

In this repo, I'm exploring various P4 projects, and trying to make some examples to summarize what I learned.

## Repo

Clone this repo with submodules:
```console
$ git clone --recursive https://github.com/qobilidop/study-p4.git
```

Update submodules recursively:
```console
$ git submodule update --init --recursive
```

## Environment

If you use [VS Code + dev container](https://code.visualstudio.com/docs/devcontainers/containers), simply run the VS Code command: `Dev Containers: Rebuild and Reopen in Container`. The first time to build the container could take a very long time, as most projects are compiled from source.

Following are the major P4 projects built in this container:

- [PI](https://github.com/p4lang/PI)
- [behavioral-model](https://github.com/p4lang/behavioral-model)
- [p4c](https://github.com/p4lang/p4c)
- [p4-dpdk-target](https://github.com/p4lang/p4-dpdk-target)
    - [tdi](https://github.com/p4lang/tdi) and [dpdk](https://github.com/DPDK/dpdk) are built as dependencies.

Alternatively, you can also take my [Dockerfile](.devcontainer/Dockerfile) as a reference and set up the environment in your preferred way.

## Example

- [bmv2-v1model-p4runtime](example/bmv2-v1model-p4runtime/): A P4 pipeline built with bmv2/v1model/P4Runtime.
- [dpdk-pna-tdi](example/dpdk-pna-tdi/): A P4 pipeline built with DPDK/PNA/TDI.

## Reference

- https://github.com/p4lang/tutorials
- https://github.com/jafingerhut/p4-guide
- https://github.com/Yi-Tseng/p4-dpdk-target-notes
