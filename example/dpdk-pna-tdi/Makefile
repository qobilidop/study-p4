P4_PROG = pipeline
P4_SRC = $(P4_PROG).p4

P4_TARGET = dpdk
P4_ARCH = pna

P4_SPEC = $(P4_PROG).spec
P4_BFRT = $(P4_PROG).bfrt.json
P4_TDI = $(P4_PROG).tdi.json
P4_CTX = $(P4_PROG).ctx.json
P4_OUTPUTS = $(P4_SPEC) $(P4_BFRT) $(P4_TDI) $(P4_CTX)

P4_GRAPH_DIR = graph

.PHONY: all
all: build graph

.PHONY: build
build: $(P4_OUTPUTS)

$(P4_OUTPUTS): $(P4_SRC)
	p4c-dpdk $< \
		--arch $(P4_ARCH) \
		-o $(P4_SPEC) \
		--bf-rt-schema $(P4_BFRT) \
		--tdi $(P4_TDI) \
		--context $(P4_CTX)

.PHONY: graph
graph: $(P4_GRAPH_DIR)/fullGraph.png

$(P4_GRAPH_DIR)/fullGraph.png: $(P4_SRC)
	mkdir -p $(P4_GRAPH_DIR)
	p4c-graphs --graphs-dir $(P4_GRAPH_DIR) --fullGraph $<
	cd $(P4_GRAPH_DIR) && dot fullGraph.dot -Tpng > fullGraph.png

.PHONY: clean
clean:
	rm -rf $(P4_OUTPUTS) $(P4_GRAPH_DIR)
