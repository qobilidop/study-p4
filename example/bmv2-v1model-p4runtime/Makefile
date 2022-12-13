P4_PROG = pipeline
P4_SRC = $(P4_PROG).p4

P4_TARGET = bmv2
P4_ARCH = v1model

P4_INFO = $(P4_PROG).p4info.txt
P4_INC = $(P4_PROG).p4i
P4_OUT = $(P4_PROG).json
P4_OUTPUTS = $(P4_INFO) $(P4_INC) $(P4_OUT)

P4_GRAPH_DIR = graph

.PHONY: all
all: build graph

.PHONY: build
build: $(P4_OUTPUTS)

$(P4_OUTPUTS): $(P4_SRC)
	p4c \
		--target $(P4_TARGET) \
		--arch $(P4_ARCH) \
		--p4runtime-files $(P4_INFO) \
		$<

.PHONY: graph
graph: $(P4_GRAPH_DIR)/fullGraph.png

$(P4_GRAPH_DIR)/fullGraph.png: $(P4_SRC)
	mkdir -p $(P4_GRAPH_DIR)
	p4c-graphs --graphs-dir $(P4_GRAPH_DIR) --fullGraph $<
	cd $(P4_GRAPH_DIR) && dot fullGraph.dot -Tpng > fullGraph.png

.PHONY: clean
clean:
	rm -rf $(P4_OUTPUTS) $(P4_GRAPH_DIR)
