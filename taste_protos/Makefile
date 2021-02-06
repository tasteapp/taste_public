PROTO_VERSION := $(shell protoc --version | cut -d " " -f 2)
PROTO_DIR := /usr/local/Cellar/protobuf/$(PROTO_VERSION)/include
PROTO_FILES := $(shell find protos -iname "*.proto")
RULES_PLUGIN := ../rules-gen
RULES_OUT := rules-out
DART_OUT := lib/gen
PYTHON_OUT := python
TS_OUT := typescript/gen
GEN_DIRS := $(RULES_OUT) $(DART_OUT) $(BQ_OUT) $(TS_OUT) 
INC := -I$(PROTO_DIR) -Iprotos -I$(RULES_PLUGIN)/proto
IN_FILES := $(PROTO_FILES) $(PROTO_DIR)/google/protobuf/timestamp.proto $(PROTO_DIR)/google/protobuf/struct.proto $(RULES_PLUGIN)/proto/firebase_rules_options.proto
INC_IN_FILES := $(INC) $(IN_FILES)
dart:
	mkdir -p $(DART_OUT)
	protoc                               \
        --dart_out=$(DART_OUT)               \
        --plugin "pub run protoc_plugin" \
        $(INC_IN_FILES)
rules:
	mkdir -p $(RULES_OUT)
	protoc \
		--plugin=$(RULES_PLUGIN)/bazel-bin/firebase_rules_generator/protoc-gen-firebase_rules \
		--firebase_rules_out=$(RULES_OUT) \
		$(INC_IN_FILES)
	cd $(RULES_OUT) && find . -type f -name '*.pb.rules' -exec cat {} \; > firestore.rules
	cd $(RULES_OUT) && rm -rf google && find . -type f -name '*.pb.rules' -exec rm {} \;
ts:
	mkdir -p $(TS_OUT)
	protoc                               \
        --ts_proto_out=$(TS_OUT) \
		--ts_proto_opt=outputEncodeMethods=false,outputJsonMethods=false,outputClientImpl=false,snakeToCamel=false \
    	--plugin=/usr/local/bin/protoc-gen-ts_proto \
        $(INC_IN_FILES)
	protoc                               \
        $(INC) \
		--plugin=/usr/local/bin/protoc-gen-ts_proto \
		--ts_proto_out=$(TS_OUT) \
		--ts_proto_opt=snakeToCamel=false \
        $(PROTO_DIR)/google/protobuf/timestamp.proto \
		$(PROTO_DIR)/google/protobuf/struct.proto
install:
	pub global activate protoc_plugin
	cd typescript && npm i
	cd $(RULES_PLUGIN) && make
python:
	mkdir -p $(PYTHON_OUT)
	protoc -I=$(PYTHON_OUT) --python_out=$(PYTHON_OUT) $(INC_IN_FILES)
	mkdir -p ../admin_tools/protos
	cp -R $(PYTHON_OUT)/* ../admin_tools/protos
clean:
	rm -rf $(GEN_DIRS)
echo:
	echo $(PROTO_FILES)
# Comment out "repeated string end = 2;" in HoursWindow in firestore.proto when running this.
update_bq_views:
	make dart
	pub run bin/sql.dart
all: dart ts update_bq_views rules python

.PHONY: python