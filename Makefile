test:
	$(MAKE) -C cli-client test
	$(MAKE) -C back-end test

build:
	$(MAKE) -C cli-client build
	$(MAKE) -C back-end build

install:
	$(MAKE) -C cli-client install
	$(MAKE) -C back-end install
