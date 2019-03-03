default: run

define log
  echo "\033[1;35m$(1)\033[0m"
endef

setup: setup-carla setup-compiler-explorer

run: setup
	@$(call log,Launch compiler-explorer.)
	@(cd $(CURDIR)/compiler-explorer && make)

setup-compiler-explorer:
	@$(call log,Setup compiler-explorer.)
	@if [ ! -d "$(CURDIR)/compiler-explorer" ]; then git clone https://github.com/mattgodbolt/compiler-explorer; fi
	@(cd $(CURDIR)/compiler-explorer && git pull)
	@sed -e 's|$${PWD}|$(CURDIR)|g' c++.local.properties > $(CURDIR)/compiler-explorer/etc/config/c++.local.properties

setup-carla:
	@$(call log,Setup carla.)
	@if [ ! -d "$(CURDIR)/carla" ]; then git clone https://github.com/carla-simulator/carla; fi
	@(cd $(CURDIR)/carla && git pull)
	@(cd $(CURDIR)/carla && make setup)
