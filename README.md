# Play P4

Personal playground for exploring [P4](https://p4.org).

I'm trying out several P4 projects and summarizing what I learned into examples in this repo.

## Repo

Clone this repo with submodules:
```console
$ git clone --recursive https://github.com/qobilidop/play-p4.git
```

Update submodules recursively:
```console
$ git submodule update --init --recursive
```

## Environment

If you use [VS Code + dev container](https://code.visualstudio.com/docs/devcontainers/containers), simply run the VS Code command: `Dev Containers: Rebuild and Reopen in Container`. The first time to build the container might take a rather long time, as most projects are compiled from source.

Following are the major P4 projects built in the container:

- [behavioral-model](https://github.com/p4lang/behavioral-model)
- [p4-dpdk-target](https://github.com/p4lang/p4-dpdk-target)
    - [dpdk](https://github.com/DPDK/dpdk) and [tdi](https://github.com/p4lang/tdi) are built as dependencies.
- [p4c](https://github.com/p4lang/p4c)
- [PI](https://github.com/p4lang/PI)

I personally find [dev container](https://containers.dev) pretty convenient to use. But if you don't use it, you can also take my [Dockerfile](.devcontainer/Dockerfile) as a reference and set up the environment in your preferred way.

## Example

- [bmv2-v1model-p4runtime](example/bmv2-v1model-p4runtime/): A P4 pipeline built with bmv2/v1model/P4Runtime.
- [dpdk-pna-tdi](example/dpdk-pna-tdi/): A P4 pipeline built with DPDK/PNA/TDI.

## Reference

- https://github.com/p4lang/tutorials
- https://github.com/jafingerhut/p4-guide
- https://github.com/Yi-Tseng/p4-dpdk-target-notes
