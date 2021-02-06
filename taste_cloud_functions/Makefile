
SOURCEDIR := functions/lib functions/dart functions/js_functions
SRC := $(shell find $(SOURCEDIR) -name '*.dart' -o -name '*.js') functions/build.yaml functions/build.test.yaml
GEN_TEST := functions/build/gen-test
GEN_DEV := functions/build/gen-dev
GEN := functions/build/gen
PYTEST_ARGS?=
PYTHON?=python
PYTEST?=$(PYTHON) -m pytest
DEPLOY_ARGS?=
DEV_PROJECT=FIREBASE_DEV_PROJECT
PROD_PROJECT=FIREBASE_PROD_PROJECT
BUILT_FILE=functions/build/dart/index.dart.js
MAP_FILE=functions/build/dart/index.dart.js.map
EXPORT_DIR=export
EXPORT_FILE=$(EXPORT_DIR)/index.js
EXPORT_MAP_FILE=$(EXPORT_DIR)/index.dart.js.map
TEST_ARGS=

$(GEN_TEST): $(SRC)
	@rm -f $(GEN)
	@rm -f $(GEN_DEV)
	@echo "TEST BUILD"
	@cd functions && pub run build_runner build --output=build -c test
	@touch $(GEN_TEST)
	@make $(EXPORT_FILE)
	echo '{}' > $(EXPORT_DIR)/tsconfig.json

$(GEN_DEV): $(SRC)
	@rm -f $(GEN)
	@rm -f $(GEN_TEST)
	@echo "DEV BUILD"
	@cd functions && pub run build_runner build --output=build -c dev
	@touch $(GEN_DEV)
	@make $(EXPORT_FILE)

$(GEN): $(SRC)
	@rm -f $(GEN_DEV)
	@rm -f $(GEN_TEST)
	@echo "PROD BUILD"
	@cd functions && pub run build_runner build --output=build
	@touch $(GEN)
	@make $(EXPORT_FILE)

$(EXPORT_FILE): $(BUILT_FILE)
	rm -rf $(EXPORT_DIR)
	mkdir -p $(EXPORT_DIR)
	cp $(BUILT_FILE) $(EXPORT_FILE)
	cp $(MAP_FILE) $(EXPORT_MAP_FILE)
	cd $(EXPORT_DIR) && \
		ln -fs ../functions/node_modules . && \
		cp -rf ../functions/package* .  && \
		cp -rf ../functions/js_functions .

clean:
	rm -rf functions/build $(EXPORT_DIR)

clean-all: clean
	rm -rf                     \
		functions/node_modules \
		functions/.packages

test-python: $(GEN_TEST) $(EXPORT_FILE)
	cd functions/test && $(PYTEST) -s -v -x $(PYTEST_ARGS)

test-dart:
	cd functions && NODE_TASTE_ENV=test FIRESTORE_EMULATOR_HOST=localhost:8080 pub run test --timeout 120s -j 1 --debug -p node $(TEST_ARGS)

admin-dev:
	cd functions && NODE_TASTE_ENV=dev pub run test --timeout 120s -j 1 --debug -p node $(TEST_ARGS)
admin-prod:
	read -p "Are you sure? Hit Ctrl+c to leave now!\n"
	cd functions && NODE_TASTE_ENV=prod pub run test --timeout 120s -j 1 --debug -p node $(TEST_ARGS)

emulator: $(GEN_TEST) $(EXPORT_FILE)
	firebase -P $(DEV_PROJECT) emulators:start --only functions,firestore,pubsub,hosting

gen-test: $(GEN_TEST)

gen: $(GEN) 

gen-dev: $(GEN_DEV)

install: clean-all install-python

	@cd functions && npm install && pub get

install-python:
	pip3 install -r requirements.txt

.PHONY: clean test emulator gen-test gen deploy deploy-dev test-dart test-python

deploy-prod: $(GEN) $(EXPORT_FILE)
	firebase -P $(PROD_PROJECT) deploy  $(DEPLOY_ARGS)

deploy-dev: $(GEN_DEV) $(EXPORT_FILE)
	firebase -P $(DEV_PROJECT) deploy $(DEPLOY_ARGS)

deploy: deploy-prod deploy-dev

deploy-rules-dev:
	firebase deploy --only firestore:rules -P $(DEV_PROJECT)

deploy-rules-prod:
	firebase deploy --only firestore:rules -P $(PROD_PROJECT)

deploy-rules:
	@make deploy-rules-dev
	@make deploy-rules-prod

deploy-hosting:
	@make deploy-hosting-dev
	@make deploy-hosting-prod

deploy-hosting-dev:
	firebase -P $(DEV_PROJECT) deploy --only hosting

deploy-hosting-prod:
	firebase -P $(PROD_PROJECT) deploy --only hosting

deploy-moviemaker-dev:
	cd moviemaker && gcloud --project $(DEV_PROJECT) functions deploy moviemaker \
  		--runtime python37 \
		--memory 2048MB \
  		--trigger-event 'providers/cloud.firestore/eventTypes/document.create' \
  		--trigger-resource "projects/$(DEV_PROJECT)/databases/(default)/documents/movies/"'{movieid}'

deploy-moviemaker-prod:
	cd moviemaker && gcloud --project $(PROD_PROJECT) functions deploy moviemaker \
  		--runtime python37 \
		--memory 2048MB \
  		--trigger-event 'providers/cloud.firestore/eventTypes/document.create' \
  		--trigger-resource "projects/$(PROD_PROJECT)/databases/(default)/documents/movies/"'{movieid}'e

indexes-dev-to-prod:
	firebase firestore:indexes -P $(DEV_PROJECT) > firestore.indexes.json
	mv firebase.json firebase.tmp.json
	mv firebase.indexes.json firebase.json
	firebase -P $(PROD_PROJECT) deploy --only firestore:indexes --non-interactive
	mv firebase.json firebase.indexes.json
	mv firebase.tmp.json firebase.json
	rm firestore.indexes.json
gen-files:
	cd functions && pub run build_runner build -c gen
logs:
	tail -f functions/em-logs.txt

# Edit code in run_test_script.dart and then run this command.
run-test-script:
	cd functions && NODE_TASTE_ENV=test FIRESTORE_EMULATOR_HOST=localhost:8080 pub run test --timeout 120s -j 1 --debug -p node test/run_test_script.dart && cd ../

# Edit code in run_dev_script.dart and then run this command.
run-dev-script:
	cd functions && NODE_TASTE_ENV=dev pub run test --timeout 1200s -j 1 --debug -p node test/run_dev_script.dart && cd ../

# Edit code in run_prod_script.dart and then run this command.
run-prod-script:
	cd functions && NODE_TASTE_ENV=prod pub run test --timeout 72000s -j 1 --debug -p node test/run_prod_script.dart && cd ../