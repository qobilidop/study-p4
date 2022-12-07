P4_PROG = pipeline

P4_ARCH = v1model
P4_TARGET = bmv2

.PHONY: build
build:
	p4c \
		--arch $(P4_ARCH) \
		--target $(P4_TARGET) \
		--p4runtime-files $(P4_PROG).p4info.txt \
		$(P4_PROG).p4

P4_GRAPH_DIR = graph

.PHONY: graph
graph:
	mkdir -p $(P4_GRAPH_DIR)
	p4c-graphs $(P4_PROG).p4 --graphs-dir $(P4_GRAPH_DIR) --fullGraph
	cd $(P4_GRAPH_DIR) && dot fullGraph.dot -Tpng > fullGraph.png
